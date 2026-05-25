# app/models/ai_service.py
"""ORM model for AI service definitions."""

from __future__ import annotations

import logging

from sqlalchemy import Boolean, Column, DateTime, String, Text, text
from sqlalchemy.sql import func

from app.models.base import Base

logger = logging.getLogger(__name__)


class AIService(Base):
    __tablename__ = "ai_services"

    service_id = Column(String, primary_key=True, index=True)
    model_name = Column(String, nullable=False)
    provider_url = Column(String, nullable=False)
    provider_type = Column(String, default="ollama")
    description = Column(Text, nullable=True)
    service_type = Column(String, default="on-prem")

    # ── Credentials & dispatch hints (used by openai_client) ───────────────
    api_key = Column(Text, nullable=True)
    auth_header = Column(String(64), nullable=True, default="Authorization")
    auth_scheme = Column(String(32), nullable=True, default="Bearer")

    # ── Protection / audit ─────────────────────────────────────────────────
    # Rows with is_protected=True cannot be mutated or deleted via the admin
    # CRUD endpoints. Reserved for built-in services (e.g. the gemini-cloud
    # Bard exploit) whose configuration the platform owns.
    is_protected = Column(
        Boolean, nullable=False, default=False, server_default=text("FALSE")
    )
    created_at = Column(
        DateTime(timezone=True), nullable=True, server_default=func.now()
    )
    updated_at = Column(
        DateTime(timezone=True),
        nullable=True,
        server_default=func.now(),
        onupdate=func.now(),
    )
