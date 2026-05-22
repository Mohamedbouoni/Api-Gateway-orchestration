"""Lightweight keyword fallback when NLI/LLM returns unclassified."""

from __future__ import annotations

import re
from typing import Any

from app.taxonomy import UNCLASSIFIED

_CODE_RE = re.compile(
    r"\b("
    r"python|javascript|typescript|java|c\+\+|golang|rust|sql|api|"
    r"function|implement|debug|refactor|algorithm|dockerfile|"
    r"unit\s+test|segfault|binary\s+search|quicksort|merge\s+two\s+sorted"
    r")\b",
    re.IGNORECASE,
)
_SUMMARY_RE = re.compile(
    r"\b(summarize|summary|tl;dr|bullet\s+points|condense|in\s+\d+\s+(sentences|bullets))\b",
    re.IGNORECASE,
)
_ADVANCED_RE = re.compile(
    r"\b(prove|theorem|formal\s+proof|irrational|axiom|lemma|qed)\b",
    re.IGNORECASE,
)


def apply_keyword_heuristic(text: str, result: dict[str, Any]) -> dict[str, Any]:
    """If ML returned unclassified, map obvious patterns to a routable intent."""
    if str(result.get("intent", UNCLASSIFIED)) != UNCLASSIFIED:
        return result
    if _CODE_RE.search(text):
        return {
            "intent": "code_generation",
            "confidence": max(float(result.get("confidence", 0.0)), 0.55),
            "reasoning": "keyword_heuristic",
        }
    if _SUMMARY_RE.search(text):
        return {
            "intent": "summarization",
            "confidence": max(float(result.get("confidence", 0.0)), 0.55),
            "reasoning": "keyword_heuristic",
        }
    if _ADVANCED_RE.search(text):
        return {
            "intent": "advanced_chat",
            "confidence": max(float(result.get("confidence", 0.0)), 0.55),
            "reasoning": "keyword_heuristic",
        }
    return result
