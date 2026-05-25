# app/api/admin/services.py
"""Admin endpoints for managing AI services."""

from __future__ import annotations

import logging
from typing import Any, Dict, List

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.middleware import verify_kong_header
from app.core.security import require_admin
from app.infrastructure.db.session import get_db_with_user
from app.repositories.ai_service_repository import (
    AIServiceAlreadyExistsError,
    AIServiceInUseError,
    AIServiceProtectedError,
    create_ai_service,
    delete_ai_service,
    list_ai_services,
    update_ai_service,
)
from app.schemas.ai_service import (
    AIServiceCreateSchema,
    AIServiceResponseSchema,
    AIServiceUpdateSchema,
)

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/service-governance", tags=["Admin - Services"])


@router.get(
    "",
    response_model=List[AIServiceResponseSchema],
    dependencies=[Depends(verify_kong_header)],
)
async def get_services(
    db: AsyncSession = Depends(get_db_with_user),
    admin_user: Dict[str, Any] = Depends(require_admin),
) -> List[AIServiceResponseSchema]:
    _ = admin_user
    return await list_ai_services(db)


@router.post(
    "",
    response_model=AIServiceResponseSchema,
    status_code=status.HTTP_201_CREATED,
    dependencies=[Depends(verify_kong_header)],
)
async def create_service(
    payload: AIServiceCreateSchema,
    db: AsyncSession = Depends(get_db_with_user),
    admin_user: Dict[str, Any] = Depends(require_admin),
) -> AIServiceResponseSchema:
    _ = admin_user
    fields = payload.model_dump()
    try:
        service = await create_ai_service(db, **fields)
    except AIServiceAlreadyExistsError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"Service '{payload.service_id}' already exists",
        ) from exc
    logger.info("admin created ai_service service_id=%s", service.service_id)
    return service


@router.patch(
    "/{service_id}",
    response_model=AIServiceResponseSchema,
    dependencies=[Depends(verify_kong_header)],
)
async def update_service(
    service_id: str,
    payload: AIServiceUpdateSchema,
    db: AsyncSession = Depends(get_db_with_user),
    admin_user: Dict[str, Any] = Depends(require_admin),
) -> AIServiceResponseSchema:
    _ = admin_user
    fields = payload.model_dump(exclude_unset=True)
    try:
        service = await update_ai_service(db, service_id=service_id, fields=fields)
    except AIServiceProtectedError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc

    if service is None:
        raise HTTPException(status_code=404, detail="Service not found")
    logger.info(
        "admin updated ai_service service_id=%s fields=%s",
        service_id,
        sorted(fields.keys()),
    )
    return service


@router.delete(
    "/{service_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    dependencies=[Depends(verify_kong_header)],
)
async def remove_service(
    service_id: str,
    db: AsyncSession = Depends(get_db_with_user),
    admin_user: Dict[str, Any] = Depends(require_admin),
) -> None:
    _ = admin_user
    try:
        deleted = await delete_ai_service(db, service_id=service_id)
    except AIServiceProtectedError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc
    except AIServiceInUseError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc
    if not deleted:
        raise HTTPException(status_code=404, detail="Service not found")
    logger.info("admin deleted ai_service service_id=%s", service_id)
