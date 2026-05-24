# app/main.py
from __future__ import annotations
"""FastAPI application factory wiring routers and application services."""

import asyncio
import logging
import os
import time
from contextlib import asynccontextmanager

from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse

from app.api.admin.intent_mappings import router as admin_intent_mappings_router
from app.api.admin.services import router as admin_services_router
from app.api.admin.policies import router as admin_policies_router
from app.api.admin.metrics import router as admin_metrics_router
from app.api.admin.security_patterns import router as admin_security_patterns_router
from app.api.admin.gateway_plugins import router as admin_gateway_plugins_router
from app.api.admin.quotas_admin import router as admin_quotas_router
from app.api.admin.security_events_admin import router as admin_security_events_router
from app.api.admin.log_retention import router as admin_log_retention_router
from app.api.ai import router as ai_router
from app.api.governance import router as governance_router
from app.api.health import router as health_router
from app.core.config import settings
from app.core.error_handlers import register_error_handlers
from app.core.middleware import (
    CorrelationIdMiddleware,
    SecurityHeadersMiddleware,
    verify_kong_header,
)
from app.core.security import get_current_user
from app.core.logging import setup_logging
from app.infrastructure.ai_provider.ollama_client import chat as _, close_client as _close_ollama_client  # noqa: F401
from app.infrastructure.db.session import AsyncSessionLocal
from app.infrastructure.db.tenant_filters import register_tenant_orm_filters
from app.infrastructure.nlp.spacy_loader import get_nlp
from app.models.governance_policy import GovernancePolicy
from app.schemas.policy import PolicyFileSchema, PolicySchema, PolicyConditionSchema
from app.infrastructure.intent_classifier.client import IntentClassifierClient as _IntentClassifierClient
from app.services.ai_request_service import AIRequestService
from app.services.content_inspector_service import (
    ContentInspectorService,
    warmup_presidio_analyzer,
)
from app.services.intent_cache_service import IntentCacheService
from app.services.intent_mappings_service import IntentMappingsService
from app.services.output_guard_service import OutputGuardService
from app.services.policy_service import PolicyService
from app.services.prompt_security_service import (
    InjectionClassifier,
    PromptSecurityService,
)
from app.services.quota_service import QuotaService
from prometheus_fastapi_instrumentator import Instrumentator

setup_logging()
logger = logging.getLogger(__name__)


content_inspector_service = ContentInspectorService()
intent_cache_service = IntentCacheService(session_factory=AsyncSessionLocal)
policy_service = PolicyService()
quota_service = QuotaService(
    quotas_file=settings.quotas_file_path,
    redis_url=settings.redis_url
)
injection_classifier = InjectionClassifier()
prompt_security_service = PromptSecurityService(injection_classifier=injection_classifier)
output_guard_service = OutputGuardService()
# Shared persistent HTTP client — avoids a fresh TCP handshake on every classify call.
intent_classifier_client = _IntentClassifierClient()

register_tenant_orm_filters()


def _build_ai_request_service() -> AIRequestService:
    return AIRequestService(
        intent_cache_service=intent_cache_service,
        content_inspector_service=content_inspector_service,
        policy_service=policy_service,
        quota_service=quota_service,
        prompt_security_service=prompt_security_service,
        output_guard_service=output_guard_service,
        session_factory=AsyncSessionLocal,
        intent_classifier_client=intent_classifier_client,
    )


