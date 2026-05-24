# ─────────────────────────────────────────────────────────────────────────────
# deploy.ps1  -  Enterprise AI Gateway Kubernetes Deployment Script
#
# Usage:  .\deploy.ps1
#
# Images are built as local :latest tags (imagePullPolicy Never in manifests).
# That matches single-node dev clusters (Docker Desktop, Minikube). For
# multi-node production, push images to your registry, point manifests at those
# references, and use imagePullPolicy: IfNotPresent or Always as appropriate.
# ─────────────────────────────────────────────────────────────────────────────

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Warning: Not running as Administrator. Skipping machine-level OLLAMA_KEEP_ALIVE configuration." -ForegroundColor Yellow
} else {
    $ollamaKeepAlive = [Environment]::GetEnvironmentVariable("OLLAMA_KEEP_ALIVE", "Machine")
    if ($ollamaKeepAlive -ne "-1") {
        Write-Host "Configuring OLLAMA_KEEP_ALIVE=-1 (keep models loaded in memory)..." -ForegroundColor Yellow
        [Environment]::SetEnvironmentVariable("OLLAMA_KEEP_ALIVE", "-1", "Machine")
        $env:OLLAMA_KEEP_ALIVE = "-1"

        Get-Process -Name "ollama*" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        $ollamaApp = Join-Path $env:LOCALAPPDATA "Programs\Ollama\ollama app.exe"
        if (Test-Path $ollamaApp) {
            Start-Process -FilePath $ollamaApp -WindowStyle Hidden
        } elseif (Get-Command ollama -ErrorAction SilentlyContinue) {
            Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden
        } else {
            $svc = Get-Service -Name "Ollama" -ErrorAction SilentlyContinue
            if ($svc) {
                Restart-Service -Name "Ollama" -Force -ErrorAction SilentlyContinue
            } else {
                Write-Host "  Warning: Ollama not found; install Ollama on the host for local LLM routing." -ForegroundColor DarkYellow
            }
        }
        Start-Sleep -Seconds 3
        try {
            $null = Invoke-WebRequest -Uri "http://localhost:11434/api/tags" -UseBasicParsing -TimeoutSec 5
            Write-Host "  Ollama API is reachable on :11434" -ForegroundColor Green
        } catch {
            Write-Host "  Warning: Ollama API not reachable yet at http://localhost:11434" -ForegroundColor DarkYellow
        }
    } else {
        Write-Host "OLLAMA_KEEP_ALIVE already set to -1 (models stay warm)." -ForegroundColor Gray
    }
}

# Warm up models into memory regardless of whether OLLAMA_KEEP_ALIVE was just set or already configured
Write-Host "Warming up Ollama models..." -ForegroundColor Yellow
$requiredModels = @("llama3.2:3b", "qwen2.5-coder:7b")
$installedTags = @()
try {
    $installedTags = @(
        (Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5).models |
            ForEach-Object { $_.name }
    )
} catch {
    Write-Host "  Warning: Ollama API not reachable; skipping model warmup." -ForegroundColor DarkYellow
}

