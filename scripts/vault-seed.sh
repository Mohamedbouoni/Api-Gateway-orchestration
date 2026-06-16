#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# vault-seed.sh  -  Seed all platform secrets into Vault KV v2
#
# Expects Vault to be accessible at $VAULT_ADDR (default http://localhost:8200).
# Uses the Vault HTTP API directly - no vault CLI required.
# Idempotent: safe to re-run; existing values are overwritten.
#
# Usage:
#   ./scripts/vault-seed.sh
#   ./scripts/vault-seed.sh "http://localhost:8200" "dev-root-token"
# ─────────────────────────────────────────────────────────────────────────────

set -e

VAULT_ADDR="${1:-http://localhost:8200}"
VAULT_TOKEN="${2:-dev-root-token}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m'

# ── Helper: PUT a KV v2 secret ───────────────────────────────────────────────
set_vault_secret() {
    local path="$1"
    local json_data="$2"
    local uri="${VAULT_ADDR}/v1/secret/data/${path}"
    local body="{\"data\":${json_data}}"

    local http_code
    http_code=$(curl -s -o /dev/null -w "%{http_code}" \
        -X POST "$uri" \
        -H "X-Vault-Token: ${VAULT_TOKEN}" \
        -H "Content-Type: application/json" \
        -d "$body")

    if [[ "$http_code" =~ ^2 ]]; then
        echo -e "  ${GREEN}[OK] secret/data/${path}${NC}"
    else
        echo -e "  ${RED}[FAIL] secret/data/${path} (HTTP $http_code)${NC}"
        return 1
    fi
}

# ── Wait for Vault to be ready ────────────────────────────────────────────────
echo -e "${CYAN}Waiting for Vault at ${VAULT_ADDR} ...${NC}"
max_wait=30
for ((i=0; i<max_wait; i++)); do
    health=$(curl -s "${VAULT_ADDR}/v1/sys/health" 2>/dev/null || true)
    if echo "$health" | grep -q '"initialized":true' && echo "$health" | grep -q '"sealed":false'; then
        echo -e "  ${GREEN}Vault is ready (initialized=true, sealed=false)${NC}"
        break
    fi
    sleep 1
    if [ $i -eq $((max_wait - 1)) ]; then
        echo -e "${RED}Vault did not become ready after ${max_wait} seconds.${NC}"
        exit 1
    fi
done

# ── Enable KV v2 at secret/ (idempotent) ────────────────────────────────────
echo -e "${CYAN}Enabling KV v2 engine at 'secret/'...${NC}"
enable_code=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "${VAULT_ADDR}/v1/sys/mounts/secret" \
    -H "X-Vault-Token: ${VAULT_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"type":"kv","options":{"version":"2"}}')

if [[ "$enable_code" =~ ^2 ]]; then
    echo -e "  ${GREEN}[OK] KV v2 engine enabled${NC}"
else
    echo -e "  ${GRAY}[OK] KV v2 already enabled (or default dev engine present)${NC}"
fi

echo ""
echo -e "${CYAN}Seeding secrets...${NC}"

# ── 1. Platform Postgres ─────────────────────────────────────────────────────
set_vault_secret "platform/postgres" '{"user":"platform_admin","password":"platform_pass","host":"platform-db.ai-data.svc.cluster.local","port":"5432","db":"platform_permissions"}'

# ── 2. Kong Postgres ─────────────────────────────────────────────────────────
set_vault_secret "kong/postgres" '{"user":"kong","password":"kong","host":"postgres-kong.ai-data.svc.cluster.local","port":"5432","db":"kong"}'

# ── 3. Keycloak Postgres ─────────────────────────────────────────────────────
set_vault_secret "keycloak/postgres" '{"user":"keycloak","password":"password","host":"postgres-keycloak.ai-data.svc.cluster.local","port":"5432","db":"keycloak"}'

# ── 4. Keycloak admin ────────────────────────────────────────────────────────
set_vault_secret "keycloak/admin" '{"username":"admin","password":"admin"}'

# ── 5. Redis ─────────────────────────────────────────────────────────────────
set_vault_secret "redis/platform" '{"password":"redis-dev-pass"}'

# ── 5b. Kong → FastAPI HMAC (must match gateway-signature plugin secret) ───
set_vault_secret "gateway/signature" '{"secret":"dev-gateway-hmac-secret-change-me"}'

# ── 6. Hugging Face token ─────────────────────────────────────────────────────
hf_token_path="${ROOT}/fastapi_backend/.hf_token"
if [ -f "$hf_token_path" ]; then
    hf_token=$(cat "$hf_token_path" | tr -d '[:space:]')
    set_vault_secret "ml/huggingface" "{\"token\":\"${hf_token}\"}"
else
    echo -e "  ${YELLOW}[WARN] .hf_token not found at ${hf_token_path} - seeding placeholder${NC}"
    set_vault_secret "ml/huggingface" '{"token":"hf_PLACEHOLDER"}'
fi

# ── 7. Kong cluster TLS certs ────────────────────────────────────────────────
cert_path="${ROOT}/k8s/secrets/cluster.crt"
key_path="${ROOT}/k8s/secrets/cluster.key"

if [ ! -f "$cert_path" ] || [ ! -f "$key_path" ]; then
    echo -e "  ${YELLOW}Generating Kong mTLS certs (not found locally)...${NC}"
    certs_dir="${ROOT}/k8s/secrets"
    mkdir -p "$certs_dir"
    docker run --rm -v "${certs_dir}:/certs" alpine/openssl req -new -x509 -nodes \
        -newkey rsa:2048 -keyout /certs/cluster.key -out /certs/cluster.crt \
        -days 1095 -subj "/CN=kong_clustering"
fi

# Read cert and key, escape newlines for JSON
tls_crt=$(cat "$cert_path" | sed ':a;N;$!ba;s/\n/\\n/g')
tls_key=$(cat "$key_path" | sed ':a;N;$!ba;s/\n/\\n/g')
set_vault_secret "kong/cluster" "{\"tls.crt\":\"${tls_crt}\",\"tls.key\":\"${tls_key}\"}"

# ── 8. Grafana admin ─────────────────────────────────────────────────────────
set_vault_secret "monitoring/grafana" '{"admin_password":"admin"}'

echo ""
echo -e "${GREEN}All secrets seeded successfully.${NC}"
echo -e "${CYAN}Vault UI: ${VAULT_ADDR}/ui  (token: ${VAULT_TOKEN})${NC}"
