#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# deploy.sh  -  Enterprise AI Gateway Kubernetes Deployment Script (Linux)
#
# Usage:  ./deploy.sh
#
# This is the Bash equivalent of deploy.ps1 for Linux servers.
# Images are built as local :latest tags (imagePullPolicy Never in manifests).
# That matches single-node dev clusters (Docker Desktop, Minikube, kind). For
# multi-node production, push images to your registry, point manifests at those
# references, and use imagePullPolicy: IfNotPresent or Always as appropriate.
# ─────────────────────────────────────────────────────────────────────────────

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
DARKYELLOW='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
DARKGRAY='\033[1;30m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# ─────────────────────────────────────────────────────────────────────────────
# Ollama warm-up (Linux equivalent of the Windows Ollama section)
# ─────────────────────────────────────────────────────────────────────────────

# Check and configure OLLAMA_KEEP_ALIVE
ollama_keep_alive="${OLLAMA_KEEP_ALIVE:-}"
if [ "$ollama_keep_alive" != "-1" ]; then
    echo -e "${YELLOW}Configuring OLLAMA_KEEP_ALIVE=-1 (keep models loaded in memory)...${NC}"
    export OLLAMA_KEEP_ALIVE="-1"

    # Check if Ollama is running; if not, try to start it
    if command -v ollama &>/dev/null; then
        if ! pgrep -x "ollama" &>/dev/null; then
            echo -e "${GRAY}  Starting Ollama serve in background...${NC}"
            nohup ollama serve &>/dev/null &
            sleep 3
        fi
    elif systemctl is-active --quiet ollama 2>/dev/null; then
        echo -e "${GRAY}  Restarting Ollama service...${NC}"
        sudo systemctl restart ollama 2>/dev/null || true
        sleep 3
    else
        echo -e "${DARKYELLOW}  Warning: Ollama not found; install Ollama on the host for local LLM routing.${NC}"
    fi

    # Check if Ollama API is reachable
    if curl -s --max-time 5 "http://localhost:11434/api/tags" &>/dev/null; then
        echo -e "${GREEN}  Ollama API is reachable on :11434${NC}"
    else
        echo -e "${DARKYELLOW}  Warning: Ollama API not reachable yet at http://localhost:11434${NC}"
    fi
else
    echo -e "${GRAY}OLLAMA_KEEP_ALIVE already set to -1 (models stay warm).${NC}"
fi