foreach ($baseName in $requiredModels) {
    $tag = $installedTags | Where-Object {
        $_ -eq $baseName -or $_ -eq "${baseName}:latest" -or $_ -like "${baseName}:*"
    } | Select-Object -First 1

    if (-not $tag) {
        Write-Host "  Warning: '$baseName' is not installed. Run: ollama pull $baseName" -ForegroundColor DarkYellow
        continue
    }

    try {
        Write-Host "  Loading $tag into memory (this can take a few minutes)..." -ForegroundColor Gray
        $warmupBody = @{
            model      = $tag
            prompt     = "warmup"
            stream     = $false
            keep_alive = [int]-1
        } | ConvertTo-Json -Compress

        $null = Invoke-WebRequest -Uri "http://localhost:11434/api/generate" `
            -Method POST `
            -Body $warmupBody `
            -ContentType "application/json" `
            -UseBasicParsing `
            -TimeoutSec 300

        Write-Host "  $tag warmed up (keep_alive=-1)" -ForegroundColor Green
    } catch {
        Write-Host "  Warning: could not warm up $tag - $($_.Exception.Message)" -ForegroundColor DarkYellow
    }
}

if (Get-Command ollama -ErrorAction SilentlyContinue) {
    Write-Host "  Models currently loaded:" -ForegroundColor Gray
    & ollama ps
    Write-Host "  Note: if RAM is tight, Ollama may unload one model when loading the next." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Deploying Enterprise AI Gateway to K8s"   -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

function Ensure-Command {
    param(
        [string]$Name
    )
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' is not available in PATH."
    }
}

function Ensure-Path {
    param(
        [string]$PathToCheck
    )
    if (-not (Test-Path $PathToCheck)) {
        throw "Required path is missing: $PathToCheck"
    }
}

function Build-LocalImage {
    param(
        [string]$ImageName,
        [string]$DockerfileDir,
        [string]$DockerfilePath = ""
    )

    $maxAttempts = 3

    for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {

        Write-Host "  Building image: $ImageName (attempt $attempt/$maxAttempts)" -ForegroundColor Gray

        $dockerArgs = @(
            "build",
            "--progress=plain",
            "-t", $ImageName
        )

        # Frontend Vite build arguments
        if ($ImageName -eq "api-gateways-frontend:latest") {
            $dockerArgs += @(
                "--build-arg", "VITE_KEYCLOAK_URL=http://localhost/auth",
                "--build-arg", "VITE_KEYCLOAK_REALM=newRealm",
                "--build-arg", "VITE_KEYCLOAK_CLIENT_ID=myclient",
                "--build-arg", "VITE_APP_URL=http://localhost",
                "--build-arg", "VITE_GRAFANA_URL=http://localhost/grafana",
                "--build-arg", "AI_ENDPOINT=https://localhost:8443/api/ai/orchestrate/"
            )
        }

        if ($DockerfilePath) {
            $dockerArgs += @("-f", $DockerfilePath)
        }

        # Automatically pass HF_TOKEN if found in the build directory
        $hfTokenPath = Join-Path $DockerfileDir ".hf_token"
        if (Test-Path $hfTokenPath) {
            $dockerArgs += @("--secret", "id=hf_token,src=$hfTokenPath")
        }

        $dockerArgs += $DockerfileDir

        $logFile = [System.IO.Path]::GetTempFileName()
        $buildText = ""
        try {
            & docker @dockerArgs 2>&1 | Tee-Object -FilePath $logFile
            $exitCode = $LASTEXITCODE
            if ($exitCode -ne 0 -and (Test-Path $logFile)) {
                $buildText = Get-Content $logFile -Raw -ErrorAction SilentlyContinue
            }
        } finally {
            if (Test-Path $logFile) {
                Remove-Item $logFile -Force -ErrorAction SilentlyContinue
            }
        }

        if ($exitCode -eq 0) {
            return
        }

        $isTlsHandshakeTimeout = $buildText -match "TLS handshake timeout"
        $isRegistryMetadataFailure = $buildText -match "failed to resolve source metadata"
        $isRetryable = $isTlsHandshakeTimeout -or $isRegistryMetadataFailure

        if (-not $isRetryable -or $attempt -eq $maxAttempts) {
            throw "Failed to build image: $ImageName"
        }

        Write-Host "    Retrying build due to transient registry/network error..." -ForegroundColor Yellow
    }
}

Write-Host "[0/8] Running preflight checks..." -ForegroundColor Yellow
Ensure-Command "kubectl"
Ensure-Command "docker"
kubectl cluster-info | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "kubectl cannot reach the active cluster context."
}
Ensure-Path "k8s\kustomization.yaml"
# secrets/secrets.yaml is no longer applied statically; Vault sync creates K8s secrets dynamically
# Ensure-Path "k8s\secrets\secrets.yaml"
Ensure-Path "backend\scripts\init-platform-db.sql"
Ensure-Path "backend\scripts\init-platform-db-usage.sql"
Ensure-Path "gateway\plugins\simple-validator"
Ensure-Path "gateway\plugins\tenant-restriction"
Ensure-Path "gateway\kong_final.yaml"
Ensure-Path "keycloak\realm-export.json"
Ensure-Path "monitoring\prometheus.yml"
Ensure-Path "monitoring\grafana\dashboards"
Ensure-Path "monitoring\grafana\provisioning\dashboards"
Ensure-Path "monitoring\grafana\provisioning\datasources"
Ensure-Path "intent_classifier_service\Dockerfile"
Ensure-Path "waf\Dockerfile"
Ensure-Path "waf\99-exclusions.sh"
Ensure-Path "k8s\application\keycloak-master-config-job.yaml"

Write-Host "  Checking local images required by imagePullPolicy=Never..." -ForegroundColor Gray
Build-LocalImage "api-gateways-backend:latest" "fastapi_backend"
Build-LocalImage "api-gateways-intent-classifier:latest" "." "intent_classifier_service/Dockerfile"
Build-LocalImage "api-gateways-frontend:latest" "frontend"
Build-LocalImage "api-gateways-kong-logger:latest" "kong-logger"
# Convert WAF entrypoint script to LF line endings before build (CRLF breaks
# the shebang in the Linux container on first copy from a Windows checkout).
$wafScript = "waf\99-exclusions.sh"
$raw = Get-Content $wafScript -Raw
$lf  = $raw -replace "`r`n", "`n" -replace "`r", "`n"
[System.IO.File]::WriteAllText("$PSScriptRoot\$wafScript", $lf)
Build-LocalImage "api-gateways-waf:latest" "waf"

$metricsApi = kubectl api-versions | Select-String "metrics.k8s.io"
if (-not $metricsApi) {
    Write-Host "  Warning: metrics-server API is unavailable; HPAs will report metric errors." -ForegroundColor Yellow
}

# ── Step 1: Create Namespaces ──────────────────────────────────────────────
Write-Host ""
Write-Host "[1/8] Creating namespaces..." -ForegroundColor Yellow
kubectl apply -f k8s/namespaces.yaml

# ── Step 1.5: Deploy Vault (ai-data namespace) ────────────────────────────
Write-Host ""
Write-Host "[1.5] Deploying Vault to ai-data namespace..." -ForegroundColor Yellow
kubectl apply -f k8s/data/vault.yaml
Write-Host "  Waiting for Vault pod to be ready (up to 300s - first run pulls image)..." -ForegroundColor Gray
kubectl wait --for=condition=ready pod -l app=vault -n ai-data --timeout=300s
if ($LASTEXITCODE -ne 0) {
    # Vault image pull takes time on first run; on subsequent runs check if already Running
    $vaultPhase = kubectl get pod -l app=vault -n ai-data -o jsonpath="{.items[0].status.phase}" 2>$null
    if ($vaultPhase -eq "Running") {
        Write-Host "  Vault pod is Running (from prior deployment). Proceeding." -ForegroundColor Green
    } else {
        Write-Host "  Vault pod did not become ready. Dumping pod info..." -ForegroundColor Red
        kubectl describe pod -l app=vault -n ai-data
        kubectl logs -l app=vault -n ai-data --tail=40
        throw "Vault pod did not become ready in time."
    }
}
Write-Host "  Vault is running." -ForegroundColor Green

# ── Step 1.6: Seed Vault via port-forward ────────────────────────────────
Write-Host ""
Write-Host "[1.6] Seeding Vault secrets via port-forward..." -ForegroundColor Yellow
$pfJob = Start-Job -ScriptBlock {
    kubectl port-forward -n ai-data svc/vault 8200:8200 2>&1
}
Write-Host "  Port-forward started (job $($pfJob.Id)). Waiting 5s for it to stabilise..." -ForegroundColor Gray
Start-Sleep -Seconds 5
try {
    & "$PSScriptRoot\scripts\vault-seed.ps1" -VaultAddr "http://localhost:8200" -VaultToken "dev-root-token"
} finally {
    Stop-Job  $pfJob | Out-Null
    Remove-Job $pfJob | Out-Null
}

# ── Step 1.7: Sync Vault secrets → K8s Secrets ───────────────────────────
Write-Host ""
Write-Host "[1.7] Syncing K8s secrets from Vault..." -ForegroundColor Yellow
# A fresh port-forward is needed because the previous job was stopped
$pfJob2 = Start-Job -ScriptBlock {
    kubectl port-forward -n ai-data svc/vault 8200:8200 2>&1
}
Write-Host "  Port-forward restarted (job $($pfJob2.Id)). Waiting 4s..." -ForegroundColor Gray
Start-Sleep -Seconds 4
try {
    & "$PSScriptRoot\scripts\vault-sync-k8s-secrets.ps1" -VaultAddr "http://localhost:8200" -VaultToken "dev-root-token"
} finally {
    Stop-Job  $pfJob2 | Out-Null
    Remove-Job $pfJob2 | Out-Null
}

# ── Step 2: Create ConfigMaps for DB init scripts ─────────────────────────
Write-Host ""
Write-Host "[2/8] Creating database ConfigMaps..." -ForegroundColor Yellow
kubectl create configmap platform-db-init-scripts --from-file=init-platform-db.sql=backend/scripts/init-platform-db.sql -n ai-data --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap platform-db-usage-scripts --from-file=init-platform-db-usage.sql=backend/scripts/init-platform-db-usage.sql -n ai-data --dry-run=client -o yaml | kubectl apply -f -

# ── Step 3: Create Kong plugin & routing ConfigMaps ───────────────────────
Write-Host ""
Write-Host "[3/8] Creating Kong plugin & routing ConfigMaps..." -ForegroundColor Yellow
kubectl create configmap kong-plugin-simple-validator --from-file=gateway/plugins/simple-validator -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap kong-plugin-tenant-restriction --from-file=gateway/plugins/tenant-restriction -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap kong-deck-config --from-file=kong_final.yaml=gateway/kong_final.yaml -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap grafana-dashboards --from-file=monitoring/grafana/dashboards/ -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap grafana-provisioning-dashboards --from-file=monitoring/grafana/provisioning/dashboards/ -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap grafana-provisioning-datasources --from-file=datasource.yml=monitoring/grafana/provisioning/datasources/datasource.k8s.yml -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -

# ── Step 4: Create Configuration ConfigMaps ───────────────────────────────
Write-Host ""
Write-Host "[4/8] Creating Configuration ConfigMaps..." -ForegroundColor Yellow
kubectl create configmap keycloak-realm --from-file=realm-export.json=keycloak/realm-export.json -n ai-application --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap prometheus-config --from-file=prometheus.yml=monitoring/prometheus.k8s.yml -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -

# ── Step 5: Kong mTLS certificates (already synced by Vault in step 1.7) ──
Write-Host ""
Write-Host "[5/8] Checking Kong mTLS certificates..." -ForegroundColor Yellow
$certExists = kubectl get secret kong-cluster-certs -n ai-gateway 2>$null
if ($certExists) {
    Write-Host "  kong-cluster-certs secret exists (created by Vault sync in step 1.7)." -ForegroundColor Green
} else {
    Write-Host "  WARNING: kong-cluster-certs not found - Vault sync may have failed. Attempting fallback cert generation..." -ForegroundColor Yellow
    docker run --rm -v "${PWD}\k8s\secrets:/certs" alpine/openssl req -new -x509 -nodes -newkey rsa:2048 -keyout /certs/cluster.key -out /certs/cluster.crt -days 1095 -subj "/CN=kong_clustering"
    kubectl create secret tls kong-cluster-certs --cert=k8s/secrets/cluster.crt --key=k8s/secrets/cluster.key -n ai-gateway
}

# ── Step 6: Deploy everything via Kustomize ───────────────────────────────
Write-Host ""
Write-Host "[6/8] Deploying all services..." -ForegroundColor Yellow
$applyOutput = kubectl apply -k k8s/ 2>&1
$applyText = ($applyOutput | Out-String)
if ($applyText) {
    Write-Host $applyText
}
$applyExitCode = $LASTEXITCODE
if ($applyExitCode -ne 0) {
    throw "Step [6/8] failed: kubectl apply -k k8s/ returned exit code $applyExitCode"
}

# ── Wait for services ─────────────────────────────────────────────────────
Write-Host ""
Write-Host "Sleeping 10s to let Kubernetes schedule new pods..." -ForegroundColor Gray
Start-Sleep -Seconds 10
Write-Host "Waiting for databases..." -ForegroundColor Gray
kubectl wait --for=condition=ready pod -l app=platform-db -n ai-data --timeout=300s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  platform-db failed to become ready. Dumping pod info..." -ForegroundColor Red
    kubectl describe pod -l app=platform-db -n ai-data
    kubectl logs -l app=platform-db -n ai-data --all-containers=true --tail=50
    throw "platform-db pods did not become ready in time."
}
kubectl wait --for=condition=ready pod -l app=kong-db -n ai-data --timeout=300s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  kong-db failed to become ready. Dumping pod info..." -ForegroundColor Red
    kubectl describe pod -l app=kong-db -n ai-data
    kubectl logs -l app=kong-db -n ai-data --all-containers=true --tail=50
    throw "kong-db pods did not become ready in time."
}

