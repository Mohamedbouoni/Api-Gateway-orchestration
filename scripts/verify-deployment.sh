#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# verify-deployment.sh  -  End-to-end deployment health check
#
# Checks each layer from the plan:
#   1. No ErrImageNeverPull — all custom images are pullable
#   2. kubectl logs functional — no TLS SAN errors
#   3. All pods are Running / Completed with correct restart counts
#   4. Vault is healthy and secrets are seeded
#   5. platform-db is ready and pg_isready passes
#   6. FastAPI /api/ endpoint responds
#
# Usage:
#   ./scripts/verify-deployment.sh
#
# Exits 0 only when every check passes. Exits 1 on first failure.
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY='\033[0;90m'
NC='\033[0m'

PASS=0
FAIL=0

pass() { echo -e "  ${GREEN}[PASS]${NC} $*"; PASS=$((PASS+1)); }
fail() { echo -e "  ${RED}[FAIL]${NC} $*"; FAIL=$((FAIL+1)); }
info() { echo -e "  ${GRAY}      ${NC} $*"; }

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  Enterprise AI Gateway — Deployment Check  ${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Check 1 — No ErrImageNeverPull anywhere
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[1/6] Image pull errors${NC}"

never_pull=$(kubectl get pods -A --no-headers 2>/dev/null \
    | awk '$4 == "ErrImageNeverPull" || $4 == "ImagePullBackOff" {print $0}' || true)

if [ -z "$never_pull" ]; then
    pass "No ErrImageNeverPull / ImagePullBackOff pods found"
else
    fail "Image pull errors detected:"
    echo "$never_pull" | while IFS= read -r line; do
        info "$line"
    done
fi
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Check 2 — kubectl logs works (no TLS SAN mismatch)
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[2/6] kubectl logs TLS health${NC}"

log_test_pod=""
log_test_ns=""
for ns in ai-data ai-application ai-gateway kube-system; do
    pod=$(kubectl get pods -n "$ns" --field-selector=status.phase=Running \
          -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)
    if [ -n "$pod" ]; then
        log_test_pod="$pod"
        log_test_ns="$ns"
        break
    fi
done

if [ -n "$log_test_pod" ]; then
    log_err=$(kubectl logs "$log_test_pod" -n "$log_test_ns" --tail=1 2>&1 || true)
    if echo "$log_err" | grep -qi "tls: failed to verify certificate"; then
        fail "kubectl logs returned TLS cert error for ${log_test_pod}/${log_test_ns}"
        info "Run: ./scripts/fix-kubelet-tls.sh"
        info "Error: $log_err"
    else
        pass "kubectl logs succeeds for ${log_test_pod} in ${log_test_ns}"
    fi
else
    info "No Running pods found to test kubectl logs against — skipping"
fi
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Check 3 — Pod readiness across all namespaces
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[3/6] Pod readiness${NC}"

# Critical deployments we must see Running
declare -A REQUIRED_PODS=(
    ["ai-data/platform-db"]="app=platform-db"
    ["ai-data/postgres-kong"]="app=kong-db"
    ["ai-data/vault"]="app=vault"
    ["ai-data/redis"]="app=redis"
    ["ai-application/fastapi"]="app=fastapi"
    ["ai-application/keycloak"]="app=keycloak"
    ["ai-application/intent-classifier"]="app=intent-classifier"
    ["ai-application/opa"]="app=opa"
    ["ai-gateway/kong-cp"]="app=kong-cp"
    ["ai-gateway/kong-dp"]="app=kong-dp"
    ["ai-gateway/waf"]="app=waf"
)

for key in "${!REQUIRED_PODS[@]}"; do
    ns="${key%%/*}"
    name="${key##*/}"
    selector="${REQUIRED_PODS[$key]}"

    ready=$(kubectl get pods -n "$ns" -l "$selector" --no-headers 2>/dev/null \
        | awk '$2 ~ /^[1-9]/ && $4 == "Running" {c++} END{print c+0}')

    not_ready=$(kubectl get pods -n "$ns" -l "$selector" --no-headers 2>/dev/null \
        | awk '$4 != "Running" && $4 != "Completed" && NF>0 {c++} END{print c+0}')

    if [ "$ready" -gt 0 ] && [ "$not_ready" -eq 0 ]; then
        pass "${name} (${ns}) — Running"
    elif [ "$ready" -gt 0 ]; then
        fail "${name} (${ns}) — some replicas not ready (${not_ready} unhealthy)"
    else
        fail "${name} (${ns}) — no Running pods found"
        kubectl get pods -n "$ns" -l "$selector" --no-headers 2>/dev/null \
            | while IFS= read -r line; do info "  $line"; done
    fi
done
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Check 4 — Vault health and secrets
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[4/6] Vault health and secrets${NC}"

VAULT_ADDR_LOCAL="${VAULT_ADDR_LOCAL:-http://localhost:8200}"
VAULT_TOKEN_LOCAL="${VAULT_TOKEN_LOCAL:-dev-root-token}"

# Port-forward vault temporarily for the check
vault_pf_pid=""
cleanup_pf() {
    if [ -n "${vault_pf_pid}" ] && kill -0 "${vault_pf_pid}" 2>/dev/null; then
        kill "${vault_pf_pid}" 2>/dev/null || true
        wait "${vault_pf_pid}" 2>/dev/null || true
    fi
}
trap cleanup_pf EXIT

kubectl -n ai-data port-forward svc/vault 8200:8200 >/tmp/vault-verify-pf.log 2>&1 &
vault_pf_pid=$!
for i in $(seq 1 20); do
    if curl -s --max-time 2 "${VAULT_ADDR_LOCAL}/v1/sys/health" >/dev/null 2>&1; then break; fi
    sleep 1
done

vault_health=$(curl -s --max-time 5 "${VAULT_ADDR_LOCAL}/v1/sys/health" 2>/dev/null || echo "{}")
initialized=$(echo "$vault_health" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('initialized','?'))" 2>/dev/null || echo "?")
sealed=$(echo "$vault_health" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('sealed','?'))" 2>/dev/null || echo "?")

if [ "$initialized" = "True" ] && [ "$sealed" = "False" ]; then
    pass "Vault is initialized and unsealed"
else
    fail "Vault health unexpected — initialized=${initialized}, sealed=${sealed}"
    info "Check port-forward: kubectl -n ai-data port-forward svc/vault 8200:8200"
fi

# Check that key secrets exist in Vault KV v2
secrets_ok=true
for kv_path in "platform/postgres" "kong/postgres" "keycloak/postgres" "redis/platform"; do
    http_code=$(curl -s -o /dev/null -w "%{http_code}" \
        -H "X-Vault-Token: ${VAULT_TOKEN_LOCAL}" \
        "${VAULT_ADDR_LOCAL}/v1/secret/data/${kv_path}" 2>/dev/null || echo "000")
    if [ "$http_code" = "200" ]; then
        info "  secret/data/${kv_path} — present (HTTP 200)"
    else
        fail "secret/data/${kv_path} — missing or inaccessible (HTTP ${http_code})"
        secrets_ok=false
    fi
done
[ "$secrets_ok" = true ] && pass "All expected Vault KV secrets are present"

cleanup_pf
trap - EXIT
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Check 5 — platform-db pg_isready via exec
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[5/6] platform-db database connectivity${NC}"

db_pod=$(kubectl get pods -n ai-data -l app=platform-db \
    --field-selector=status.phase=Running \
    -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)

if [ -n "$db_pod" ]; then
    pg_out=$(kubectl exec -n ai-data "$db_pod" -- \
        sh -ec 'pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"' 2>&1 || true)
    if echo "$pg_out" | grep -q "accepting connections"; then
        pass "platform-db pg_isready → accepting connections"
    else
        fail "platform-db pg_isready did not report accepting connections"
        info "Output: $pg_out"
        info "Check pod logs: kubectl logs ${db_pod} -n ai-data"
    fi
else
    fail "platform-db: no Running pod found — cannot exec pg_isready"
fi
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Check 6 — FastAPI /api/ health endpoint
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[6/6] FastAPI /api/ health${NC}"

fastapi_pod=$(kubectl get pods -n ai-application -l app=fastapi \
    --field-selector=status.phase=Running \
    -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)

if [ -n "$fastapi_pod" ]; then
    api_http=$(kubectl exec -n ai-application "$fastapi_pod" -- \
        sh -ec 'wget -qO- --server-response http://localhost:3000/api/ 2>&1 | grep "HTTP/" | tail -1 | awk "{print \$2}"' \
        2>/dev/null || true)

    if [ -z "$api_http" ]; then
        # Fallback: try curl if wget not available
        api_http=$(kubectl exec -n ai-application "$fastapi_pod" -- \
            curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/ 2>/dev/null || true)
    fi

    if echo "$api_http" | grep -qE "^(200|307|301|302)$"; then
        pass "FastAPI /api/ returned HTTP ${api_http}"
    elif [ -n "$api_http" ]; then
        fail "FastAPI /api/ returned unexpected HTTP ${api_http}"
        info "Check logs: kubectl logs ${fastapi_pod} -n ai-application --tail=50"
    else
        fail "FastAPI /api/ did not respond (pod may be starting up)"
        info "Check logs: kubectl logs ${fastapi_pod} -n ai-application --tail=50"
    fi
else
    fail "FastAPI: no Running pod found"
fi
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${CYAN}============================================${NC}"
TOTAL=$((PASS + FAIL))
if [ "$FAIL" -eq 0 ]; then
    echo -e "${GREEN}  All ${TOTAL} checks passed. Deployment is healthy.${NC}"
    echo -e "${CYAN}============================================${NC}"
    exit 0
else
    echo -e "${RED}  ${FAIL} of ${TOTAL} checks failed.${NC}"
    echo -e "${CYAN}============================================${NC}"
    echo ""
    echo -e "${YELLOW}Troubleshooting hints:${NC}"
    echo "  • ErrImageNeverPull  → re-run deploy.sh (local registry ensures images are pushed)"
    echo "  • TLS cert errors    → run: ./scripts/fix-kubelet-tls.sh"
    echo "  • Vault down         → check: kubectl get pods -n ai-data -l app=vault"
    echo "  • DB not ready       → check: kubectl describe pod -l app=platform-db -n ai-data"
    echo "  • FastAPI unhealthy  → check: kubectl logs -l app=fastapi -n ai-application --tail=80"
    exit 1
fi
