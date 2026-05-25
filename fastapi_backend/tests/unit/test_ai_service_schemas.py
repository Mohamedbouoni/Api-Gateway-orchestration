"""Schema-level validation for ai_service create/update payloads."""

from __future__ import annotations

import pytest
from pydantic import ValidationError

from app.schemas.ai_service import (
    AIServiceCreateSchema,
    AIServiceResponseSchema,
    AIServiceUpdateSchema,
)


class _Row:
    """Lightweight stand-in for the SQLAlchemy ORM row that the response
    schema projects from."""

    def __init__(self, **fields):
        for k, v in fields.items():
            setattr(self, k, v)


# ── Create ────────────────────────────────────────────────────────────────


def test_cloud_service_requires_api_key() -> None:
    with pytest.raises(ValidationError) as exc:
        AIServiceCreateSchema(
            service_id="openai-gpt",
            model_name="gpt-4o-mini",
            provider_url="https://api.openai.com/v1/chat/completions",
            provider_type="openai",
            service_type="cloud",
        )
    assert "api_key" in str(exc.value)


def test_cloud_service_with_blank_api_key_rejected() -> None:
    with pytest.raises(ValidationError):
        AIServiceCreateSchema(
            service_id="openai-gpt",
            model_name="gpt-4o-mini",
            provider_url="https://api.openai.com/v1/chat/completions",
            provider_type="openai",
            service_type="cloud",
            api_key="   ",
        )


def test_cloud_service_accepts_valid_api_key() -> None:
    schema = AIServiceCreateSchema(
        service_id="openai-gpt",
        model_name="gpt-4o-mini",
        provider_url="https://api.openai.com/v1/chat/completions",
        provider_type="openai",
        service_type="cloud",
        api_key="sk-test-abcd1234",
    )
    assert schema.api_key == "sk-test-abcd1234"
    assert schema.auth_header == "Authorization"
    assert schema.auth_scheme == "Bearer"


def test_onprem_service_does_not_require_api_key() -> None:
    schema = AIServiceCreateSchema(
        service_id="ollama-local",
        model_name="llama3.2:3b",
        provider_url="http://host.docker.internal:11434/api/chat",
        provider_type="ollama",
        service_type="on-prem",
    )
    assert schema.api_key is None


# ── Update (partial PATCH) ────────────────────────────────────────────────


def test_update_schema_is_fully_partial() -> None:
    schema = AIServiceUpdateSchema(service_type="cloud")
    fields = schema.model_dump(exclude_unset=True)
    assert fields == {"service_type": "cloud"}


def test_update_schema_empty_api_key_means_unchanged() -> None:
    """The frontend always sends api_key='' when the field is left blank.
    We must treat that as 'don't touch', not as a clear."""
    schema = AIServiceUpdateSchema(api_key="")
    assert schema.api_key is None


def test_update_schema_rejects_unknown_service_type() -> None:
    with pytest.raises(ValidationError):
        AIServiceUpdateSchema(service_type="hybrid-cloud")


# ── Response (masks api_key) ──────────────────────────────────────────────


def test_response_masks_api_key_and_exposes_protection_flag() -> None:
    row = _Row(
        service_id="openai-gpt",
        model_name="gpt-4o",
        provider_url="https://api.openai.com/v1/chat/completions",
        provider_type="openai",
        description=None,
        service_type="cloud",
        api_key="sk-secret-xyzw",
        auth_header="Authorization",
        auth_scheme="Bearer",
        is_protected=False,
        created_at=None,
        updated_at=None,
    )
    resp = AIServiceResponseSchema.model_validate(row)
    payload = resp.model_dump()
    assert "api_key" not in payload, "raw api_key must never leave the server"
    assert payload["api_key_masked"] == "****xyzw"
    assert payload["has_api_key"] is True
    assert payload["is_protected"] is False


def test_response_for_service_without_api_key() -> None:
    row = _Row(
        service_id="ollama-llama3",
        model_name="llama3.2:3b",
        provider_url="http://host.docker.internal:11434/api/chat",
        provider_type="ollama",
        description="local",
        service_type="on-prem",
        api_key=None,
        auth_header="Authorization",
        auth_scheme="Bearer",
        is_protected=False,
        created_at=None,
        updated_at=None,
    )
    payload = AIServiceResponseSchema.model_validate(row).model_dump()
    assert payload["api_key_masked"] is None
    assert payload["has_api_key"] is False
