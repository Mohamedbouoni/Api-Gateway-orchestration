# app/services/file_extraction_service.py
"""Secure file text extraction service.

Supports PDF, TXT, CSV, MD, JSON files. Validates by MIME magic bytes,
enforces size limits, and sanitises extracted content before passing
to the AI pipeline.
"""

from __future__ import annotations

import io
import json
import logging
import re
from typing import Optional, Tuple

logger = logging.getLogger(__name__)

# ── Security constraints ───────────────────────────────────────────────────
MAX_FILE_SIZE_MB = 10
MAX_FILE_SIZE_BYTES = MAX_FILE_SIZE_MB * 1024 * 1024
MAX_EXTRACTED_CHARS = 50_000  # truncate to avoid context overflow

ALLOWED_EXTENSIONS = {
    ".pdf", ".txt", ".csv", ".md", ".json", ".log", ".py", ".js", ".ts", ".yaml", ".yml",
    ".jpg", ".jpeg", ".png", ".webp", ".gif"
}

# Magic-byte signatures for PDF (first 5 bytes)
PDF_MAGIC = b"%PDF-"

# MIME-type to extension mapping for secondary validation
ALLOWED_MIMES = {
    "application/pdf",
    "text/plain",
    "text/csv",
    "text/markdown",
    "application/json",
    "text/x-python",
    "text/javascript",
    "application/x-yaml",
    "text/yaml",
    "image/jpeg",
    "image/png",
    "image/webp",
    "image/gif",
}


class FileExtractionError(Exception):
    """Raised when file extraction fails for security or format reasons."""
    pass


class FileExtractionService:
    """Extracts text from uploaded files with strict security validation."""

    def validate_file(
        self,
        filename: str,
        content_type: str,
        file_bytes: bytes,
    ) -> None:
        """Validate file before extraction. Raises FileExtractionError on failure."""

        # 1. Size check
        if len(file_bytes) > MAX_FILE_SIZE_BYTES:
            raise FileExtractionError(
                f"File too large ({len(file_bytes) / 1024 / 1024:.1f}MB). "
                f"Maximum allowed: {MAX_FILE_SIZE_MB}MB."
            )

        # 2. Extension whitelist
        ext = self._get_extension(filename)
        if ext not in ALLOWED_EXTENSIONS:
            raise FileExtractionError(
                f"File type '{ext}' is not allowed. "
                f"Supported: {', '.join(sorted(ALLOWED_EXTENSIONS))}"
            )

        # 3. Magic-byte validation for PDFs
        if ext == ".pdf":
            if not file_bytes[:5].startswith(PDF_MAGIC):
                raise FileExtractionError(
                    "File claims to be PDF but does not have valid PDF header. "
                    "Possible file type spoofing detected."
                )

        # 4. Zero-byte check
        if len(file_bytes) == 0:
            raise FileExtractionError("Uploaded file is empty.")

        logger.info(
            "[FileExtraction] Validated file=%s size=%d ext=%s",
            filename, len(file_bytes), ext,
        )

    def extract_text(self, filename: str, file_bytes: bytes) -> Tuple[str, dict]:
        """Extract text content from the file.

        Returns:
            (extracted_text, metadata_dict)
        """
        ext = self._get_extension(filename)

        if ext == ".pdf":
            text = self._extract_pdf(file_bytes)
        elif ext == ".json":
            text = self._extract_json(file_bytes)
        elif ext in {".jpg", ".jpeg", ".png", ".webp", ".gif"}:
            text = self._extract_image(filename)
        else:
            # Plain text extraction for .txt, .csv, .md, .py, .js, etc.
            text = self._extract_plaintext(file_bytes)

        # Sanitise: strip null bytes, excessive whitespace
        text = self._sanitise(text)

        # Truncate if too long
        truncated = False
        if len(text) > MAX_EXTRACTED_CHARS:
            text = text[:MAX_EXTRACTED_CHARS]
            truncated = True

        metadata = {
            "filename": filename,
            "extension": ext,
            "original_size_bytes": len(file_bytes),
            "extracted_chars": len(text),
            "truncated": truncated,
        }

        logger.info(
            "[FileExtraction] Extracted text from %s: %d chars (truncated=%s)",
            filename, len(text), truncated,
        )

        return text, metadata

    # ── Private extraction methods ─────────────────────────────────────────

    def _extract_pdf(self, file_bytes: bytes) -> str:
        """Extract text from PDF using PyPDF2."""
        try:
            from PyPDF2 import PdfReader

            reader = PdfReader(io.BytesIO(file_bytes))
            pages = []
            for i, page in enumerate(reader.pages):
                page_text = page.extract_text() or ""
                if page_text.strip():
                    pages.append(f"--- Page {i + 1} ---\n{page_text}")

            if not pages:
                raise FileExtractionError(
                    "Could not extract text from PDF. "
                    "The file may be image-based (scanned). "
                    "Only text-based PDFs are supported."
                )
            return "\n\n".join(pages)

        except ImportError:
            raise FileExtractionError(
                "PDF processing is not available on this server."
            )
        except FileExtractionError:
            raise
        except Exception as exc:
            logger.error("[FileExtraction] PDF extraction failed: %s", exc)
            raise FileExtractionError(
                "Failed to process PDF file. The file may be corrupted or password-protected."
            ) from exc

    def _extract_json(self, file_bytes: bytes) -> str:
        """Extract and pretty-print JSON content."""
        try:
            text = file_bytes.decode("utf-8", errors="replace")
            parsed = json.loads(text)
            return json.dumps(parsed, indent=2, ensure_ascii=False)
        except json.JSONDecodeError as exc:
            raise FileExtractionError(f"Invalid JSON file: {exc}") from exc

    def _extract_image(self, filename: str) -> str:
        """Placeholder for image extraction since vision models are not yet natively enabled in the standard text pipeline."""
        return (
            f"[Image Attachment: {filename}]\n\n"
            "(Note to AI: The user has uploaded an image. However, the current AI model "
            "does not have full multi-modal vision capabilities configured yet. Please "
            "politely inform the user that you cannot analyze the content of the image directly, "
            "but ask if they can describe it or provide its text.)"
        )

    def _extract_plaintext(self, file_bytes: bytes) -> str:
        """Decode plain text files."""
        # Try UTF-8 first, fall back to latin-1
        try:
            return file_bytes.decode("utf-8")
        except UnicodeDecodeError:
            return file_bytes.decode("latin-1", errors="replace")

    def _sanitise(self, text: str) -> str:
        """Remove potentially dangerous content from extracted text."""
        # Remove null bytes
        text = text.replace("\0", "")
        # Collapse excessive whitespace (more than 3 newlines)
        text = re.sub(r"\n{4,}", "\n\n\n", text)
        return text.strip()

    def _get_extension(self, filename: str) -> str:
        """Get lowercase file extension."""
        if "." not in filename:
            return ""
        return "." + filename.rsplit(".", 1)[-1].lower()
