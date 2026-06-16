#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# vault-sync-k8s-secrets.sh  -  Read secrets from Vault → create K8s Secrets
#
# Reads every Vault KV v2 path seeded by vault-seed.sh, then creates/updates
# the corresponding Kubernetes secrets with kubectl.
#
# Pattern: kubectl create secret ... --dry-run=client -o yaml | kubectl apply -f -
# (idempotent; updates existing secrets without error)
#
# Vault must be accessible at $VAULT_ADDR (port-forward must still be running
# when this script executes).
#
# Usage:
#   ./scripts/vault-sync-k8s-secrets.sh
#   ./scripts/vault-sync-k8s-secrets.sh "http://localhost:8200" "dev-root-token"
# ─────────────────────────────────────────────────────────────────────────────

set -e

VAULT_ADDR="${1:-http://localhost:8200}"
VAULT_TOKEN="${2:-dev-root-token}"

# Colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m'

# ── Helper: read a Vault KV v2 path → extracts a field value ────────────────
get_vault_field() {
    local path="$1"
    local field="$2"
    local uri="${VAULT_ADDR}/v1/secret/data/${path}"
    local resp
    resp=$(curl -s -H "X-Vault-Token: ${VAULT_TOKEN}" "$uri")
    echo "$resp" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['data']['data']['${field}'])" 2>/dev/null
}

# ── Helper: kubectl apply a generic secret (key=value pairs) ─────────────────
sync_k8s_generic_secret() {
    local name="$1"
    local namespace="$2"
    shift 2
    # Remaining args are key=value pairs
    local args=("create" "secret" "generic" "$name" "--namespace=$namespace")
    for kv in "$@"; do
        args+=("--from-literal=$kv")
    done
    args+=("--dry-run=client" "-o" "yaml")

    kubectl "${args[@]}" | kubectl apply -f -
    echo -e "  ${GREEN}[OK] secret/${name} in ${namespace}${NC}"
}

# ── Helper: kubectl apply a TLS secret ───────────────────────────────────────
sync_k8s_tls_secret() {
    local name="$1"
    local namespace="$2"
    local cert_data="$3"
    local key_data="$4"

    local tmp_crt tmp_key
    tmp_crt=$(mktemp)
    tmp_key=$(mktemp)

    echo "$cert_data" > "$tmp_crt"
    echo "$key_data" > "$tmp_key"

    kubectl create secret tls "$name" \
        --namespace="$namespace" \
        --cert="$tmp_crt" \
        --key="$tmp_key" \
        --dry-run=client -o yaml | kubectl apply -f -

    rm -f "$tmp_crt" "$tmp_key"
    echo -e "  ${GREEN}[OK] secret/${name} (TLS) in ${namespace}${NC}"
}

echo -e "${CYAN}Reading secrets from Vault and syncing to K8s...${NC}"
echo ""

# ── 1. Platform Postgres ─────────────────────────────────────────────────────
echo -e "${YELLOW}[1/8] Platform Postgres${NC}"
pg_plat_user=$(get_vault_field "platform/postgres" "user")
pg_plat_pass=$(get_vault_field "platform/postgres" "password")
pg_plat_host=$(get_vault_field "platform/postgres" "host")
pg_plat_port=$(get_vault_field "platform/postgres" "port")
pg_plat_db=$(get_vault_field "platform/postgres" "db")

# ai-data namespace (used by the postgres-platform StatefulSet itself)
sync_k8s_generic_secret "platform-db-secret" "ai-data" \
    "POSTGRES_USER=${pg_plat_user}" \
    "POSTGRES_PASSWORD=${pg_plat_pass}" \
    "POSTGRES_DB=${pg_plat_db}"

# ai-application namespace (DATABASE_URL for FastAPI)
db_url="postgresql+asyncpg://${pg_plat_user}:${pg_plat_pass}@${pg_plat_host}:${pg_plat_port}/${pg_plat_db}"
sync_k8s_generic_secret "platform-db-secret" "ai-application" \
    "POSTGRES_USER=${pg_plat_user}" \
    "POSTGRES_PASSWORD=${pg_plat_pass}" \
    "POSTGRES_DB=${pg_plat_db}" \
    "DATABASE_URL=${db_url}"

# ── 2. Kong Postgres ─────────────────────────────────────────────────────────
echo -e "${YELLOW}[2/8] Kong Postgres${NC}"
pg_kong_user=$(get_vault_field "kong/postgres" "user")
pg_kong_pass=$(get_vault_field "kong/postgres" "password")
pg_kong_db=$(get_vault_field "kong/postgres" "db")