# Warm up models into memory
echo -e "${YELLOW}Warming up Ollama models...${NC}"
required_models=("llama3.2:3b" "qwen2.5-coder:7b")
installed_tags=""
if curl -s --max-time 5 "http://localhost:11434/api/tags" &>/dev/null; then
    installed_tags=$(curl -s --max-time 5 "http://localhost:11434/api/tags" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    for m in data.get('models', []):
        print(m.get('name', ''))
except: pass
" 2>/dev/null || true)
else
    echo -e "${DARKYELLOW}  Warning: Ollama API not reachable; skipping model warmup.${NC}"
fi

for base_name in "${required_models[@]}"; do
    # Find matching installed tag
    tag=$(echo "$installed_tags" | grep -m1 "^${base_name}" || true)
    if [ -z "$tag" ]; then
        echo -e "${DARKYELLOW}  Warning: '${base_name}' is not installed. Run: ollama pull ${base_name}${NC}"
        continue
    fi

    echo -e "${GRAY}  Loading ${tag} into memory (this can take a few minutes)...${NC}"
    warmup_body="{\"model\":\"${tag}\",\"prompt\":\"warmup\",\"stream\":false,\"keep_alive\":-1}"
    if curl -s --max-time 300 -X POST "http://localhost:11434/api/generate" \
        -H "Content-Type: application/json" \
        -d "$warmup_body" &>/dev/null; then
        echo -e "${GREEN}  ${tag} warmed up (keep_alive=-1)${NC}"
    else
        echo -e "${DARKYELLOW}  Warning: could not warm up ${tag}${NC}"
    fi
done

if command -v ollama &>/dev/null; then
    echo -e "${GRAY}  Models currently loaded:${NC}"
    ollama ps 2>/dev/null || true
    echo -e "${DARKGRAY}  Note: if RAM is tight, Ollama may unload one model when loading the next.${NC}"
fi

echo ""
echo -e "${CYAN}==========================================${NC}"
echo -e "${CYAN} Deploying Enterprise AI Gateway to K8s   ${NC}"
echo -e "${CYAN}==========================================${NC}"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Functions
# ─────────────────────────────────────────────────────────────────────────────

ensure_command() {
    local cmd=$1
    if ! command -v "$cmd" &>/dev/null; then
        echo -e "${RED}Error: Required command '${cmd}' is not available in PATH.${NC}"
        exit 1
    fi
}

ensure_path() {
    local path_to_check=$1
    if [ ! -e "$path_to_check" ]; then
        echo -e "${RED}Error: Required path is missing: ${path_to_check}${NC}"
        exit 1
    fi
}

build_local_image() {
    local image_name=$1
    local dockerfile_dir=$2
    local dockerfile_path=${3:-""}
    local max_attempts=3

    for ((attempt=1; attempt<=max_attempts; attempt++)); do
        echo -e "${GRAY}  Building image: ${image_name} (attempt ${attempt}/${max_attempts})${NC}"

        local docker_args=("build" "--progress=plain" "-t" "$image_name")

        # Frontend Vite build arguments
        if [ "$image_name" = "api-gateways-frontend:latest" ]; then
            docker_args+=(
                "--build-arg" "VITE_KEYCLOAK_URL=http://localhost/auth"
                "--build-arg" "VITE_KEYCLOAK_REALM=newRealm"
                "--build-arg" "VITE_KEYCLOAK_CLIENT_ID=myclient"
                "--build-arg" "VITE_APP_URL=http://localhost"
                "--build-arg" "VITE_GRAFANA_URL=http://localhost/grafana"
                "--build-arg" "AI_ENDPOINT=https://localhost:8443/api/ai/orchestrate/"
            )
        fi

        if [ -n "$dockerfile_path" ]; then
            docker_args+=("-f" "$dockerfile_path")
        fi

        # Automatically pass HF_TOKEN if found in the build directory
        local hf_token_path="${dockerfile_dir}/.hf_token"
        if [ -f "$hf_token_path" ]; then
            docker_args+=("--secret" "id=hf_token,src=${hf_token_path}")
        fi

        docker_args+=("$dockerfile_dir")

        local log_file
        log_file=$(mktemp)
        local build_exit_code=0

        docker "${docker_args[@]}" 2>&1 | tee "$log_file" || build_exit_code=$?

        if [ $build_exit_code -eq 0 ]; then
            rm -f "$log_file"
            return 0
        fi

        local build_text=""
        if [ -f "$log_file" ]; then
            build_text=$(cat "$log_file")
            rm -f "$log_file"
        fi

        local is_retryable=false
        if echo "$build_text" | grep -q "TLS handshake timeout"; then
            is_retryable=true
        fi
        if echo "$build_text" | grep -q "failed to resolve source metadata"; then
            is_retryable=true
        fi

        if [ "$is_retryable" = false ] || [ $attempt -eq $max_attempts ]; then
            echo -e "${RED}Error: Failed to build image: ${image_name}${NC}"
            exit 1
        fi

        echo -e "${YELLOW}    Retrying build due to transient registry/network error...${NC}"
        sleep 2
    done
}

# ─────────────────────────────────────────────────────────────────────────────
# [0/8] Preflight checks
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[0/8] Running preflight checks...${NC}"
ensure_command "kubectl"
ensure_command "docker"

if ! kubectl cluster-info &>/dev/null; then
    echo -e "${RED}Error: kubectl cannot reach the active cluster context.${NC}"
    exit 1
fi

ensure_path "k8s/kustomization.yaml"
# secrets/secrets.yaml is no longer applied statically; Vault sync creates K8s secrets dynamically
# ensure_path "k8s/secrets/secrets.yaml"
ensure_path "backend/scripts/init-platform-db.sql"
ensure_path "backend/scripts/init-platform-db-usage.sql"
ensure_path "gateway/plugins/simple-validator"
ensure_path "gateway/plugins/tenant-restriction"
ensure_path "gateway/kong_final.yaml"
ensure_path "keycloak/realm-export.json"
ensure_path "monitoring/prometheus.yml"
ensure_path "monitoring/grafana/dashboards"
ensure_path "monitoring/grafana/provisioning/dashboards"
ensure_path "monitoring/grafana/provisioning/datasources"
ensure_path "intent_classifier_service/Dockerfile"
ensure_path "waf/Dockerfile"
ensure_path "waf/99-exclusions.sh"
ensure_path "k8s/application/keycloak-master-config-job.yaml"

echo -e "${GRAY}  Checking local images required by imagePullPolicy=Never...${NC}"
build_local_image "api-gateways-backend:latest" "fastapi_backend"
build_local_image "api-gateways-intent-classifier:latest" "." "intent_classifier_service/Dockerfile"
build_local_image "api-gateways-frontend:latest" "frontend"
build_local_image "api-gateways-kong-logger:latest" "kong-logger"

# Convert WAF entrypoint script to LF line endings (CRLF breaks the shebang
# in the Linux container on first copy from a Windows/git checkout).
waf_script="waf/99-exclusions.sh"
if [ -f "$waf_script" ]; then
    sed -i 's/\r$//' "$waf_script"
fi
build_local_image "api-gateways-waf:latest" "waf"

metrics_api=$(kubectl api-versions 2>/dev/null | grep "metrics.k8s.io" || true)
if [ -z "$metrics_api" ]; then
    echo -e "${YELLOW}  Warning: metrics-server API is unavailable; HPAs will report metric errors.${NC}"
fi

# ─────────────────────────────────────────────────────────────────────────────
# [1/5] Create Namespaces
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${YELLOW}[1/5] Creating namespaces...${NC}"
kubectl apply -f k8s/namespaces.yaml

# ─────────────────────────────────────────────────────────────────────────────
# [2/5] Create ConfigMaps (DB init scripts, Kong plugins, Configuration)
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${YELLOW}[2/5] Creating ConfigMaps...${NC}"
kubectl create configmap platform-db-init-scripts --from-file=init-platform-db.sql=backend/scripts/init-platform-db.sql -n ai-data --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap platform-db-usage-scripts --from-file=init-platform-db-usage.sql=backend/scripts/init-platform-db-usage.sql -n ai-data --dry-run=client -o yaml | kubectl apply -f -

kubectl create configmap kong-plugin-simple-validator --from-file=gateway/plugins/simple-validator -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap kong-plugin-tenant-restriction --from-file=gateway/plugins/tenant-restriction -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap kong-plugin-gateway-signature --from-file=gateway/plugins/gateway-signature -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap kong-deck-config --from-file=kong_final.yaml=gateway/kong_final.yaml -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap grafana-dashboards --from-file=monitoring/grafana/dashboards/ -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap grafana-provisioning-dashboards --from-file=monitoring/grafana/provisioning/dashboards/ -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap grafana-provisioning-datasources --from-file=datasource.yml=monitoring/grafana/provisioning/datasources/datasource.k8s.yml -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap keycloak-realm --from-file=realm-export.json=keycloak/realm-export.json -n ai-application --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap prometheus-config --from-file=prometheus.yml=monitoring/prometheus.k8s.yml -n ai-monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap promtail-kong-config --from-file=promtail.yaml=monitoring/promtail/promtail-kong.k8s.yaml -n ai-application --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap promtail-waf-config --from-file=promtail.yaml=monitoring/promtail/promtail-waf.k8s.yaml -n ai-gateway --dry-run=client -o yaml | kubectl apply -f -

# ─────────────────────────────────────────────────────────────────────────────
# [3/5] Kong mTLS certificates
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${YELLOW}[3/5] Checking Kong mTLS certificates...${NC}"
if kubectl get secret kong-cluster-certs -n ai-gateway &>/dev/null; then
    echo -e "${GREEN}  kong-cluster-certs secret already exists, skipping.${NC}"
else
    echo -e "${GRAY}  Generating new mTLS certificates...${NC}"
    docker run --rm -v "$(pwd)/k8s/secrets:/certs" alpine/openssl req -new -x509 -nodes -newkey rsa:2048 -keyout /certs/cluster.key -out /certs/cluster.crt -days 1095 -subj "/CN=kong_clustering"
    kubectl create secret tls kong-cluster-certs --cert=k8s/secrets/cluster.crt --key=k8s/secrets/cluster.key -n ai-gateway
fi

# ─────────────────────────────────────────────────────────────────────────────
# [4/5] Deploy everything via Kustomize
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${YELLOW}[4/5] Deploying all services...${NC}"
apply_output=$(kubectl apply -k k8s/ 2>&1) || {
    echo "$apply_output"
    echo -e "${RED}Error: Step [6/8] failed: kubectl apply -k k8s/ returned non-zero exit code.${NC}"
    exit 1
}
if [ -n "$apply_output" ]; then
    echo "$apply_output"
fi

# ── Wait for services ─────────────────────────────────────────────────────
echo ""
echo -e "${GRAY}Sleeping 10s to let Kubernetes schedule new pods...${NC}"
sleep 10

echo -e "${GRAY}Waiting for databases...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=platform-db -n ai-data --timeout=300s; then
    echo -e "${RED}  platform-db failed to become ready. Dumping pod info...${NC}"
    kubectl describe pod -l app=platform-db -n ai-data || true
    kubectl logs -l app=platform-db -n ai-data --all-containers=true --tail=50 || true
    echo -e "${RED}Error: platform-db pods did not become ready in time.${NC}"
    exit 1
fi
if ! kubectl wait --for=condition=ready pod -l app=kong-db -n ai-data --timeout=300s; then
    echo -e "${RED}  kong-db failed to become ready. Dumping pod info...${NC}"
    kubectl describe pod -l app=kong-db -n ai-data || true
    kubectl logs -l app=kong-db -n ai-data --all-containers=true --tail=50 || true
    echo -e "${RED}Error: kong-db pods did not become ready in time.${NC}"
    exit 1
fi

echo -e "${GRAY}Waiting for application layer...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=fastapi -n ai-application --timeout=1200s; then
    echo -e "${RED}  fastapi failed to become ready. Dumping pod info...${NC}"
    kubectl describe pod -l app=fastapi -n ai-application || true
    kubectl logs -l app=fastapi -n ai-application --all-containers=true --tail=50 || true
    echo -e "${RED}Error: fastapi pods did not become ready in time.${NC}"
    exit 1
fi
if ! kubectl wait --for=condition=ready pod -l app=intent-classifier -n ai-application --timeout=300s; then
    echo -e "${RED}  intent-classifier failed to become ready. Dumping pod info...${NC}"
    kubectl describe pod -l app=intent-classifier -n ai-application || true
    kubectl logs -l app=intent-classifier -n ai-application --all-containers=true --tail=50 || true
    echo -e "${RED}Error: intent-classifier pods did not become ready in time.${NC}"
    exit 1
fi
if ! kubectl wait --for=condition=ready pod -l app=opa -n ai-application --timeout=180s; then
    echo -e "${RED}  opa failed to become ready. Dumping pod info...${NC}"
    kubectl describe pod -l app=opa -n ai-application || true
    kubectl logs -l app=opa -n ai-application --all-containers=true --tail=50 || true
    echo -e "${RED}Error: opa pods did not become ready in time.${NC}"
    exit 1
fi

echo -e "${GRAY}Waiting for Keycloak...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=keycloak -n ai-application --timeout=600s; then
    echo -e "${RED}  keycloak failed to become ready. Dumping pod info...${NC}"
    kubectl describe pod -l app=keycloak -n ai-application || true
    kubectl logs -l app=keycloak -n ai-application --tail=80 || true
    echo -e "${RED}Error: keycloak pod did not become ready in time.${NC}"
    exit 1
fi
echo -e "${GREEN}  Keycloak is running.${NC}"

echo -e "${GRAY}Waiting for WAF edge pod...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=waf -n ai-gateway --timeout=300s; then
    waf_phase=$(kubectl get pod -l app=waf -n ai-gateway -o jsonpath="{.items[0].status.phase}" 2>/dev/null || true)
    if [ "$waf_phase" = "Running" ]; then
        echo -e "${GREEN}  WAF pod is Running (from prior deployment). Proceeding.${NC}"
    else
        echo -e "${RED}  WAF pod did not become ready. Dumping pod info...${NC}"
        kubectl describe pod -l app=waf -n ai-gateway || true
        kubectl logs -l app=waf -n ai-gateway --all-containers=true --tail=50 || true
        echo -e "${RED}Error: WAF pod did not become ready in time.${NC}"
        exit 1
    fi
fi
echo -e "${GREEN}  WAF is running.${NC}"

echo -e "${GRAY}Waiting for gateway...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=kong-cp -n ai-gateway --timeout=240s; then
    echo -e "${YELLOW}  Kong CP did not become ready; restarting control plane once...${NC}"
    kubectl rollout restart deployment/kong-cp -n ai-gateway
    if ! kubectl rollout status deployment/kong-cp -n ai-gateway --timeout=240s; then
        echo -e "${RED}Error: kong-cp failed to become ready after restart.${NC}"
        exit 1
    fi
fi

# ─────────────────────────────────────────────────────────────────────────────
# [5/5] Sync Kong Configuration using Deck
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${YELLOW}[5/5] Synchronizing Kong Configuration...${NC}"
if ! kubectl apply -f k8s/gateway/kong-deck-sync.yaml; then
    echo -e "${RED}Error: Failed to create kong-deck-sync job.${NC}"
    exit 1
fi
if ! kubectl wait --for=condition=complete job/kong-deck-sync -n ai-gateway --timeout=180s; then
    echo -e "${RED}  kong-deck-sync failed; dumping job logs...${NC}"
    kubectl logs job/kong-deck-sync -n ai-gateway --tail=200 || true
    echo -e "${RED}Error: kong-deck-sync job did not complete successfully.${NC}"
    exit 1
fi



# ─────────────────────────────────────────────────────────────────────────────
# Final Status
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN} Deployment Complete!                     ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo ""
echo -e "${WHITE}Pod Status:${NC}"
kubectl get pods -A
echo ""
echo -e "${CYAN}Public edge (WAF LoadBalancer): http://localhost${NC}"
echo -e "${CYAN}Next step: access the UI at http://localhost${NC}"
echo ""