def _build_intent_mappings_service() -> IntentMappingsService:
    return IntentMappingsService(intent_cache_service=intent_cache_service)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Record startup time for the health check uptime calculation
    app.state.startup_time = time.time()
    # Seeding and Synchronization path
    import os
    import yaml
    from sqlalchemy import select
    from sqlalchemy.ext.asyncio import create_async_engine
    from app.models.base import Base
    import app.models  # ensure all model metadata is registered
    from app.infrastructure.db.session import ASYNC_DATABASE_URL

    # Auto-create all tables if they don't exist (fallback when Alembic hasn't run)
    engine = create_async_engine(ASYNC_DATABASE_URL)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    await engine.dispose()

    async with AsyncSessionLocal() as db:
        # Check if DB is empty
        result = await db.execute(select(GovernancePolicy).limit(1))
        if not result.scalar_one_or_none():
            policy_path = os.path.join(os.getcwd(), settings.policy_file_path)
            if os.path.exists(policy_path):
                logger.info("Seeding database with policies from %s", policy_path)
                with open(policy_path, "r", encoding="utf-8") as f:
                    data = yaml.safe_load(f)
                    if data and "policies" in data:
                        for p_data in data["policies"]:
                            db_policy = GovernancePolicy(
                                id=p_data.get("id"),
                                description=p_data.get("description"),
                                condition=p_data.get("condition"),
                                effect=p_data.get("effect"),
                                is_active=True,
                                version=data.get("version", "1.0.0")
                            )
                            db.add(db_policy)
                        await db.commit()
            else:
                logger.warning("No policy seed file found at %s", policy_path)

        # Sync in-memory cache from database
        await policy_service.sync_from_db(db)
        await prompt_security_service.reload_patterns(db)

    # Load DistilBERT injection classifier off the event loop (CPU / disk bound).
    _loop = asyncio.get_running_loop()
    await _loop.run_in_executor(None, injection_classifier.load)
    await _loop.run_in_executor(None, injection_classifier.score, "warmup")
    logger.info("[Startup] InjectionClassifier load and warm-up complete")

    # Fail fast if required external dependencies (spaCy model) are missing.
    _ = get_nlp()

    # Presidio defaults to en_core_web_lg and downloads on first analyze() unless
    # configured and warmed here (uses en_core_web_sm from the image).
    await _loop.run_in_executor(None, warmup_presidio_analyzer)

    # Initialize cache from DB.
    await intent_cache_service.initialize()

    # Start background refresh; cancel on shutdown.
    task = asyncio.create_task(intent_cache_service.start_background_refresh())
    try:
        yield
    finally:
        task.cancel()
        try:
            await task
        except asyncio.CancelledError:
            pass
        await intent_classifier_client.aclose()
        await _close_ollama_client()


