# app/api/ai.py
"""AI endpoints for submitting an intent-based AI request."""

from __future__ import annotations

import logging
from typing import Any, AsyncIterator, Dict

from fastapi import APIRouter, Depends, File, HTTPException, Request, Response, UploadFile
from fastapi.responses import StreamingResponse
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.dependencies import get_ai_request_service
from app.core.exceptions import (
    IntentNotFoundError,
    ProviderError,
    ServiceNotFoundError,
    TenantIdMissingError,
    TenantNotAuthorizedError,
    PolicyViolationError,
    QuotaExceededError,
    SecurityViolationError,
)
from app.core.middleware import verify_kong_header
from app.core.security import get_current_user
from app.infrastructure.db.session import get_db, get_db_with_user
from app.infrastructure.ai_provider.ollama_client import chat as ollama_chat  # noqa: F401
from app.infrastructure.nlp.spacy_loader import get_nlp
from app.schemas.ai_request import AIRequestSchema
from app.services.ai_request_service import AIRequestService
from app.services.file_extraction_service import FileExtractionService, FileExtractionError

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/ai", tags=["AI"])

# Singleton file extraction service
_file_extraction_service = FileExtractionService()


@router.post("/upload-file", dependencies=[Depends(verify_kong_header)])
async def upload_file(
    file: UploadFile = File(...),
    current_user: Dict[str, Any] = Depends(get_current_user),
) -> Dict[str, Any]:
    """Upload a file and extract its text content securely.

    The extracted text is returned to the client which can then include it
    as context in the next AI request. No file is stored on disk.
    """
    filename = file.filename or "unknown"
    content_type = file.content_type or "application/octet-stream"

    try:
        file_bytes = await file.read()

        # Validate file (size, extension, magic bytes)
        _file_extraction_service.validate_file(filename, content_type, file_bytes)

        # Extract text
        text, metadata = _file_extraction_service.extract_text(filename, file_bytes)

        logger.info(
            "[FileUpload] user=%s file=%s chars=%d",
            current_user.get("preferred_username", "unknown"),
            filename,
            len(text),
        )

        return {
            "success": True,
            "filename": filename,
            "extracted_text": text,
            "metadata": metadata,
        }

    except FileExtractionError as exc:
        raise HTTPException(status_code=422, detail=str(exc)) from exc
    except Exception as exc:
        logger.error("[FileUpload] Unexpected error: %s", exc)
        raise HTTPException(
            status_code=500,
            detail="Failed to process uploaded file.",
        ) from exc
    finally:
        await file.close()


@router.post("/request", dependencies=[Depends(verify_kong_header)])
async def submit_ai_request(
    body: AIRequestSchema,
    request: Request,
    response: Response,
    db: AsyncSession = Depends(get_db_with_user),
    current_user: Dict[str, Any] = Depends(get_current_user),
    nlp: Any = Depends(get_nlp),
    ai_request_service: AIRequestService = Depends(get_ai_request_service),
) -> Any:
    """Submit an intent-based AI request (SSE streaming or JSON fallback)."""

    wants_stream = "text/event-stream" in request.headers.get("Accept", "")

    try:
        if wants_stream:
            result = await ai_request_service.submit_stream(
                db=db,
                current_user=current_user,
                body=body,
                nlp=nlp,
            )
            request_id = result["request_id"]
            stream: AsyncIterator[str] = result["stream"]
            return StreamingResponse(
                stream,
                media_type="text/event-stream",
                headers={
                    "Cache-Control": "no-cache",
                    "X-Accel-Buffering": "no",
                    "Connection": "keep-alive",
                    "X-Request-ID": request_id,
                },
            )

        result = await ai_request_service.submit_json(
            db=db,
            current_user=current_user,
            body=body,
            nlp=nlp,
        )

        for k, v in result.get("response_headers", {}).items():
            response.headers[k] = str(v)

        return result.get("data")
    except IntentNotFoundError as exc:
        raise HTTPException(status_code=422, detail=str(exc)) from exc
    except ServiceNotFoundError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc
    except TenantIdMissingError as exc:
        raise HTTPException(status_code=401, detail=str(exc)) from exc
    except TenantNotAuthorizedError as exc:
        raise HTTPException(status_code=403, detail=str(exc)) from exc
    except PolicyViolationError as exc:
        raise HTTPException(
            status_code=403,
            detail={
                "message": str(exc),
                "policy_id": exc.policy_id,
                "description": exc.description,
                "pii_count": exc.pii_count,
                "detected_pii_types": exc.detected_pii_types,
            },
        ) from exc
    except SecurityViolationError as exc:
        # Do NOT leak `matched_patterns` to the client: the pattern identifiers
        # describe our internal detection regex catalog and would help an
        # attacker craft bypasses. Log them server-side for forensics only.
        logger.warning(
            "SecurityViolationError: patterns=%s pii_types=%s pii_count=%s",
            exc.matched_patterns,
            exc.detected_pii_types,
            exc.pii_count,
        )
        raise HTTPException(
            status_code=403,
            detail={
                "message": str(exc),
                "pii_count": exc.pii_count,
            },
        ) from exc
    except QuotaExceededError as exc:
        raise HTTPException(status_code=429, detail=str(exc)) from exc
    except ProviderError as exc:
        raise HTTPException(status_code=502, detail=str(exc)) from exc

