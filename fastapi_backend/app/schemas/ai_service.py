# app/schemas/ai_service.py
"""Schemas for AI service administrative operations."""

from __future__ import annotations

from datetime import datetime
from typing import Any, Optional

from pydantic import BaseModel, ConfigDict, Field, field_validator, model_validator


# ── Helpers ────────────────────────────────────────────────────────────────


def _mask_api_key(raw: Optional[str]) -> Optional[str]:
    """Render an API key as ``****abcd`` so the secret never leaves the server."""
    if not raw:
        return None
    tail = raw[-4:] if len(raw) >= 4 else raw
    return f"****{tail}"


# ── Create ─────────────────────────────────────────────────────────────────


class AIServiceCreateSchema(BaseModel):
    service_id: str = Field(..., min_length=1, max_length=255)
    model_name: str = Field(..., min_length=1, max_length=255)
    provider_url: str = Field(..., min_length=1, max_length=255)
    provider_type: str = Field(default="ollama", min_length=1, max_length=255)
    description: Optional[str] = None
    service_type: str = Field(default="on-prem", pattern=r"^(on-prem|cloud)$")

    api_key: Optional[str] = None
    auth_header: Optional[str] = Field(default="Authorization", max_length=64)
    auth_scheme: Optional[str] = Field(default="Bearer", max_length=32)

    @model_validator(mode="after")
    def _cloud_requires_api_key(self) -> "AIServiceCreateSchema":
        """Cloud services require an API key. Built-in protected rows are
        seeded directly in SQL, so admin-driven creates never hit this path
        for them — meaning every cloud service the admin creates must carry
        a key."""
        if self.service_type == "cloud" and not (self.api_key or "").strip():
            raise ValueError(
                "api_key is required when service_type='cloud'"
            )
        return self


# ── Update (PATCH semantics — all fields optional) ─────────────────────────


class AIServiceUpdateSchema(BaseModel):
    """Partial update payload. Backwards-compatible with the old
    ``{"service_type": "cloud"}`` quick-toggle body used by the frontend."""

    model_name: Optional[str] = Field(default=None, min_length=1, max_length=255)
    provider_url: Optional[str] = Field(default=None, min_length=1, max_length=255)
    provider_type: Optional[str] = Field(default=None, min_length=1, max_length=255)
    description: Optional[str] = None
    service_type: Optional[str] = Field(default=None, pattern=r"^(on-prem|cloud)$")

    api_key: Optional[str] = None
    auth_header: Optional[str] = Field(default=None, max_length=64)
    auth_scheme: Optional[str] = Field(default=None, max_length=32)

    @field_validator("api_key", mode="before")
    @classmethod
    def _empty_string_means_unchanged(cls, v: Any) -> Any:
        """An empty ``api_key`` field from the form means 'don't touch'.
        Use a sentinel (``None``) — actual rotation requires a non-empty
        value. Use ``"__clear__"`` to explicitly null out the key."""
        if v == "":
            return None
        return v


# ── Response (never echoes plaintext api_key) ──────────────────────────────


class AIServiceResponseSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    service_id: str
    model_name: str
    provider_url: str
    provider_type: str = "ollama"
    description: Optional[str] = None
    service_type: str = "on-prem"
    auth_header: Optional[str] = "Authorization"
    auth_scheme: Optional[str] = "Bearer"
    is_protected: bool = False
    api_key_masked: Optional[str] = None
    has_api_key: bool = False
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    @model_validator(mode="before")
    @classmethod
    def _project_api_key(cls, data: Any) -> Any:
        """Pull ``api_key`` off the ORM row and project it into the masked
        fields. The raw key is then discarded so it never appears in the
        serialised payload."""
        if hasattr(data, "api_key"):
            raw = getattr(data, "api_key", None)
            return {
                "service_id": data.service_id,
                "model_name": data.model_name,
                "provider_url": data.provider_url,
                "provider_type": getattr(data, "provider_type", "ollama"),
                "description": getattr(data, "description", None),
                "service_type": getattr(data, "service_type", "on-prem"),
                "auth_header": getattr(data, "auth_header", "Authorization"),
                "auth_scheme": getattr(data, "auth_scheme", "Bearer"),
                "is_protected": bool(getattr(data, "is_protected", False)),
                "api_key_masked": _mask_api_key(raw),
                "has_api_key": bool(raw),
                "created_at": getattr(data, "created_at", None),
                "updated_at": getattr(data, "updated_at", None),
            }
        return data
