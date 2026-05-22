"""Environment-driven settings for the intent classifier service."""

from __future__ import annotations

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
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
