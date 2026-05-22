"""Unified classification: rules → NLI → keyword heuristic (never silent LLM fallback)."""

from __future__ import annotations

import logging
from typing import Any

from app.heuristic_classifier import apply_keyword_heuristic
from app.nli_classifier import NLIClassifier
from app.rule_classifier import RuleBasedClassifier
from app.taxonomy import UNCLASSIFIED, Taxonomy

logger = logging.getLogger(__name__)

RULE_CONFIDENCE_FLOOR = 0.75


def merge_results(
    text: str,
    *,
    rule: dict[str, Any],
    nli: dict[str, Any] | None,
) -> dict[str, Any]:
    """Pick the strongest signal; rules win when confident."""
    rule_intent = str(rule.get("intent", UNCLASSIFIED))
    rule_conf = float(rule.get("confidence", 0.0))

    if rule_intent != UNCLASSIFIED and rule_conf >= RULE_CONFIDENCE_FLOOR:
        return {**rule, "source": "rules"}

    nli_conf = 0.0
    if nli is not None:
        nli_intent = str(nli.get("intent", UNCLASSIFIED))
        nli_conf = float(nli.get("confidence", 0.0))
        if nli_intent != UNCLASSIFIED and nli_conf > rule_conf:
            return {**nli, "source": "model"}

    boosted = apply_keyword_heuristic(text, rule if rule_conf >= nli_conf else (nli or rule))
    if str(boosted.get("intent", UNCLASSIFIED)) != UNCLASSIFIED:
        return {**boosted, "source": boosted.get("source") or "heuristic"}

    if nli is not None:
        nli_intent = str(nli.get("intent", UNCLASSIFIED))
        if nli_intent != UNCLASSIFIED:
            return {**nli, "source": "model"}

    return rule if rule_conf > 0 else (nli or rule)


async def classify_text(
    text: str,
    *,
    taxonomy: Taxonomy,
    rules: RuleBasedClassifier,
    nli: NLIClassifier | None,
) -> dict[str, Any]:
    rule_out = rules.classify(text)
    nli_out = None
    if nli is not None:
        try:
            nli_out = await nli.classify(text)
        except Exception as exc:
            logger.warning("NLI classify failed: %s", exc)
    merged = merge_results(text, rule=rule_out, nli=nli_out)
    intent = str(merged.get("intent", UNCLASSIFIED))
    if intent not in set(taxonomy.candidate_labels) | {UNCLASSIFIED}:
        merged["intent"] = UNCLASSIFIED
        merged["confidence"] = 0.0
    return merged