Write-Host "Waiting for application layer..." -ForegroundColor Gray
kubectl wait --for=condition=ready pod -l app=fastapi -n ai-application --timeout=1200s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  fastapi failed to become ready. Dumping pod info..." -ForegroundColor Red
    kubectl describe pod -l app=fastapi -n ai-application
    kubectl logs -l app=fastapi -n ai-application --all-containers=true --tail=50
    throw "fastapi pods did not become ready in time."
}
kubectl wait --for=condition=ready pod -l app=intent-classifier -n ai-application --timeout=300s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  intent-classifier failed to become ready. Dumping pod info..." -ForegroundColor Red
    kubectl describe pod -l app=intent-classifier -n ai-application
    kubectl logs -l app=intent-classifier -n ai-application --all-containers=true --tail=50
    throw "intent-classifier pods did not become ready in time."
}
kubectl wait --for=condition=ready pod -l app=opa -n ai-application --timeout=180s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  opa failed to become ready. Dumping pod info..." -ForegroundColor Red
    kubectl describe pod -l app=opa -n ai-application
    kubectl logs -l app=opa -n ai-application --all-containers=true --tail=50
    throw "opa pods did not become ready in time."
}

Write-Host "Waiting for Keycloak..." -ForegroundColor Gray
kubectl wait --for=condition=ready pod -l app=keycloak -n ai-application --timeout=600s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  keycloak failed to become ready. Dumping pod info..." -ForegroundColor Red
    kubectl describe pod -l app=keycloak -n ai-application
    kubectl logs -l app=keycloak -n ai-application --tail=80
    throw "keycloak pod did not become ready in time."
}
Write-Host "  Keycloak is running." -ForegroundColor Green

