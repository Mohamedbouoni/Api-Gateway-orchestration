"""FastAPI app: POST /classify, health probes, Prometheus metrics."""

from __future__ import annotations

import logging
import re
from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI, HTTPException
from prometheus_fastapi_instrumentator import Instrumentator

from app.cache_layer import ClassificationCache
from app.classify_pipeline import classify_text
from app.config import settings
from app.nli_classifier import NLIClassifier
from app.rule_classifier import RuleBasedClassifier
from app.schemas import ClassifyRequest, ClassifyResponse
from app.taxonomy import UNCLASSIFIED, load_taxonomy

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

_ws_re = re.compile(r"\s+")
_url_only_re = re.compile(r"https?://\S+$")


def normalize_text(text: str) -> str:
    t = text.strip().lower()
    return _ws_re.sub(" ", t)


def _resolve_taxonomy_path() -> str:
    p = Path(settings.taxonomy_path)
    if p.is_file():
        return str(p.resolve())
    alt = Path(__file__).resolve().parents[2] / "intent_taxonomy" / "intent_labels_v1.yaml"
    if alt.is_file():
        return str(alt)
    return settings.taxonomy_path


def _fallback_response(taxonomy_version: str, model_id: str) -> ClassifyResponse:
    return ClassifyResponse(
        intent_label=UNCLASSIFIED,
        confidence=0.0,
        source="fallback",
        taxonomy_version=taxonomy_version,
        model_id=model_id,
    )


def _map_source_to_response(source: str) -> str:
    """API source field: rules/heuristic → model for contract compatibility."""
    if source in ("rules", "heuristic", "model"):
        return "model"
    return source


@asynccontextmanager
async def lifespan(app: FastAPI):
    taxonomy_path = _resolve_taxonomy_path()
    taxonomy = load_taxonomy(taxonomy_path)
    app.state.taxonomy = taxonomy

    backend = (settings.classifier_backend or "hybrid").strip().lower()
    if backend == "llm":
        logger.warning(
            "CLASSIFIER_BACKEND=llm is deprecated (Ollama unreliable in K8s). Using hybrid."
        )
        backend = "hybrid"
    app.state.backend = backend

    app.state.rules = RuleBasedClassifier(candidate_labels=taxonomy.candidate_labels)
    app.state.nli_classifier = None
    model_id = "intent-rules-v1"
    fingerprint = "rules-v2"

    if backend in ("hybrid", "nli"):
        threshold = (
            settings.confidence_threshold
            if settings.confidence_threshold is not None
            else taxonomy.confidence_threshold
        )
        try:
            nli = NLIClassifier(
                taxonomy=taxonomy,
                model_name=settings.hf_zero_shot_model,
                hypothesis_template=settings.hypothesis_template,
                confidence_threshold=threshold,
            )
            nli.load()
            app.state.nli_classifier = nli
            model_id = settings.hf_zero_shot_model
            fingerprint = nli.fingerprint_hash
            logger.info("NLI model loaded (threshold=%.2f)", threshold)
        except Exception as exc:
            logger.warning("NLI unavailable; rules-only mode: %s", exc)

    cache_labels = taxonomy.candidate_labels + taxonomy.nli_phrases
    app.state.cache = ClassificationCache(
        redis_url=settings.redis_url,
        model_id=model_id,
        labels_tuple=cache_labels,
        system_instruction_hash=fingerprint,
        cache_key_version=settings.cache_key_version,
        ttl_seconds=settings.cache_ttl_seconds,
        lru_max=settings.cache_max_entries,
    )
    await app.state.cache.connect()
    if settings.flush_cache_on_start:
        await app.state.cache.flush_all()

    logger.info(
        "Intent classifier ready taxonomy=v%s backend=%s nli=%s cache=%s",
        taxonomy.version,
        backend,
        app.state.nli_classifier is not None,
        settings.cache_key_version,
    )
    yield
    await app.state.cache.close()


app = FastAPI(title="Intent Classifier", lifespan=lifespan)
Instrumentator().instrument(app).expose(app)


@app.get("/healthz")
async def healthz() -> dict:
    return {
        "status": "ok",
        "backend": getattr(app.state, "backend", "hybrid"),
        "nli_loaded": getattr(app.state, "nli_classifier", None) is not None,
    }


@app.get("/readyz")
async def readyz() -> dict:
    if not getattr(app.state, "rules", None):
        raise HTTPException(status_code=503, detail="rules engine not loaded")
    return {
        "status": "ready",
        "backend": getattr(app.state, "backend", "hybrid"),
        "nli_loaded": app.state.nli_classifier is not None,
    }


@app.post("/classify", response_model=ClassifyResponse)
async def classify(body: ClassifyRequest) -> ClassifyResponse:
    text_raw = body.text.strip()
    text_norm = normalize_text(body.text)
    model_id = getattr(app.state.cache, "_fingerprint_hash", "intent-rules-v1")

    if (not text_raw) or (len(text_raw) < 3) or bool(_url_only_re.fullmatch(text_raw)):
        return _fallback_response(app.state.taxonomy.version, "intent-rules-v1")

    cached = await app.state.cache.get(text_norm, tenant_id=body.tenant_id)
    if cached is not None:
        return cached

    result = await classify_text(
        text_raw,
        taxonomy=app.state.taxonomy,
        rules=app.state.rules,
        nli=app.state.nli_classifier,
    )

    intent = str(result.get("intent", UNCLASSIFIED))
    if intent not in set(app.state.taxonomy.candidate_labels) | {UNCLASSIFIED}:
        intent = UNCLASSIFIED

    api_source = _map_source_to_response(str(result.get("source", "model")))
    response = ClassifyResponse(
        intent_label=intent,
        confidence=float(result.get("confidence", 0.0)),
        source=api_source,
        taxonomy_version=app.state.taxonomy.version,
        model_id=model_id if app.state.nli_classifier else "intent-rules-v1",
    )
    await app.state.cache.set(text_norm, response, tenant_id=body.tenant_id)
    logger.info(
        "classify intent=%s confidence=%.2f internal_source=%s",
        intent,
        response.confidence,
        result.get("source"),
    )
    return response