sync_k8s_generic_secret "kong-db-secret" "ai-data" \
    "POSTGRES_USER=${pg_kong_user}" \
    "POSTGRES_PASSWORD=${pg_kong_pass}" \
    "POSTGRES_DB=${pg_kong_db}" \
    "KONG_PG_PASSWORD=${pg_kong_pass}"

sync_k8s_generic_secret "kong-db-secret" "ai-gateway" \
    "POSTGRES_USER=${pg_kong_user}" \
    "POSTGRES_PASSWORD=${pg_kong_pass}" \
    "POSTGRES_DB=${pg_kong_db}" \
    "KONG_PG_PASSWORD=${pg_kong_pass}"

# ── 3. Keycloak Postgres ─────────────────────────────────────────────────────
echo -e "${YELLOW}[3/8] Keycloak Postgres${NC}"
pg_kc_user=$(get_vault_field "keycloak/postgres" "user")
pg_kc_pass=$(get_vault_field "keycloak/postgres" "password")
pg_kc_host=$(get_vault_field "keycloak/postgres" "host")
pg_kc_port=$(get_vault_field "keycloak/postgres" "port")
pg_kc_db=$(get_vault_field "keycloak/postgres" "db")

sync_k8s_generic_secret "keycloak-db-secret" "ai-data" \
    "POSTGRES_USER=${pg_kc_user}" \
    "POSTGRES_PASSWORD=${pg_kc_pass}" \
    "POSTGRES_DB=${pg_kc_db}"

# ── 4. Keycloak admin ────────────────────────────────────────────────────────
echo -e "${YELLOW}[4/8] Keycloak admin${NC}"
kc_admin_user=$(get_vault_field "keycloak/admin" "username")
kc_admin_pass=$(get_vault_field "keycloak/admin" "password")
kc_db_url="jdbc:postgresql://${pg_kc_host}:${pg_kc_port}/${pg_kc_db}"

sync_k8s_generic_secret "keycloak-secret" "ai-application" \
    "KC_DB_URL=${kc_db_url}" \
    "KC_DB_PASSWORD=${pg_kc_pass}" \
    "KEYCLOAK_ADMIN=${kc_admin_user}" \
    "KEYCLOAK_ADMIN_PASSWORD=${kc_admin_pass}"

# ── 5. Redis ─────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[5/8] Redis${NC}"
redis_pass=$(get_vault_field "redis/platform" "password")

sync_k8s_generic_secret "redis-secret" "ai-data" \
    "REDIS_PASSWORD=${redis_pass}"

redis_url="redis://:${redis_pass}@redis.ai-data.svc.cluster.local:6379/0"
redis_url_db1="redis://:${redis_pass}@redis.ai-data.svc.cluster.local:6379/1"
sync_k8s_generic_secret "redis-secret" "ai-application" \
    "REDIS_PASSWORD=${redis_pass}" \
    "REDIS_URL=${redis_url}" \
    "REDIS_URL_DB1=${redis_url_db1}"

# ── 6. Grafana admin ─────────────────────────────────────────────────────────
echo -e "${YELLOW}[6/8] Grafana admin${NC}"
grafana_pass=$(get_vault_field "monitoring/grafana" "admin_password")

# Ensure ai-monitoring namespace exists before creating the secret
kubectl create namespace ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
sync_k8s_generic_secret "grafana-admin-secret" "ai-monitoring" \
    "GF_SECURITY_ADMIN_PASSWORD=${grafana_pass}"

# ── 7. Kong cluster TLS ───────────────────────────────────────────────────────
echo -e "${YELLOW}[7/8] Kong cluster TLS certs${NC}"
kong_tls_crt=$(get_vault_field "kong/cluster" "tls.crt")
kong_tls_key=$(get_vault_field "kong/cluster" "tls.key")
sync_k8s_tls_secret "kong-cluster-certs" "ai-gateway" "$kong_tls_crt" "$kong_tls_key"

# ── 8. HuggingFace token (stored as generic secret for optional pod mount) ────
echo -e "${YELLOW}[8/8] HuggingFace token${NC}"
hf_token=$(get_vault_field "ml/huggingface" "token")
sync_k8s_generic_secret "huggingface-secret" "ai-application" \
    "HF_TOKEN=${hf_token}"

echo ""
echo -e "${GREEN}All K8s secrets synced from Vault.${NC}"
