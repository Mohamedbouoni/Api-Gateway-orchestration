# app/infrastructure/ai_provider/openai_client.py
"""Generic OpenAI-compatible /chat/completions client.

The vast majority of cloud (and many on-prem) LLM endpoints expose the
OpenAI ``POST /v1/chat/completions`` spec — OpenAI, Groq, OpenRouter,
Together, DeepInfra, Anthropic-via-proxy, Mistral, vLLM, llama.cpp's
OpenAI server, etc. This client speaks that contract and adapts the
output into the same ``{token, done, usage}`` envelope already consumed
by :mod:`app.services.ai_request_service`.

Authentication is configurable per-service: the admin picks an
``auth_header`` (e.g. ``Authorization``, ``x-api-key``, ``x-goog-api-key``)
and an ``auth_scheme`` prefix (``Bearer``, ``Token``, or empty for raw
key). The dispatcher passes these in from the ``ai_services`` row.
"""

from __future__ import annotations

import json
import logging
from typing import Any, AsyncIterator, Dict, List, Optional, Union

import httpx

logger = logging.getLogger(__name__)


# Module-level persistent client — matches the pattern used by ollama_client
# so we share connection pools across requests.
_http_client = httpx.AsyncClient(
    timeout=httpx.Timeout(120.0, connect=10.0),
)


async def close_client() -> None:
    """Release the shared connection pool. Call from app lifespan finally."""
    await _http_client.aclose()


def _build_headers(
    *,
    auth_header: Optional[str],
    auth_scheme: Optional[str],
    api_key: Optional[str],
) -> Dict[str, str]:
    headers: Dict[str, str] = {
        "accept": "application/json",
        "content-type": "application/json",
    }
    if api_key:
        header_name = (auth_header or "Authorization").strip()
        scheme = (auth_scheme or "").strip()
        headers[header_name] = f"{scheme} {api_key}".strip() if scheme else api_key
    return headers


def _extract_usage(payload: Dict[str, Any]) -> Dict[str, int]:
    """Translate the OpenAI ``usage`` block into the Ollama-shaped envelope
    the rest of the platform expects."""
    usage = payload.get("usage") or {}
    return {
        "prompt_eval_count": int(usage.get("prompt_tokens") or 0),
        "eval_count": int(usage.get("completion_tokens") or 0),
    }


async def chat(
    *,
    provider_url: str,
    model: Optional[str],
    messages: List[Dict[str, Any]],
    stream: bool,
    api_key: Optional[str] = None,
    auth_header: Optional[str] = "Authorization",
    auth_scheme: Optional[str] = "Bearer",
) -> Union[Dict[str, Any], AsyncIterator[Dict[str, Any]]]:
    """Call an OpenAI-compatible chat-completions endpoint.

    Returns:
        * a JSON dict when ``stream=False`` shaped like ``{"message":
          {"role": "assistant", "content": str}, "usage": {...}}`` so it
          slots directly into :meth:`AIRequestService.submit_json`;
        * an async iterator of ``{"token": str, "done": bool, "usage": ...}``
          chunks when ``stream=True``.
    """
    headers = _build_headers(
        auth_header=auth_header, auth_scheme=auth_scheme, api_key=api_key
    )

    body: Dict[str, Any] = {"messages": messages, "stream": stream}
    if model:
        body["model"] = model

    if not stream:
        resp = await _http_client.post(provider_url, headers=headers, json=body)
        resp.raise_for_status()
        data = resp.json()

        choice_msg: Dict[str, Any] = {}
        choices = data.get("choices") or []
        if choices:
            first = choices[0] or {}
            choice_msg = first.get("message") or {}

        return {
            "message": {
                "role": choice_msg.get("role", "assistant"),
                "content": choice_msg.get("content", "") or "",
            },
            "usage": _extract_usage(data),
        }

    async def _generator() -> AsyncIterator[Dict[str, Any]]:
        try:
            async with _http_client.stream(
                "POST",
                provider_url,
                headers=headers,
                json=body,
            ) as r:
                last_usage: Dict[str, int] = {"prompt_eval_count": 0, "eval_count": 0}
                async for raw_line in r.aiter_lines():
                    line = (raw_line or "").strip()
                    if not line:
                        continue

                    # OpenAI uses SSE: each event begins with "data: ".
                    # Some servers omit the prefix and emit raw JSON lines,
                    # so we handle both. "[DONE]" terminates the stream.
                    if line.startswith("data:"):
                        line = line[len("data:"):].strip()
                    if line == "[DONE]":
                        yield {"token": "", "done": True, "usage": last_usage}
                        return

                    try:
                        chunk = json.loads(line)
                    except json.JSONDecodeError:
                        continue

                    if isinstance(chunk.get("usage"), dict):
                        last_usage = _extract_usage(chunk)

                    token = ""
                    choices = chunk.get("choices") or []
                    if choices:
                        delta = (choices[0] or {}).get("delta") or {}
                        token = delta.get("content", "") or ""

                        finish_reason = (choices[0] or {}).get("finish_reason")
                        if finish_reason:
                            if token:
                                yield {"token": token, "done": False}
                            yield {"token": "", "done": True, "usage": last_usage}
                            return

                    if token:
                        yield {"token": token, "done": False}

                yield {"token": "", "done": True, "usage": last_usage}
        except Exception as exc:  # pragma: no cover - network failure path
            logger.exception("OpenAI-compatible provider stream failed: %s", exc)
            raise

    return _generator()