Write-Host "Waiting for WAF edge pod..." -ForegroundColor Gray
kubectl wait --for=condition=ready pod -l app=waf -n ai-gateway --timeout=300s
if ($LASTEXITCODE -ne 0) {
    $wafPhase = kubectl get pod -l app=waf -n ai-gateway -o jsonpath="{.items[0].status.phase}" 2>$null
    if ($wafPhase -eq "Running") {
        Write-Host "  WAF pod is Running (from prior deployment). Proceeding." -ForegroundColor Green
    } else {
        Write-Host "  WAF pod did not become ready. Dumping pod info..." -ForegroundColor Red
        kubectl describe pod -l app=waf -n ai-gateway
        kubectl logs -l app=waf -n ai-gateway --all-containers=true --tail=50
        throw "WAF pod did not become ready in time."
    }
}
Write-Host "  WAF is running." -ForegroundColor Green

Write-Host "Waiting for gateway..." -ForegroundColor Gray
kubectl wait --for=condition=ready pod -l app=kong-cp -n ai-gateway --timeout=240s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Kong CP did not become ready; restarting control plane once..." -ForegroundColor Yellow
    kubectl rollout restart deployment/kong-cp -n ai-gateway
    kubectl rollout status deployment/kong-cp -n ai-gateway --timeout=240s
    if ($LASTEXITCODE -ne 0) { throw "kong-cp failed to become ready after restart." }
}

