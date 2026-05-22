# ─────────────────────────────────────────────────────────────────────────────
# vault-sync-k8s-secrets.ps1  -  Read secrets from Vault → create K8s Secrets
#
# Reads every Vault KV v2 path seeded by vault-seed.ps1, then creates/updates
# the corresponding Kubernetes secrets with kubectl.
#
# Pattern: kubectl create secret ... --dry-run=client -o yaml | kubectl apply -f -
# (idempotent; updates existing secrets without error)
#
# Vault must be accessible at $VaultAddr (port-forward must still be running
# when this script executes, OR run after vault-seed.ps1 before stopping PF).
#
# Usage:
#   .\scripts\vault-sync-k8s-secrets.ps1
#   .\scripts\vault-sync-k8s-secrets.ps1 -VaultAddr "http://localhost:8200" -VaultToken "dev-root-token"
# ─────────────────────────────────────────────────────────────────────────────
param(
    [string]$VaultAddr  = "http://localhost:8200",
    [string]$VaultToken = "dev-root-token"
)

$ErrorActionPreference = "Stop"

# ── Helper: read a Vault KV v2 path → returns .data.data hashtable ───────────
function Get-VaultSecret {
    param([string]$Path)
    $uri = "$VaultAddr/v1/secret/data/$Path"
    $resp = Invoke-RestMethod -Uri $uri -Method Get `
        -Headers @{ "X-Vault-Token" = $VaultToken }
    return $resp.data.data
}

# ── Helper: kubectl apply a generic secret (key=value pairs) ─────────────────
function Sync-K8sGenericSecret {
    param(
        [string]$Name,
        [string]$Namespace,
        [hashtable]$Data
    )
    $args = @("create", "secret", "generic", $Name, "--namespace=$Namespace")
    foreach ($k in $Data.Keys) {
        $args += "--from-literal=$k=$($Data[$k])"
    }
    $args += "--dry-run=client", "-o", "yaml"

    $yaml = & kubectl @args
    $yaml | kubectl apply -f -
    Write-Host "  [OK] secret/$Name in $Namespace" -ForegroundColor Green
}

# ── Helper: kubectl apply a TLS secret ───────────────────────────────────────
function Sync-K8sTlsSecret {
    param(
        [string]$Name,
        [string]$Namespace,
        [string]$Cert,
        [string]$Key
    )
    # Write cert/key to temp files (kubectl tls needs files)
    $tmpCrt = [System.IO.Path]::GetTempFileName()
    $tmpKey = [System.IO.Path]::GetTempFileName()
    try {
        [System.IO.File]::WriteAllText($tmpCrt, $Cert)
        [System.IO.File]::WriteAllText($tmpKey, $Key)

        $yaml = & kubectl create secret tls $Name `
            --namespace=$Namespace `
            --cert=$tmpCrt `
            --key=$tmpKey `
            --dry-run=client -o yaml
        $yaml | kubectl apply -f -
        Write-Host "  [OK] secret/$Name (TLS) in $Namespace" -ForegroundColor Green
    } finally {
        Remove-Item $tmpCrt, $tmpKey -ErrorAction SilentlyContinue
    }
}

Write-Host "Reading secrets from Vault and syncing to K8s..." -ForegroundColor Cyan
Write-Host ""

# ── 1. Platform Postgres ─────────────────────────────────────────────────────
Write-Host "[1/8] Platform Postgres" -ForegroundColor Yellow
$pgPlat = Get-VaultSecret "platform/postgres"

# ai-data namespace (used by the postgres-platform StatefulSet itself)
Sync-K8sGenericSecret "platform-db-secret" "ai-data" @{
    POSTGRES_USER     = $pgPlat.user
    POSTGRES_PASSWORD = $pgPlat.password
    POSTGRES_DB       = $pgPlat.db
}

# ai-application namespace (DATABASE_URL for FastAPI)
$dbUrl = "postgresql+asyncpg://$($pgPlat.user):$($pgPlat.password)@$($pgPlat.host):$($pgPlat.port)/$($pgPlat.db)"
Sync-K8sGenericSecret "platform-db-secret" "ai-application" @{
    POSTGRES_USER     = $pgPlat.user
    POSTGRES_PASSWORD = $pgPlat.password
    POSTGRES_DB       = $pgPlat.db
    DATABASE_URL      = $dbUrl
}

# ── 2. Kong Postgres ─────────────────────────────────────────────────────────
Write-Host "[2/8] Kong Postgres" -ForegroundColor Yellow
$pgKong = Get-VaultSecret "kong/postgres"

Sync-K8sGenericSecret "kong-db-secret" "ai-data" @{
    POSTGRES_USER     = $pgKong.user
    POSTGRES_PASSWORD = $pgKong.password
    POSTGRES_DB       = $pgKong.db
    KONG_PG_PASSWORD  = $pgKong.password
}

Sync-K8sGenericSecret "kong-db-secret" "ai-gateway" @{
    POSTGRES_USER     = $pgKong.user
    POSTGRES_PASSWORD = $pgKong.password
    POSTGRES_DB       = $pgKong.db
    KONG_PG_PASSWORD  = $pgKong.password
}

# ── 3. Keycloak Postgres ─────────────────────────────────────────────────────
Write-Host "[3/8] Keycloak Postgres" -ForegroundColor Yellow
$pgKc = Get-VaultSecret "keycloak/postgres"

Sync-K8sGenericSecret "keycloak-db-secret" "ai-data" @{
    POSTGRES_USER     = $pgKc.user
    POSTGRES_PASSWORD = $pgKc.password
    POSTGRES_DB       = $pgKc.db
}

# ── 4. Keycloak admin ────────────────────────────────────────────────────────
Write-Host "[4/8] Keycloak admin" -ForegroundColor Yellow
$kcAdmin = Get-VaultSecret "keycloak/admin"
$kcDbUrl = "jdbc:postgresql://$($pgKc.host):$($pgKc.port)/$($pgKc.db)"

Sync-K8sGenericSecret "keycloak-secret" "ai-application" @{
    KC_DB_URL                = $kcDbUrl
    KC_DB_PASSWORD           = $pgKc.password
    KEYCLOAK_ADMIN           = $kcAdmin.username
    KEYCLOAK_ADMIN_PASSWORD  = $kcAdmin.password
}

# ── 5. Redis ─────────────────────────────────────────────────────────────────
Write-Host "[5/8] Redis" -ForegroundColor Yellow
$redis = Get-VaultSecret "redis/platform"

Sync-K8sGenericSecret "redis-secret" "ai-data" @{
    REDIS_PASSWORD = $redis.password
}

# ── 6. Grafana admin ─────────────────────────────────────────────────────────
Write-Host "[6/8] Grafana admin" -ForegroundColor Yellow
$grafana = Get-VaultSecret "monitoring/grafana"

# Ensure ai-monitoring namespace exists before creating the secret
kubectl create namespace ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
Sync-K8sGenericSecret "grafana-admin-secret" "ai-monitoring" @{
    GF_SECURITY_ADMIN_PASSWORD = $grafana.admin_password
}

# ── 7. Kong cluster TLS ───────────────────────────────────────────────────────
Write-Host "[7/8] Kong cluster TLS certs" -ForegroundColor Yellow
$kongCerts = Get-VaultSecret "kong/cluster"
Sync-K8sTlsSecret "kong-cluster-certs" "ai-gateway" $kongCerts."tls.crt" $kongCerts."tls.key"

# ── 8. HuggingFace token (stored as generic secret for optional pod mount) ────
Write-Host "[8/8] HuggingFace token" -ForegroundColor Yellow
$hf = Get-VaultSecret "ml/huggingface"
Sync-K8sGenericSecret "huggingface-secret" "ai-application" @{
    HF_TOKEN = $hf.token
}

Write-Host ""
Write-Host "All K8s secrets synced from Vault." -ForegroundColor Green
