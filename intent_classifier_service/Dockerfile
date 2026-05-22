# Build from repository root:
#   docker build -f intent_classifier_service/Dockerfile -t api-gateways-intent-classifier:latest .
FROM python:3.11-slim

WORKDIR /app

COPY intent_classifier_service/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY intent_taxonomy /app/intent_taxonomy
COPY intent_classifier_service/app /app/app

RUN useradd -r -u 1001 appuser && chown -R appuser /app
USER appuser

ENV PYTHONPATH=/app
ENV INTENT_TAXONOMY_PATH=/app/intent_taxonomy/intent_labels_v1.yaml
ENV PORT=3010
ENV CLASSIFIER_BACKEND=hybrid
ENV INTENT_CACHE_KEY_VERSION=v8-hybrid
ENV INTENT_CACHE_FLUSH_ON_START=true

EXPOSE 3010
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:3010/readyz', timeout=5)"
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-3010}"]
