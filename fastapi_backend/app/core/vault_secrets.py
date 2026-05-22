"""vault_secrets.py — Load platform secrets from HashiCorp Vault KV v2.

Called once at startup by the Settings model validator.  Falls back silently
to empty dict when Vault is disabled or unreachable so existing env-var / .env
configuration continues to work unchanged.

Environment variables consumed:
    VAULT_ENABLED  — "true" to activate (any other value / missing → disabled)
    VAULT_ADDR     — Vault base URL, e.g. http://vault.ai-data.svc.cluster.local:8200
    VAULT_TOKEN    — Root/service-account token (dev-root-token in dev mode)
    VAULT_MOUNT    — KV v2 mount path (default: "secret")
"""

from __future__ import annotations

import logging
import os
import time
from typing import Any

logger = logging.getLogger(__name__)


def _read_kv2(client: Any, mount: str, path: str) -> dict[str, str]:
    """Read a KV v2 secret; return its data dict or {} on any error."""
    try:
        resp = client.secrets.kv.v2.read_secret_version(
            mount_point=mount,
            path=path,
            raise_on_deleted_version=True,
        )
        return resp["data"]["data"] or {}
    except Exception as exc:
        logger.warning("Vault: could not read %s/%s — %s", mount, path, exc)
        return {}


def load_vault_secrets() -> dict[str, str]:
    """Return a flat dict of secret overrides to inject into Settings.

    Keys match the *alias* names used by pydantic-settings (i.e. env-var names):
        DATABASE_URL  — FastAPI asyncpg connection string
        REDIS_URL     — Redis connection string with password
    """
    if os.environ.get("VAULT_ENABLED", "").lower() != "true":
        return {}

    vault_addr  = os.environ.get("VAULT_ADDR",  "http://vault.ai-data.svc.cluster.local:8200")
    vault_token = os.environ.get("VAULT_TOKEN", "dev-root-token")
    vault_mount = os.environ.get("VAULT_MOUNT", "secret")

    try:
        import hvac  # noqa: PLC0415 — deferred so the module is importable without hvac installed
    except ImportError:
        logger.warning("Vault: hvac not installed; skipping Vault secret load.")
        return {}

    try:
        client = hvac.Client(url=vault_addr, token=vault_token)
        if not client.is_authenticated():
            logger.warning("Vault: authentication failed (token may be invalid).")
            return {}
    except Exception as exc:
        logger.warning("Vault: cannot connect to %s — %s", vault_addr, exc)
        return {}

    overrides: dict[str, str] = {}

    # ── Platform Postgres ────────────────────────────────────────────────────
    pg = _read_kv2(client, vault_mount, "platform/postgres")
    if pg:
        db_url = (
            f"postgresql+asyncpg://{pg['user']}:{pg['password']}"
            f"@{pg['host']}:{pg['port']}/{pg['db']}"
        )
        overrides["PLATFORM_DB_URL"] = db_url
        logger.info("Vault: loaded PLATFORM_DB_URL from secret/platform/postgres")

    # ── Redis ────────────────────────────────────────────────────────────────
    redis = _read_kv2(client, vault_mount, "redis/platform")
    if redis:
        overrides["REDIS_URL"] = (
            f"redis://:{redis['password']}@redis.ai-data.svc.cluster.local:6379/0"
        )
        logger.info("Vault: loaded REDIS_URL from secret/redis/platform")

    if overrides:
        logger.info("Loaded %d secret(s) from Vault", len(overrides))
    return overrides


def check_vault_health() -> dict[str, Any]:
    """Probe Vault for the admin dashboard system-health badge.

    Returns a dict with:
        enabled   — whether VAULT_ENABLED is true
        status    — ok | warn | down | disabled  (for UI styling)
        label     — OK | WARN | DOWN | OFF       (short display text)
        latency_ms — round-trip to Vault when enabled
    """
    if os.environ.get("VAULT_ENABLED", "").lower() != "true":
        return {
            "enabled": False,
            "status": "disabled",
            "label": "OFF",
        }

    vault_addr = os.environ.get(
        "VAULT_ADDR", "http://vault.ai-data.svc.cluster.local:8200"
    )
    vault_token = os.environ.get("VAULT_TOKEN", "dev-root-token")
    vault_mount = os.environ.get("VAULT_MOUNT", "secret")

    start = time.monotonic()
    try:
        import hvac  # noqa: PLC0415
    except ImportError:
        return {
            "enabled": True,
            "status": "down",
            "label": "DOWN",
            "error": "hvac not installed",
        }

    try:
        client = hvac.Client(url=vault_addr, token=vault_token)
        if not client.is_authenticated():
            latency_ms = round((time.monotonic() - start) * 1000, 1)
            return {
                "enabled": True,
                "status": "down",
                "label": "DOWN",
                "latency_ms": latency_ms,
                "error": "authentication failed",
            }

        # Sys health: 200 = initialized and unsealed (dev server always 200)
        try:
            health = client.sys.read_health_status(method="GET")
            sealed = health.get("sealed", False)
            initialized = health.get("initialized", True)
        except Exception as health_exc:
            latency_ms = round((time.monotonic() - start) * 1000, 1)
            return {
                "enabled": True,
                "status": "down",
                "label": "DOWN",
                "latency_ms": latency_ms,
                "error": str(health_exc),
            }

        if sealed or not initialized:
            latency_ms = round((time.monotonic() - start) * 1000, 1)
            return {
                "enabled": True,
                "status": "warn",
                "label": "WARN",
                "latency_ms": latency_ms,
                "error": "sealed" if sealed else "not initialized",
            }

        pg = _read_kv2(client, vault_mount, "platform/postgres")
        redis = _read_kv2(client, vault_mount, "redis/platform")
        secrets_loaded = int(bool(pg)) + int(bool(redis))

        latency_ms = round((time.monotonic() - start) * 1000, 1)
        if secrets_loaded >= 2:
            return {
                "enabled": True,
                "status": "ok",
                "label": "OK",
                "latency_ms": latency_ms,
                "secrets_loaded": secrets_loaded,
            }
        return {
            "enabled": True,
            "status": "warn",
            "label": "WARN",
            "latency_ms": latency_ms,
            "secrets_loaded": secrets_loaded,
            "error": "expected KV secrets missing or incomplete",
        }
    except Exception as exc:
        latency_ms = round((time.monotonic() - start) * 1000, 1)
        logger.warning("Vault health probe failed: %s", exc)
        return {
            "enabled": True,
            "status": "down",
            "label": "DOWN",
            "latency_ms": latency_ms,
            "error": str(exc),
        }
