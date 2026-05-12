# app/api/admin/log_retention.py
"""Admin API for log retention management.

Provides endpoints to:
  - View current log table sizes and row counts.
  - Trigger manual cleanup of old records with configurable retention periods.
  - Get retention policy configuration.

This is the API counterpart to the `cleanup_old_logs()` PostgreSQL function
defined in `backend/scripts/log-retention.sql`.
"""

from __future__ import annotations

import logging
from typing import Any, Dict, Optional

from fastapi import APIRouter, Depends
from pydantic import BaseModel, Field
from sqlalchemy import text

from app.core.middleware import verify_kong_header
from app.infrastructure.db.session import AsyncSessionLocal

logger = logging.getLogger(__name__)

router = APIRouter(
    prefix="/admin/log-retention",
    tags=["Admin - Log Retention"],
    dependencies=[Depends(verify_kong_header)],
)


# ── Schemas ─────────────────────────────────────────────────────────────────

class RetentionConfig(BaseModel):
    """Configurable retention periods (in days) per table category."""
    usage_days: int = Field(default=30, ge=1, le=365, description="api_usage_records retention")
    requests_days: int = Field(default=30, ge=1, le=365, description="ai_requests retention")
    tokens_days: int = Field(default=90, ge=1, le=365, description="usage_token_logs retention")
    security_days: int = Field(default=90, ge=1, le=365, description="security_events retention")
    policy_days: int = Field(default=60, ge=1, le=365, description="policy_evaluation_audit_logs retention")
    audit_days: int = Field(default=180, ge=1, le=365, description="permission + intent audit logs retention")


class CleanupResult(BaseModel):
    """Result of a cleanup operation for one table."""
    table_name: str
    rows_deleted: int


# ── Default retention policy ────────────────────────────────────────────────

DEFAULT_RETENTION = RetentionConfig()


# ── Endpoints ───────────────────────────────────────────────────────────────

@router.get("/table-stats")
async def get_table_stats() -> list[Dict[str, Any]]:
    """Get current row counts and sizes for all log tables.

    This helps administrators monitor storage growth and decide
    when cleanup is needed.
    """
    query = text("""
        SELECT
            relname AS table_name,
            n_live_tup AS estimated_rows,
            pg_size_pretty(pg_total_relation_size(C.oid)) AS total_size,
            pg_total_relation_size(C.oid) AS total_bytes
        FROM pg_class C
        JOIN pg_namespace N ON N.oid = C.relnamespace
        WHERE relname IN (
            'api_usage_records',
            'ai_requests',
            'usage_token_logs',
            'security_events',
            'policy_evaluation_audit_logs',
            'permission_audit_logs',
            'intent_mapping_audit_logs'
        )
        AND N.nspname = 'public'
        ORDER BY pg_total_relation_size(C.oid) DESC;
    """)

    async with AsyncSessionLocal() as session:
        result = await session.execute(query)
        rows = result.fetchall()

    total_bytes = sum(r.total_bytes for r in rows)

    return {
        "tables": [
            {
                "table_name": r.table_name,
                "estimated_rows": r.estimated_rows,
                "total_size": r.total_size,
                "total_bytes": r.total_bytes,
            }
            for r in rows
        ],
        "total_storage": {
            "bytes": total_bytes,
            "human_readable": _pretty_bytes(total_bytes),
        },
    }


@router.get("/policy")
async def get_retention_policy() -> Dict[str, Any]:
    """Get the current default retention policy configuration."""
    return {
        "retention_policy": DEFAULT_RETENTION.model_dump(),
        "description": {
            "usage_days": "Kong API access logs (api_usage_records)",
            "requests_days": "AI orchestration requests (ai_requests)",
            "tokens_days": "Token consumption logs (usage_token_logs)",
            "security_days": "Security events — blocks & redactions (security_events)",
            "policy_days": "Policy evaluation audit trail (policy_evaluation_audit_logs)",
            "audit_days": "Permission & intent mapping audit logs",
        },
    }


@router.post("/cleanup")
async def run_cleanup(
    config: Optional[RetentionConfig] = None,
) -> Dict[str, Any]:
    """Execute log cleanup using the PostgreSQL stored procedure.

    If no config is provided, uses the default retention periods.
    Pass a custom RetentionConfig to override retention periods.

    **This operation is irreversible.** Old records will be permanently deleted.
    """
    retention = config or DEFAULT_RETENTION

    logger.info(
        "[LogRetention] Starting cleanup with retention: usage=%dd, requests=%dd, "
        "tokens=%dd, security=%dd, policy=%dd, audit=%dd",
        retention.usage_days,
        retention.requests_days,
        retention.tokens_days,
        retention.security_days,
        retention.policy_days,
        retention.audit_days,
    )

    # Call the PostgreSQL stored procedure
    query = text("""
        SELECT table_name, rows_deleted
        FROM cleanup_old_logs(
            :usage_days,
            :requests_days,
            :tokens_days,
            :security_days,
            :policy_days,
            :audit_days
        );
    """)

    async with AsyncSessionLocal() as session:
        result = await session.execute(
            query,
            {
                "usage_days": retention.usage_days,
                "requests_days": retention.requests_days,
                "tokens_days": retention.tokens_days,
                "security_days": retention.security_days,
                "policy_days": retention.policy_days,
                "audit_days": retention.audit_days,
            },
        )
        await session.commit()
        rows = result.fetchall()

    cleanup_results = [
        {"table_name": r.table_name, "rows_deleted": r.rows_deleted}
        for r in rows
    ]
    total_deleted = sum(r.rows_deleted for r in rows)

    logger.info(
        "[LogRetention] Cleanup complete. Total rows deleted: %d", total_deleted
    )

    return {
        "status": "success",
        "total_rows_deleted": total_deleted,
        "retention_config": retention.model_dump(),
        "results": cleanup_results,
    }


# ── Helpers ─────────────────────────────────────────────────────────────────

def _pretty_bytes(n: int) -> str:
    """Convert bytes to human-readable format."""
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if abs(n) < 1024:
            return f"{n:.1f} {unit}"
        n /= 1024
    return f"{n:.1f} PB"