def create_app() -> FastAPI:
    """Create the FastAPI application instance."""
    app = FastAPI(
        title="Kong AI Proxy Platform (FastAPI)",
        version="1.0.0",
        lifespan=lifespan,
    )

    app.state.intent_cache_service = intent_cache_service
    app.state.ai_request_service = _build_ai_request_service()
    app.state.intent_mappings_service = _build_intent_mappings_service()
    app.state.policy_service = policy_service
    app.state.quota_service = quota_service
    app.state.prompt_security_service = prompt_security_service

    # ── Middleware Stack (order matters: outermost first) ────────────────
    # 1. Security Headers — inject OWASP headers on every response
    app.add_middleware(SecurityHeadersMiddleware)

    # 2. Correlation ID — read from Kong or generate UUID, propagate to logs
    app.add_middleware(CorrelationIdMiddleware)

    # 3. CORS — must be after custom middleware for proper preflight handling
    cors_origins = [o.strip() for o in settings.cors_origin.split(",") if o.strip()]
    app.add_middleware(
        CORSMiddleware,
        allow_origins=cors_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # ── Global Error Handlers ───────────────────────────────────────────
    register_error_handlers(app)

    # ── API v1 Routers ──────────────────────────────────────────────────
    # All domain routers are versioned under /api/v1 for enterprise compatibility.
    # Backward-compatible /api/ redirect is provided below.
    app.include_router(ai_router, prefix="/api/v1")
    app.include_router(admin_intent_mappings_router, prefix="/api/v1")
    app.include_router(admin_services_router, prefix="/api/v1")
    app.include_router(admin_policies_router, prefix="/api/v1")
    app.include_router(admin_metrics_router, prefix="/api/v1")
    app.include_router(admin_security_patterns_router, prefix="/api/v1")
    app.include_router(admin_gateway_plugins_router, prefix="/api/v1")
    app.include_router(admin_quotas_router, prefix="/api/v1")
    app.include_router(admin_security_events_router, prefix="/api/v1")
    app.include_router(governance_router, prefix="/api/v1")
    app.include_router(admin_log_retention_router, prefix="/api/v1")

    # ── Unversioned Routes (Health + Metrics) ───────────────────────────
    # Health check and Prometheus metrics are intentionally unversioned.
    app.include_router(health_router, prefix="/api")

    # Instrument for Prometheus
    Instrumentator().instrument(app).expose(app)

    @app.get("/", tags=["Health"])
    async def root() -> dict:
        return {"message": "FastAPI AI Platform Backend is running. Access via /api/v1/"}

    @app.get("/api/", tags=["Health"])
    async def api_root() -> dict:
        return {
            "message": "Nextora AI Platform API",
            "current_version": "v1",
            "docs": "/docs",
            "health": "/api/health",
        }

    # ── /api/v1/documents — AI Prompt Template Library ──────────────────
    PROMPT_TEMPLATES = [
        {
            "id": "tpl-code-001",
            "title": "Python Function Generator",
            "category": "Code Generation",
            "icon": "💻",
            "description": "Generate a clean, documented Python function from a natural-language spec.",
            "prompt": "Write a Python function that {describe what it does}. Include type hints, a docstring, and at least two usage examples.",
            "tags": ["python", "functions", "best-practices"],
        },
        {
            "id": "tpl-code-002",
            "title": "REST API Endpoint Builder",
            "category": "Code Generation",
            "icon": "🔌",
            "description": "Scaffold a production-ready FastAPI or Express endpoint.",
            "prompt": "Create a {framework} REST API endpoint for {resource}. Include input validation, error handling, and response models.",
            "tags": ["api", "fastapi", "express", "rest"],
        },
        {
            "id": "tpl-code-003",
            "title": "SQL Query Optimizer",
            "category": "Code Generation",
            "icon": "🗄️",
            "description": "Turn a slow SQL query into an optimized version with explanations.",
            "prompt": "Optimize this SQL query for performance. Explain each change you make and suggest relevant indexes:\n\n{paste your SQL here}",
            "tags": ["sql", "database", "performance"],
        },
        {
            "id": "tpl-data-001",
            "title": "Dataset Summarizer",
            "category": "Data Analysis",
            "icon": "📊",
            "description": "Provide a statistical summary and key insights from raw data.",
            "prompt": "Analyze this dataset and provide: 1) Statistical summary, 2) Key patterns/anomalies, 3) Three actionable insights, 4) Recommended visualizations.\n\nData:\n{paste data here}",
            "tags": ["analytics", "statistics", "insights"],
        },
        {
            "id": "tpl-data-002",
            "title": "JSON Schema Generator",
            "category": "Data Analysis",
            "icon": "📋",
            "description": "Generate a strict JSON Schema from sample data.",
            "prompt": "Generate a JSON Schema (draft-07) from this sample JSON. Include descriptions, required fields, and format constraints:\n\n{paste JSON here}",
            "tags": ["json", "schema", "validation"],
        },
        {
            "id": "tpl-devops-001",
            "title": "Kubernetes Manifest Writer",
            "category": "DevOps",
            "icon": "☸️",
            "description": "Generate a production-ready K8s deployment, service, and ingress.",
            "prompt": "Create Kubernetes manifests (Deployment, Service, Ingress) for a {language} app named {name} with {replicas} replicas, {memory} memory limit, health checks, and resource quotas.",
            "tags": ["kubernetes", "k8s", "deployment", "infrastructure"],
        },
        {
            "id": "tpl-devops-002",
            "title": "Docker Multi-Stage Builder",
            "category": "DevOps",
            "icon": "🐳",
            "description": "Create an optimized multi-stage Dockerfile for minimal image size.",
            "prompt": "Write a multi-stage Dockerfile for a {language/framework} application. Optimize for: minimal final image size, layer caching, non-root user, and security best practices.",
            "tags": ["docker", "containers", "optimization"],
        },
        {
            "id": "tpl-sec-001",
            "title": "Security Audit Checklist",
            "category": "Security",
            "icon": "🛡️",
            "description": "Generate an OWASP-aligned security review for your code.",
            "prompt": "Perform a security audit of this code. Check for: injection vulnerabilities, authentication flaws, sensitive data exposure, broken access control, and misconfigurations. Provide severity ratings and fixes.\n\n{paste code here}",
            "tags": ["security", "owasp", "audit", "vulnerability"],
        },
        {
            "id": "tpl-write-001",
            "title": "Technical Documentation Writer",
            "category": "Writing",
            "icon": "📝",
            "description": "Transform code or architecture into clear technical documentation.",
            "prompt": "Write technical documentation for {component/system}. Include: Overview, Architecture, API Reference, Configuration, Deployment, and Troubleshooting sections.",
            "tags": ["documentation", "technical-writing", "readme"],
        },
        {
            "id": "tpl-write-002",
            "title": "Git Commit Message Crafter",
            "category": "Writing",
            "icon": "✍️",
            "description": "Generate Conventional Commits messages from a code diff.",
            "prompt": "Write a Conventional Commits message for this diff. Use the format: type(scope): description. Include a body explaining WHY, not just what.\n\nDiff:\n{paste diff here}",
            "tags": ["git", "conventional-commits", "workflow"],
        },
    ]

    @app.get(
        "/api/v1/documents",
        tags=["Prompt Library"],
        dependencies=[Depends(verify_kong_header)],
        summary="AI Prompt Template Library",
    )
    async def get_documents(
        user: dict = Depends(get_current_user),
        category: str | None = None,
    ) -> dict:
        """Browse curated prompt templates. Optionally filter by category."""
        email = user.get("email", "unknown")
        templates = PROMPT_TEMPLATES
        if category:
            templates = [t for t in templates if t["category"].lower() == category.lower()]

        categories = sorted(set(t["category"] for t in PROMPT_TEMPLATES))
        return {
            "message": "AI Prompt Template Library",
            "client": email,
            "total_templates": len(templates),
            "available_categories": categories,
            "data": templates,
        }

    # ── /api/v1/admin — Live Platform Intelligence Dashboard ─────────────
    import httpx as _httpx

    KONG_ADMIN_URL = os.getenv("KONG_ADMIN_URL", "http://kong-cp:8001")

    @app.get(
        "/api/v1/admin",
        tags=["Platform Intelligence"],
        dependencies=[Depends(verify_kong_header)],
        summary="Live Platform Intelligence Dashboard",
    )
    async def get_admin(user: dict = Depends(get_current_user)) -> dict:
        """Pull real-time metrics from Kong, PostgreSQL, and Redis."""
        email = user.get("email", "unknown")
        uptime_seconds = int(time.time() - app.state.startup_time)

        # ── Kong Gateway live stats ──────────────────────────────────────
        kong_stats = {"services": 0, "routes": 0, "plugins": 0, "status": "unreachable"}
        try:
            async with _httpx.AsyncClient(timeout=3) as client:
                svc_resp = await client.get(f"{KONG_ADMIN_URL}/services")
                rte_resp = await client.get(f"{KONG_ADMIN_URL}/routes")
                plg_resp = await client.get(f"{KONG_ADMIN_URL}/plugins")
                kong_stats = {
                    "services": len(svc_resp.json().get("data", [])),
                    "routes": len(rte_resp.json().get("data", [])),
                    "plugins": len(plg_resp.json().get("data", [])),
                    "status": "connected",
                }
        except Exception:
            logger.warning("[Admin] Could not reach Kong Admin API")

        # ── Database live stats ──────────────────────────────────────────
        db_stats: dict = {}
        try:
            async with AsyncSessionLocal() as session:
                from sqlalchemy import text as _text
                ai_req = await session.execute(_text("SELECT COUNT(*) FROM ai_requests"))
                sec_evt = await session.execute(_text("SELECT COUNT(*) FROM security_events"))
                policies = await session.execute(
                    _text("SELECT COUNT(*) FROM governance_policies WHERE is_active = true")
                )
                db_stats = {
                    "total_ai_requests": ai_req.scalar() or 0,
                    "security_events_logged": sec_evt.scalar() or 0,
                    "active_policies": policies.scalar() or 0,
                    "status": "connected",
                }
        except Exception as exc:
            logger.warning("[Admin] DB query failed: %s", exc)
            db_stats = {"status": "error", "detail": str(exc)}

        # ── Redis quota snapshot ─────────────────────────────────────────
        redis_stats: dict = {}
        try:
            quota_status = await quota_service.get_quota_status("acme-corp")
            redis_stats = {
                "tenant": "acme-corp",
                "tokens_used_today": quota_status.get("tokens_used", 0),
                "daily_limit": quota_status.get("daily_limit", 0),
                "remaining": quota_status.get("remaining", 0),
                "status": "connected",
            }
        except Exception as exc:
            logger.warning("[Admin] Redis quota query failed: %s", exc)
            redis_stats = {"status": "error", "detail": str(exc)}

        # ── Compose response ─────────────────────────────────────────────
        hours, remainder = divmod(uptime_seconds, 3600)
        minutes, secs = divmod(remainder, 60)

        return {
            "message": "Platform Intelligence Dashboard",
            "client": email,
            "platform": {
                "name": "Nextora AI Gateway",
                "version": "1.0.0",
                "environment": settings.environment,
                "uptime": f"{hours}h {minutes}m {secs}s",
                "uptime_seconds": uptime_seconds,
            },
            "kong_gateway": kong_stats,
            "database": db_stats,
            "quota_usage": redis_stats,
        }

    return app


app = create_app()
