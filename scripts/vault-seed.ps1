# ─────────────────────────────────────────────────────────────────────────────
# vault-seed.ps1  -  Seed all platform secrets into Vault KV v2
#
# Expects Vault to be accessible at $VaultAddr (default http://localhost:8200).
# Uses the Vault HTTP API directly - no vault CLI required.
# Idempotent: safe to re-run; existing values are overwritten.
#
# Usage:
#   .\scripts\vault-seed.ps1
#   .\scripts\vault-seed.ps1 -VaultAddr "http://localhost:8200" -VaultToken "dev-root-token"
# ─────────────────────────────────────────────────────────────────────────────
param(
    [string]$VaultAddr  = "http://localhost:8200",
    [string]$VaultToken = "dev-root-token"
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot

# ── Helper: PUT a KV v2 secret ───────────────────────────────────────────────
function Set-VaultSecret {
    param(
        [string]$Path,
        [hashtable]$Data
    )
    $uri  = "$VaultAddr/v1/secret/data/$Path"
    $body = @{ data = $Data } | ConvertTo-Json -Depth 5 -Compress
    try {
        $null = Invoke-RestMethod -Uri $uri -Method Post `
            -Headers @{ "X-Vault-Token" = $VaultToken; "Content-Type" = "application/json" } `
            -Body $body
        Write-Host "  [OK] secret/data/$Path" -ForegroundColor Green
    } catch {
        $msg = $_.Exception.Message
        # 400 can mean the engine is already at v2; treat as OK for idempotent enable
        if ($msg -notmatch "path is already in use") {
            throw "Failed to write secret/data/$Path : $msg"
        }
    }
}

# ── Wait for Vault to be ready ────────────────────────────────────────────────
Write-Host "Waiting for Vault at $VaultAddr ..." -ForegroundColor Cyan
$maxWait = 30
for ($i = 0; $i -lt $maxWait; $i++) {
    try {
        $health = Invoke-RestMethod -Uri "$VaultAddr/v1/sys/health" -Method Get -ErrorAction Stop
        if ($health.initialized -and -not $health.sealed) {
            Write-Host "  Vault is ready (initialized=$($health.initialized), sealed=$($health.sealed))" -ForegroundColor Green
            break
        }
    } catch { }
    Start-Sleep -Seconds 1
    if ($i -eq ($maxWait - 1)) {
        throw "Vault did not become ready after $maxWait seconds."
    }
}

# ── Enable KV v2 at secret/ (idempotent) ────────────────────────────────────
Write-Host "Enabling KV v2 engine at 'secret/'..." -ForegroundColor Cyan
try {
    $null = Invoke-RestMethod -Uri "$VaultAddr/v1/sys/mounts/secret" -Method Post `
        -Headers @{ "X-Vault-Token" = $VaultToken; "Content-Type" = "application/json" } `
        -Body '{"type":"kv","options":{"version":"2"}}'
    Write-Host "  [OK] KV v2 engine enabled" -ForegroundColor Green
} catch {
    # Already mounted - safe to ignore
    Write-Host "  [OK] KV v2 already enabled (or default dev engine present)" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "Seeding secrets..." -ForegroundColor Cyan

# ── 1. Platform Postgres ─────────────────────────────────────────────────────
Set-VaultSecret "platform/postgres" @{
    user     = "platform_admin"
    password = "platform_pass"
    host     = "platform-db.ai-data.svc.cluster.local"
    port     = "5432"
    db       = "platform_permissions"
}

# ── 2. Kong Postgres ─────────────────────────────────────────────────────────
Set-VaultSecret "kong/postgres" @{
    user     = "kong"
    password = "kong"
    host     = "postgres-kong.ai-data.svc.cluster.local"
    port     = "5432"
    db       = "kong"
}

# ── 3. Keycloak Postgres ─────────────────────────────────────────────────────
Set-VaultSecret "keycloak/postgres" @{
    user     = "keycloak"
    password = "password"
    host     = "postgres-keycloak.ai-data.svc.cluster.local"
    port     = "5432"
    db       = "keycloak"
}

# ── 4. Keycloak admin ────────────────────────────────────────────────────────
Set-VaultSecret "keycloak/admin" @{
    username = "admin"
    password = "admin"
}

# ── 5. Redis ─────────────────────────────────────────────────────────────────
Set-VaultSecret "redis/platform" @{
    password = "redis-dev-pass"
}

# ── 6. Hugging Face token ─────────────────────────────────────────────────────
$hfTokenPath = Join-Path $Root "fastapi_backend\.hf_token"
if (Test-Path $hfTokenPath) {
    $hfToken = (Get-Content $hfTokenPath -Raw).Trim()
    Set-VaultSecret "ml/huggingface" @{ token = $hfToken }
} else {
    Write-Host "  [WARN] .hf_token not found at $hfTokenPath - seeding placeholder" -ForegroundColor Yellow
    Set-VaultSecret "ml/huggingface" @{ token = "hf_PLACEHOLDER" }
}

# ── 7. Kong cluster TLS certs ────────────────────────────────────────────────
$certPath = Join-Path $Root "k8s\secrets\cluster.crt"
$keyPath  = Join-Path $Root "k8s\secrets\cluster.key"

if (-not (Test-Path $certPath) -or -not (Test-Path $keyPath)) {
    Write-Host "  Generating Kong mTLS certs (not found locally)..." -ForegroundColor Yellow
    $certsDir = Join-Path $Root "k8s\secrets"
    New-Item -ItemType Directory -Force -Path $certsDir | Out-Null
    docker run --rm -v "${certsDir}:/certs" alpine/openssl req -new -x509 -nodes `
        -newkey rsa:2048 -keyout /certs/cluster.key -out /certs/cluster.crt `
        -days 1095 -subj "/CN=kong_clustering"
}

$tlsCrt = (Get-Content $certPath -Raw).Trim()
$tlsKey = (Get-Content $keyPath  -Raw).Trim()
Set-VaultSecret "kong/cluster" @{
    "tls.crt" = $tlsCrt
    "tls.key" = $tlsKey
}

# ── 8. Grafana admin ─────────────────────────────────────────────────────────
Set-VaultSecret "monitoring/grafana" @{
    admin_password = "admin"
}

Write-Host ""
Write-Host "All secrets seeded successfully." -ForegroundColor Green
Write-Host "Vault UI: $VaultAddr/ui  (token: $VaultToken)" -ForegroundColor Cyan
