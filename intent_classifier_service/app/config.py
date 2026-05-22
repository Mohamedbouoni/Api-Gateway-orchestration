"""Environment-driven settings for the intent classifier service."""

from __future__ import annotations

import logging
import os

from pydantic import Field, model_validator
from pydantic_settings import BaseSettings, SettingsConfigDict

logger = logging.getLogger(__name__)


def _load_redis_from_vault() -> str | None:
    """Return a Redis URL built from Vault KV v2, or None if unavailable."""
    if os.environ.get("VAULT_ENABLED", "").lower() != "true":
        return None
    vault_addr  = os.environ.get("VAULT_ADDR",  "http://vault.ai-data.svc.cluster.local:8200")
    vault_token = os.environ.get("VAULT_TOKEN", "dev-root-token")
    vault_mount = os.environ.get("VAULT_MOUNT", "secret")
    try:
        import hvac  # noqa: PLC0415
        client = hvac.Client(url=vault_addr, token=vault_token)
        if not client.is_authenticated():
            logger.warning("Vault: authentication failed; using env REDIS_URL")
            return None
        resp = client.secrets.kv.v2.read_secret_version(
            mount_point=vault_mount, path="redis/platform", raise_on_deleted_version=True
        )
        pwd = resp["data"]["data"]["password"]
        redis_url = f"redis://:{pwd}@redis.ai-data.svc.cluster.local:6379/1"
        logger.info("Vault: loaded REDIS_URL from secret/redis/platform")
        return redis_url
    except Exception as exc:
        logger.warning("Vault: could not load REDIS_URL — %s", exc)
        return None


class Settings(BaseSettings):

    @model_validator(mode="before")
    @classmethod
    def _load_from_vault(cls, values: dict) -> dict:
        redis_url = _load_redis_from_vault()
        if redis_url and not values.get("REDIS_URL"):
            values["REDIS_URL"] = redis_url
        return values

    port: int = Field(default=3010, alias="PORT")
    redis_url: str = Field(default="redis://redis:6379/1", alias="REDIS_URL")
    taxonomy_path: str = Field(
        default="/app/intent_taxonomy/intent_labels_v1.yaml",
        alias="INTENT_TAXONOMY_PATH",
    )
    # hybrid = rules first, optional NLI; rules = deterministic only (fast deploy).
    classifier_backend: str = Field(default="hybrid", alias="CLASSIFIER_BACKEND")
    hf_zero_shot_model: str = Field(
        default="typeform/distilbert-base-uncased-mnli",
        alias="HF_ZERO_SHOT_MODEL",
    )
    hypothesis_template: str = Field(
        default="This is related to {}.",
        alias="HYPOTHESIS_TEMPLATE",
    )
    confidence_threshold: float | None = Field(
        default=None,
        alias="INTENT_CONFIDENCE_THRESHOLD",
        description="Override taxonomy threshold; NLI scores are typically 0.3–0.9",
    )
    # Optional LLM backend (Ollama) — only used when CLASSIFIER_BACKEND=llm
    llm_base_url: str = Field(
        default="http://host.docker.internal:11434/api/chat",
        alias="LLM_BASE_URL",
    )
    llm_model: str = Field(default="llama3", alias="LLM_MODEL")
    llm_timeout_seconds: float = Field(default=45.0, alias="LLM_TIMEOUT_SECONDS")
    cache_ttl_seconds: int = Field(default=3600, alias="INTENT_CLASSIFIER_CACHE_TTL_SECONDS")
    cache_max_entries: int = Field(default=10_000, alias="INTENT_CLASSIFIER_LRU_MAX")
    # Bump when backend/taxonomy changes to avoid serving stale Redis entries.
    cache_key_version: str = Field(default="v7-nli", alias="INTENT_CACHE_KEY_VERSION")
    flush_cache_on_start: bool = Field(default=True, alias="INTENT_CACHE_FLUSH_ON_START")

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")


settings = Settings()
