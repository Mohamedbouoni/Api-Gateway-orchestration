"""Protection guards on the ai_service repository write paths.

These tests use stubbed sessions because the repo's protection logic is
pure Python — it inspects the loaded row and raises BEFORE touching the DB.
We only need to confirm the guard fires; integration tests cover the real
SQL.
"""

from __future__ import annotations

import asyncio
from typing import Any
from unittest.mock import AsyncMock

import pytest

from app.repositories import ai_service_repository as repo
from app.repositories.ai_service_repository import (
    AIServiceProtectedError,
    delete_ai_service,
    update_ai_service,
)


class _StubSession:
    """Minimal AsyncSession stand-in for the protection-guard paths.

    The repo functions only call `get_ai_service_by_id` before deciding
    whether to raise, so we don't need a real session here."""

    def __init__(self) -> None:
        self.execute = AsyncMock()
        self.commit = AsyncMock()
        self.rollback = AsyncMock()
        self.add = AsyncMock()
        self.refresh = AsyncMock()


class _Row:
    def __init__(self, **fields: Any) -> None:
        for k, v in fields.items():
            setattr(self, k, v)


def test_update_refuses_protected_row(monkeypatch: pytest.MonkeyPatch) -> None:
    session = _StubSession()
    protected = _Row(
        service_id="gemini-cloud",
        is_protected=True,
        provider_type="gemini",
    )
    monkeypatch.setattr(
        repo, "get_ai_service_by_id", AsyncMock(return_value=protected)
    )

    with pytest.raises(AIServiceProtectedError):
        asyncio.run(
            update_ai_service(
                session, service_id="gemini-cloud", fields={"service_type": "on-prem"}
            )
        )
    session.execute.assert_not_awaited()
    session.commit.assert_not_awaited()


def test_delete_refuses_protected_row(monkeypatch: pytest.MonkeyPatch) -> None:
    session = _StubSession()
    protected = _Row(
        service_id="gemini-cloud",
        is_protected=True,
        provider_type="gemini",
    )
    monkeypatch.setattr(
        repo, "get_ai_service_by_id", AsyncMock(return_value=protected)
    )

    with pytest.raises(AIServiceProtectedError):
        asyncio.run(delete_ai_service(session, service_id="gemini-cloud"))
    session.execute.assert_not_awaited()
    session.commit.assert_not_awaited()


def test_update_returns_none_for_missing_row(monkeypatch: pytest.MonkeyPatch) -> None:
    session = _StubSession()
    monkeypatch.setattr(
        repo, "get_ai_service_by_id", AsyncMock(return_value=None)
    )

    result = asyncio.run(
        update_ai_service(
            session, service_id="ghost", fields={"service_type": "cloud"}
        )
    )
    assert result is None


def test_delete_returns_false_for_missing_row(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    session = _StubSession()
    monkeypatch.setattr(
        repo, "get_ai_service_by_id", AsyncMock(return_value=None)
    )

    deleted = asyncio.run(delete_ai_service(session, service_id="ghost"))
    assert deleted is False