# ── Step 7: Sync Kong Configuration using Deck ────────────────────────────
Write-Host ""
Write-Host "[7/8] Synchronizing Kong Configuration..." -ForegroundColor Yellow
kubectl apply -f k8s/gateway/kong-deck-sync.yaml
if ($LASTEXITCODE -ne 0) { throw "Failed to create kong-deck-sync job." }
kubectl wait --for=condition=complete job/kong-deck-sync -n ai-gateway --timeout=180s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  kong-deck-sync failed; dumping job logs..." -ForegroundColor Red
    kubectl logs job/kong-deck-sync -n ai-gateway --tail=200
    throw "kong-deck-sync job did not complete successfully."
}

# ── Step 8: Bootstrap master realm + verify admin console edge URLs ─────────
Write-Host ""
Write-Host "[8/8] Configuring Keycloak master realm (admin console)..." -ForegroundColor Yellow
kubectl delete job keycloak-master-config -n ai-application --ignore-not-found 2>&1 | Out-Null
kubectl apply -f k8s/application/keycloak-master-config-job.yaml
if ($LASTEXITCODE -ne 0) { throw "Failed to create keycloak-master-config job." }
kubectl wait --for=condition=complete job/keycloak-master-config -n ai-application --timeout=300s
if ($LASTEXITCODE -ne 0) {
    Write-Host "  keycloak-master-config failed; dumping job logs..." -ForegroundColor Red
    kubectl logs job/keycloak-master-config -n ai-application --tail=100
    throw "keycloak-master-config job did not complete successfully."
}
Write-Host "  Master realm configured." -ForegroundColor Green

