import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from app.rule_classifier import RuleBasedClassifier


def test_code_generation_python_function():
    rules = RuleBasedClassifier(
        candidate_labels=("general_chat", "code_generation", "summarization", "advanced_chat")
    )
    r = rules.classify("Write a Python function that merges two sorted lists.")
    assert r["intent"] == "code_generation"
    assert r["confidence"] >= 0.75


def test_general_chat_dinner():
    rules = RuleBasedClassifier(
        candidate_labels=("general_chat", "code_generation", "summarization", "advanced_chat")
    )
    r = rules.classify("What are easy dinner ideas for two people?")
    assert r["intent"] == "general_chat"
