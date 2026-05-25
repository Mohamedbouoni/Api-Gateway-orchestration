"""Provider dispatcher routes each service shape to the right HTTP client.

The dispatcher lives at :meth:`AIRequestService._dispatch_provider_stream`
and :meth:`AIRequestService._dispatch_provider_json`. It must:

* keep routing ``ollama`` providers to ``ollama_client.chat``
* keep routing the **protected** built-in ``gemini-cloud`` row to the
  Bard scrape path (``_call_gemini_*``)
* route every other provider_type (including non-protected ``gemini``
  rows and free-form admin-created services) through the generic
  OpenAI-compatible client, forwarding ``api_key`` /
  ``auth_header`` / ``auth_scheme`` from the row.
"""

from __future__ import annotations

import asyncio
from dataclasses import dataclass
from typing import Any, Dict, Optional
from unittest.mock import MagicMock

from app.services.ai_request_service import AIRequestService
from app.services.output_guard_service import OutputGuardService


@dataclass
class _FakeService:
    model_name: str = "test-model"
    provider_url: str = "http://example/chat"
    provider_type: str = "ollama"
    service_type: str = "on-prem"
    api_key: Optional[str] = None
    auth_header: str = "Authorization"
    auth_scheme: str = "Bearer"
    is_protected: bool = False


def _make_service() -> AIRequestService:
    return AIRequestService(
        intent_cache_service=object(),
        content_inspector_service=object(),
        policy_service=object(),
        quota_service=object(),
        prompt_security_service=object(),
        output_guard_service=OutputGuardService(),
        session_factory=lambda: MagicMock(),
    )


def test_ollama_routes_to_ollama_client(monkeypatch) -> None:
    captured: Dict[str, Any] = {}

    async def _fake_ollama(**kwargs: Any) -> Dict[str, Any]:
        captured.update(kwargs)
        return {"message": {"content": "ok"}, "usage": {}}

    import app.services.ai_request_service as ars

    monkeypatch.setattr(ars, "ollama_chat", _fake_ollama)
    monkeypatch.setattr(
        ars,
        "openai_chat",
        MagicMock(side_effect=AssertionError("openai_chat should NOT be called for ollama")),
    )

    svc = _make_service()
    result = asyncio.run(
        svc._dispatch_provider_json(
            service=_FakeService(provider_type="ollama"),
            messages=[{"role": "user", "content": "hi"}],
        )
    )

    assert captured["stream"] is False
    assert captured["provider_url"] == "http://example/chat"
    assert captured["model"] == "test-model"
    assert result["message"]["content"] == "ok"


def test_protected_gemini_uses_bard_path(monkeypatch) -> None:
    """The built-in gemini-cloud row keeps using the Bard scrape — even
    after the dispatcher refactor."""
    bard_called: Dict[str, Any] = {}

    svc = _make_service()

    async def _fake_bard(**kwargs: Any) -> Dict[str, Any]:
        bard_called.update(kwargs)
        return {"message": {"content": "bard"}, "usage": {}}

    monkeypatch.setattr(svc, "_call_gemini_json", _fake_bard)

    import app.services.ai_request_service as ars

    monkeypatch.setattr(
        ars,
        "openai_chat",
        MagicMock(side_effect=AssertionError("openai_chat must not be called for protected gemini")),
    )
    monkeypatch.setattr(
        ars,
        "ollama_chat",
        MagicMock(side_effect=AssertionError("ollama_chat must not be called for protected gemini")),
    )

    result = asyncio.run(
        svc._dispatch_provider_json(
            service=_FakeService(
                provider_type="gemini", service_type="cloud", is_protected=True
            ),
            messages=[{"role": "user", "content": "hi"}],
        )
    )

    assert bard_called["provider_url"] == "http://example/chat"
    assert result["message"]["content"] == "bard"


def test_unprotected_gemini_falls_through_to_openai_client(monkeypatch) -> None:
    """A non-protected ``provider_type='gemini'`` row is an admin-managed
    Gemini-API service. It must hit the generic OpenAI-spec client with
    the configured api_key/header/scheme."""
    captured: Dict[str, Any] = {}

    async def _fake_openai(**kwargs: Any) -> Dict[str, Any]:
        captured.update(kwargs)
        return {"message": {"content": "gemini-api"}, "usage": {}}

    import app.services.ai_request_service as ars

    monkeypatch.setattr(ars, "openai_chat", _fake_openai)
    monkeypatch.setattr(
        ars,
        "ollama_chat",
        MagicMock(side_effect=AssertionError("ollama_chat must not be called")),
    )

    svc = _make_service()
    monkeypatch.setattr(
        svc,
        "_call_gemini_json",
        MagicMock(side_effect=AssertionError("Bard path must not run for non-protected gemini rows")),
    )

    result = asyncio.run(
        svc._dispatch_provider_json(
            service=_FakeService(
                provider_type="gemini",
                service_type="cloud",
                is_protected=False,
                api_key="AIza-key",
                auth_header="x-goog-api-key",
                auth_scheme="",
            ),
            messages=[{"role": "user", "content": "hi"}],
        )
    )

    assert captured["api_key"] == "AIza-key"
    assert captured["auth_header"] == "x-goog-api-key"
    assert captured["auth_scheme"] == ""
    assert captured["model"] == "test-model"
    assert result["message"]["content"] == "gemini-api"


def test_custom_provider_type_routes_to_openai_client(monkeypatch) -> None:
    """Any free-form provider_type ('openai', 'anthropic', 'custom-vendor')
    should route through the OpenAI-compatible client."""
    seen_provider_types = []

    async def _fake_openai(**kwargs: Any) -> Dict[str, Any]:
        seen_provider_types.append(kwargs.get("provider_url"))
        return {"message": {"content": ""}, "usage": {}}

    import app.services.ai_request_service as ars

    monkeypatch.setattr(ars, "openai_chat", _fake_openai)

    svc = _make_service()

    for ptype in ("openai", "anthropic", "totally-custom-vendor"):
        asyncio.run(
            svc._dispatch_provider_json(
                service=_FakeService(
                    provider_type=ptype,
                    service_type="cloud",
                    api_key="sk-xyz",
                    provider_url=f"http://{ptype}.example/v1/chat",
                ),
                messages=[{"role": "user", "content": "hi"}],
            )
        )

    assert seen_provider_types == [
        "http://openai.example/v1/chat",
        "http://anthropic.example/v1/chat",
        "http://totally-custom-vendor.example/v1/chat",
    ]