Write-Host "  Verifying Keycloak OIDC URLs at http://localhost/auth ..." -ForegroundColor Gray
$realmJson = curl.exe -s "http://localhost/auth/realms/master" 2>&1
if ($realmJson -match ":8000|:8443") {
    Write-Host "  realm response: $realmJson" -ForegroundColor Red
    throw "Keycloak realm JSON still exposes wrong port (expected http://localhost/auth only)."
}
$oidcJson = curl.exe -s "http://localhost/auth/realms/master/.well-known/openid-configuration" 2>&1
if ($oidcJson -notmatch '"issuer":"http://localhost/auth/realms/master"') {
    Write-Host "  OIDC discovery: $oidcJson" -ForegroundColor Red
    throw "Keycloak OIDC issuer is not http://localhost/auth/realms/master"
}
$adminHead = curl.exe -sI "http://localhost/auth/admin/" 2>&1 | Out-String
if ($adminHead -notmatch "Location: http://localhost/auth/admin/master/console/") {
    Write-Host "  /auth/admin/ headers:`n$adminHead" -ForegroundColor Red
    throw "Keycloak admin redirect Location is wrong (must not use :8000)."
}
Write-Host "  Keycloak edge OIDC checks passed." -ForegroundColor Green

Write-Host "  Running OAuth login smoke test (security-admin-console) ..." -ForegroundColor Gray
$oauthTest = Join-Path $PSScriptRoot "scripts\test-keycloak-admin-oauth.py"
if (-not (Test-Path $oauthTest)) { throw "Missing $oauthTest" }
python $oauthTest
if ($LASTEXITCODE -ne 0) { throw "Keycloak admin OAuth smoke test failed (cookie/login/token). See script output above." }

Write-Host "  Admin console: http://localhost/auth/admin/  (use a private window after deploy)" -ForegroundColor Cyan

# ── Final Status ──────────────────────────────────────────────────────────
Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host " Deployment Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Pod Status:" -ForegroundColor White
kubectl get pods -A
Write-Host ""
Write-Host "Public edge (WAF LoadBalancer): http://localhost" -ForegroundColor Cyan
Write-Host "Next step: run  .\start-ui.ps1  to access the UI and port-forwards" -ForegroundColor Cyan
Write-Host ""