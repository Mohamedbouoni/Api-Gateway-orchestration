from __future__ import annotations

import asyncio
import time
from unittest.mock import AsyncMock, patch

import pytest
from fastapi import HTTPException
from starlette.requests import Request

from app.core.gateway_signature import (
    gateway_compute_signature,
    gateway_verify_signature,
)
from app.core.middleware import verify_kong_header


SECRET = "test-gateway-secret"


def _build_request(
    *,
    method: str = "POST",
    path: str = "/api/v1/ai/request",
    headers: dict[str, str] | None = None,
) -> Request:
    header_lines = [f"{key.lower()}: {value}" for key, value in (headers or {}).items()]
    raw = (
        f"{method} {path} HTTP/1.1\r\n"
        + "\r\n".join(header_lines)
        + ("\r\n\r\n" if header_lines else "\r\n\r\n")
    ).encode()
    scope = {
        "type": "http",
        "http_version": "1.1",
        "method": method,
        "path": path,
        "raw_path": path.encode(),
        "query_string": b"",
        "headers": [(k.lower().encode(), v.encode()) for k, v in (headers or {}).items()],
        "client": ("testclient", 50000),
        "server": ("testserver", 80),
        "scheme": "http",
    }
    return Request(scope, receive=lambda: raw)


def test_gateway_verify_signature_accepts_valid_signature() -> None:
    timestamp = str(int(time.time()))
    nonce = "nonce-123"
    signature = gateway_compute_signature(
        secret=SECRET,
        method="POST",
        path="/api/v1/ai/request",
        timestamp=timestamp,
        nonce=nonce,
    )

    assert gateway_verify_signature(
        secret=SECRET,
        method="POST",
        path="/api/v1/ai/request",
        timestamp=timestamp,
        nonce=nonce,
        provided_signature=signature,
    )


def test_gateway_verify_signature_rejects_tampered_signature() -> None:
    timestamp = str(int(time.time()))
    nonce = "nonce-456"

    assert not gateway_verify_signature(
        secret=SECRET,
        method="POST",
        path="/api/v1/ai/request",
        timestamp=timestamp,
        nonce=nonce,
        provided_signature="not-a-valid-signature",
    )


def test_verify_kong_header_accepts_valid_hmac() -> None:
    timestamp = str(int(time.time()))
    nonce = "fresh-nonce"
    signature = gateway_compute_signature(
        secret=SECRET,
        method="POST",
        path="/api/v1/ai/request",
        timestamp=timestamp,
        nonce=nonce,
    )
    request = _build_request(
        headers={
            "X-Gateway-Timestamp": timestamp,
            "X-Gateway-Nonce": nonce,
            "X-Gateway-Signature": signature,
        }
    )
    redis_mock = AsyncMock()
    redis_mock.set = AsyncMock(return_value=True)

    async def _run() -> None:
        with (
            patch("app.core.middleware.settings.gateway_signature_secret", SECRET),
            patch("app.core.middleware.settings.gateway_signature_max_skew_seconds", 300),
            patch("app.core.middleware.get_shared_redis", AsyncMock(return_value=redis_mock)),
        ):
            await verify_kong_header(request)

    asyncio.run(_run())


def test_verify_kong_header_rejects_replayed_nonce() -> None:
    timestamp = str(int(time.time()))
    nonce = "replayed-nonce"
    signature = gateway_compute_signature(
        secret=SECRET,
        method="POST",
        path="/api/v1/ai/request",
        timestamp=timestamp,
        nonce=nonce,
    )
    request = _build_request(
        headers={
            "X-Gateway-Timestamp": timestamp,
            "X-Gateway-Nonce": nonce,
            "X-Gateway-Signature": signature,
        }
    )
    redis_mock = AsyncMock()
    redis_mock.set = AsyncMock(return_value=False)

    async def _run() -> None:
        with (
            patch("app.core.middleware.settings.gateway_signature_secret", SECRET),
            patch("app.core.middleware.settings.gateway_signature_max_skew_seconds", 300),
            patch("app.core.middleware.get_shared_redis", AsyncMock(return_value=redis_mock)),
            pytest.raises(HTTPException) as exc,
        ):
            await verify_kong_header(request)
        assert exc.value.status_code == 403

    asyncio.run(_run())


def test_verify_kong_header_falls_back_to_legacy_header() -> None:
    request = _build_request(headers={"kong-header": "true"})

    async def _run() -> None:
        with patch("app.core.middleware.settings.gateway_signature_secret", ""):
            await verify_kong_header(request)

    asyncio.run(_run())
