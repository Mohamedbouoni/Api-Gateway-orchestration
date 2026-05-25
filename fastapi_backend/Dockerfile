FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for asyncpg
RUN apt-get update && apt-get install -y --fix-missing \
    gcc \
    libpq-dev \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# ── Layer 1: CPU-only PyTorch (rarely changes → cached) ──────────────────
RUN pip install --no-cache-dir \
    torch \
    --index-url https://download.pytorch.org/whl/cpu

# ── Layer 2: Heavy ML/NLP packages (rarely changes → cached) ────────────
# These are separated so that adding a lightweight dependency like PyPDF2
# does NOT re-download ~500 MB of transformers, spaCy, and Presidio.
COPY requirements-heavy.txt .
RUN pip install --no-cache-dir --default-timeout=120 --retries 10 -r requirements-heavy.txt

# ── Layer 3: spaCy model (rarely changes → cached) ──────────────────────
RUN python -m spacy download en_core_web_sm

# ── Layer 4: DistilBERT injection model (rarely changes → cached) ───────
# Bake the model into the image so startup warm-up is instant.
ENV HF_HOME=/var/cache/huggingface
RUN python -c "\
from transformers import pipeline; \
pipeline('text-classification', model='fmops/distilbert-prompt-injection', \
         device=-1)"

# ── Layer 5: Lightweight app dependencies (changes often → fast rebuild) ─
COPY requirements.txt .
RUN pip install --no-cache-dir --default-timeout=120 --retries 10 -r requirements.txt

# ── Layer 6: Application code (changes most often → always rebuilt) ──────
COPY . .

# Environment variables will be provided by docker-compose
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "3000"]
