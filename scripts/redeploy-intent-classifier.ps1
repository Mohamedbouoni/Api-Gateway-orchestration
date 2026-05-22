# Rebuild intent-classifier (NLI backend) and roll out to Kubernetes.
$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent
Set-Location $Root

Write-Host "Building intent-classifier image..." -ForegroundColor Cyan
docker build -f intent_classifier_service/Dockerfile -t api-gateways-intent-classifier:latest .

Write-Host "Applying K8s manifests..." -ForegroundColor Cyan
kubectl apply -f k8s/application/intent-classifier.yaml

Write-Host "Restarting deployment..." -ForegroundColor Cyan
kubectl rollout restart deployment/intent-classifier -n ai-application
kubectl rollout status deployment/intent-classifier -n ai-application --timeout=300s

Write-Host "Verifying backend (expect hybrid/rules, NOT Ollama 404)..." -ForegroundColor Cyan
Start-Sleep -Seconds 5
kubectl logs -n ai-application deployment/intent-classifier --tail=40 | Select-String -Pattern "hybrid|rules|Ollama|classify intent"

Write-Host ""
Write-Host "Port-forward test:" -ForegroundColor Green
Write-Host '  kubectl port-forward -n ai-application svc/intent-classifier 3010:3010'
Write-Host '  curl -X POST http://localhost:3010/classify -H "Content-Type: application/json" -d "{\"text\":\"Write a Python function that merges two sorted lists.\"}"'
