# fastapi_backend/tests/unit/test_ai_request_gemini_quota.py
"""Gemini/cloud providers must decrement tenant quotas like Ollama does."""

from __future__ import annotations

import asyncio
from dataclasses import dataclass, field
from typing import Any, Dict, List

import pytest

from app.schemas.ai_request import SensitivityLevel
from app.services.ai_request_service import AIRequestService, _PreFlightResult
from app.services.output_guard_service import OutputGuardService


@dataclass
class _TrackingQuota:
    increments: List[int] = field(default_factory=list)

    async def check_quota(self, *_: Any, **__: Any) -> bool:
        return True

    async def increment_usage(self, _tenant_id: str, tokens: int) -> None:
        self.increments.append(tokens)

    async def get_quota_status(self, *_: Any, **__: Any) -> Dict[str, Any]:
        return {"used": sum(self.increments), "limit": 100, "remaining": 100 - sum(self.increments)}


@dataclass
class _GeminiService:
    model_name: str = "gemini-pro"
    provider_url: str = "https://gemini.example/generate"
    provider_type: str = "gemini"
    service_type: str = "cloud"


class _NoopSession:
    async def __aenter__(self) -> "_NoopSession":
        return self

    async def __aexit__(self, *_: Any) -> None:
        return None

    async def execute(self, *_: Any, **__: Any) -> None:
        return None

    def add(self, *_: Any, **__: Any) -> None:
        return None

    async def commit(self) -> None:
        return None


def _make_service(quota: _TrackingQuota) -> AIRequestService:
    return AIRequestService(
        intent_cache_service=object(),
        content_inspector_service=object(),
        policy_service=object(),
        quota_service=quota,
        prompt_security_service=object(),
        output_guard_service=OutputGuardService(),
        session_factory=lambda: _NoopSession(),
    )


def _pre_flight(service: _GeminiService) -> _PreFlightResult:
    return _PreFlightResult(
        request_id="req-gemini-1",
        tenant_id="tenant-a",
        provided_intent="general",
        intent_name="general_chat",
        intent_mode="manual",
        intent_confidence=None,
        intent_source=None,
        intent_taxonomy_version=None,
        resolved_service_id="gemini-cloud",
        service=service,
        final_sensitivity=SensitivityLevel.LOW,
        detected_pii_types=[],
        pii_count=0,
        messages=[{"role": "user", "content": "Hello there"}],
    )


def test_gemini_json_increments_quota(monkeypatch: pytest.MonkeyPatch) -> None:
    quota = _TrackingQuota()
    service = _make_service(quota)
    pf = _pre_flight(_GeminiService())

    async def _mock_pre_flight(**_: Any) -> _PreFlightResult:
        return pf

    async def _noop_status(**_: Any) -> None:
        return None

    async def _gemini_json(**_: Any) -> Dict[str, Any]:
        return {
            "message": {"role": "assistant", "content": "Hi back"},
            "usage": {},
        }

    service._run_pre_flight = _mock_pre_flight  # type: ignore[assignment]
    service._update_status_in_new_session = _noop_status  # type: ignore[assignment]
    monkeypatch.setattr(service, "_call_gemini_json", _gemini_json)

    result = asyncio.run(
        service.submit_json(
            db=None,
            current_user={"tenant_id": "tenant-a"},
            body=None,
            nlp=None,
        )
    )

    assert quota.increments, "expected quota increment for Gemini JSON request"
    assert quota.increments[0] > 0
    assert result["data"]["quota"]["used"] == quota.increments[0]


def test_estimate_token_usage_counts_prompt_and_response() -> None:
    usage = AIRequestService._estimate_token_usage(
        [{"role": "user", "content": "abcd"}],
        "efgh",
    )
    assert usage["prompt_eval_count"] == 1
    assert usage["eval_count"] == 1
