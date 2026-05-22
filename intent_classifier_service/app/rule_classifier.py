"""Deterministic intent routing from prompt patterns (tier-1, always available)."""

from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Any

from app.taxonomy import UNCLASSIFIED

_CODE_PATTERNS: tuple[tuple[re.Pattern[str], float], ...] = (
    (re.compile(r"\b(write|implement|create|generate|fix|refactor|debug)\b.*\b(function|class|method|api|script|query)\b", re.I), 0.92),
    (re.compile(r"\b(python|javascript|typescript|java|c\+\+|golang|rust|sql|bash|dockerfile)\b", re.I), 0.88),
    (re.compile(r"\b(merge\s+two\s+sorted|binary\s+search|quicksort|unit\s+test|segfault|async\s+await)\b", re.I), 0.9),
    (re.compile(r"\bhow\s+do\s+i\s+.+\s+in\s+(python|java|typescript|c\+\+)\b", re.I), 0.85),
)

_SUMMARY_PATTERNS: tuple[tuple[re.Pattern[str], float], ...] = (
    (re.compile(r"\b(summarize|summary|tl;dr|bullet\s+points|condense)\b", re.I), 0.9),
    (re.compile(r"\bin\s+\d+\s+(sentences|bullet|points)\b", re.I), 0.82),
)

_ADVANCED_PATTERNS: tuple[tuple[re.Pattern[str], float], ...] = (
    (re.compile(r"\b(prove|theorem|formal\s+proof|lemma|axiom|qed)\b", re.I), 0.9),
    (re.compile(r"\b(square\s+root\s+of\s+2|irrational)\b", re.I), 0.85),
)

_CHAT_PATTERNS: tuple[tuple[re.Pattern[str], float], ...] = (
    (re.compile(r"\b(hello|hi|hey|thanks|thank\s+you|how\s+are\s+you)\b", re.I), 0.8),
    (re.compile(r"\b(recipe|dinner|weekend|movie|hobby|weather)\b", re.I), 0.78),
)


@dataclass(frozen=True)
class RuleHit:
    intent: str
    confidence: float
    rule: str


class RuleBasedClassifier:
    """High-precision patterns for enterprise intent routing."""

    def __init__(self, *, candidate_labels: tuple[str, ...]) -> None:
        self._labels = set(candidate_labels)

    def classify(self, text: str) -> dict[str, Any]:
        t = (text or "").strip()
        if not t:
            return {"intent": UNCLASSIFIED, "confidence": 0.0, "reasoning": "empty", "source": "rules"}

        best: RuleHit | None = None
        for patterns, intent in (
            (_CODE_PATTERNS, "code_generation"),
            (_SUMMARY_PATTERNS, "summarization"),
            (_ADVANCED_PATTERNS, "advanced_chat"),
            (_CHAT_PATTERNS, "general_chat"),
        ):
            if intent not in self._labels:
                continue
            for pat, score in patterns:
                if pat.search(t):
                    if best is None or score > best.confidence:
                        best = RuleHit(intent=intent, confidence=score, rule=pat.pattern)

        if best is not None:
            return {
                "intent": best.intent,
                "confidence": best.confidence,
                "reasoning": f"rule:{best.rule[:40]}",
                "source": "rules",
            }
        return {"intent": UNCLASSIFIED, "confidence": 0.0, "reasoning": "no_rule_match", "source": "rules"}
