# app/repositories/ai_service_repository.py
"""SQLAlchemy queries for AI service definitions."""

from __future__ import annotations

import logging
from typing import Any, Dict, List, Optional

from sqlalchemy import delete, select, update
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import AIService

logger = logging.getLogger(__name__)


# ── Custom exceptions surfaced to the HTTP layer ────────────────────────────


class AIServiceProtectedError(Exception):
    """Raised when an admin tries to mutate or delete a row whose
    ``is_protected`` flag is ``True`` (e.g. the gemini-cloud Bard exploit)."""


class AIServiceAlreadyExistsError(Exception):
    """Raised when creating a service whose ``service_id`` already exists."""


class AIServiceInUseError(Exception):
    """Raised when deleting a service that is still referenced by an
    ``intent_routing`` row."""


# ── Reads ───────────────────────────────────────────────────────────────────


async def get_ai_service_by_id(session: AsyncSession, service_id: str) -> Optional[AIService]:
    """Fetch an AI service record by its service_id."""
    result = await session.execute(select(AIService).where(AIService.service_id == service_id))
    return result.scalars().first()


async def list_ai_services(session: AsyncSession) -> List[AIService]:
    """Fetch all AI services."""
    result = await session.execute(select(AIService).order_by(AIService.service_id))
    return list(result.scalars().all())


# ── Writes ──────────────────────────────────────────────────────────────────


async def create_ai_service(session: AsyncSession, **fields: Any) -> AIService:
    """Insert a new AI service row. Raises :class:`AIServiceAlreadyExistsError`
    on duplicate ``service_id``."""
    service = AIService(**fields)
    session.add(service)
    try:
        await session.commit()
    except IntegrityError as exc:
        await session.rollback()
        logger.info("create_ai_service duplicate service_id=%s", fields.get("service_id"))
        raise AIServiceAlreadyExistsError(str(exc)) from exc

    await session.refresh(service)
    return service


async def update_ai_service(
    session: AsyncSession, *, service_id: str, fields: Dict[str, Any]
) -> Optional[AIService]:
    """Partial-update an AI service.

    - Returns ``None`` if the row doesn't exist.
    - Raises :class:`AIServiceProtectedError` when the row is locked.
    - ``api_key`` semantics:
        * key missing from ``fields`` → unchanged
        * value ``"__clear__"`` → set NULL (rotation/removal)
        * any other string → stored verbatim
    """
    existing = await get_ai_service_by_id(session, service_id)
    if existing is None:
        return None
    if existing.is_protected:
        raise AIServiceProtectedError(
            f"Service '{service_id}' is protected and cannot be modified"
        )

    if not fields:
        return existing

    payload: Dict[str, Any] = dict(fields)
    if "api_key" in payload and payload["api_key"] == "__clear__":
        payload["api_key"] = None

    stmt = (
        update(AIService)
        .where(AIService.service_id == service_id)
        .values(**payload)
        .returning(AIService)
    )
    result = await session.execute(stmt)
    await session.commit()
    return result.scalars().first()


async def update_ai_service_type(
    session: AsyncSession, *, service_id: str, service_type: str
) -> Optional[AIService]:
    """Backward-compatible thin wrapper around :func:`update_ai_service`.
    Kept so older callers and tests don't break."""
    return await update_ai_service(
        session, service_id=service_id, fields={"service_type": service_type}
    )


async def delete_ai_service(session: AsyncSession, *, service_id: str) -> bool:
    """Delete an AI service.

    - Returns ``False`` if no row matched.
    - Raises :class:`AIServiceProtectedError` for locked rows.
    - Raises :class:`AIServiceInUseError` if an intent_routing FK still
      references the service.
    """
    existing = await get_ai_service_by_id(session, service_id)
    if existing is None:
        return False
    if existing.is_protected:
        raise AIServiceProtectedError(
            f"Service '{service_id}' is protected and cannot be deleted"
        )

    stmt = delete(AIService).where(AIService.service_id == service_id)
    try:
        await session.execute(stmt)
        await session.commit()
    except IntegrityError as exc:
        await session.rollback()
        logger.info("delete_ai_service blocked by FK service_id=%s", service_id)
        raise AIServiceInUseError(
            f"Service '{service_id}' is still referenced by intent routing rules"
        ) from exc
    return True
