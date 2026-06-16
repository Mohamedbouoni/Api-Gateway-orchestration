#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# fix-kubelet-tls.sh  -  Fix kubelet serving certificate SAN mismatch
#
# Symptom:
#   "tls: failed to verify certificate ... valid for <old-IPs>, not <current-IP>"
#   when running kubectl logs / kubectl exec / kubectl describe.
#
# Root cause:
#   The kubelet serving TLS cert was issued with a Subject Alternative Name (SAN)
#   list that no longer matches the node IP the API server uses to reach kubelet
#   (e.g. after a server reboot, DHCP lease change, or Docker Desktop reset).
#
# Usage:
#   ./scripts/fix-kubelet-tls.sh [--dry-run]
#
# Supports:
#   - Docker Desktop Kubernetes (Linux, accesses VM via privileged nsenter)
#   - k3s
#   - kubeadm / vanilla Kubernetes (systemd-managed kubelet)
#
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
fi

CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY='\033[0;90m'
NC='\033[0m'

run() {
    if [ "$DRY_RUN" = true ]; then
        echo -e "${GRAY}  [dry-run] $*${NC}"
    else
        "$@"
    fi
}

echo -e "${CYAN}=== Kubelet TLS SAN Mismatch Fix ===${NC}"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Step 1 — Diagnose
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[1/4] Diagnosing current state...${NC}"

current_context=$(kubectl config current-context 2>/dev/null || echo "unknown")
echo -e "  Current kubectl context: ${current_context}"

# Detect the node IP the API server reports for the node
node_internal_ip=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' 2>/dev/null || true)
echo -e "  Node InternalIP (from K8s API): ${node_internal_ip:-<not found>}"

# Try to read what SANs are actually in the serving cert
# This connects to the kubelet port (10250) and dumps the TLS cert
node_hostname=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)
echo -e "  Node hostname: ${node_hostname:-<not found>}"

echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Step 2 — Detect cluster type
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[2/4] Detecting cluster distribution...${NC}"

CLUSTER_TYPE="unknown"

# Docker Desktop check: context is named docker-desktop or uses docker-desktop server
if echo "$current_context" | grep -qi "docker-desktop"; then
    CLUSTER_TYPE="docker-desktop"
elif [ -f /etc/rancher/k3s/k3s.yaml ] || systemctl is-active --quiet k3s 2>/dev/null; then
    CLUSTER_TYPE="k3s"
elif [ -f /etc/kubernetes/admin.conf ] || systemctl is-active --quiet kubelet 2>/dev/null; then
    CLUSTER_TYPE="kubeadm"
fi

echo -e "  Detected: ${CLUSTER_TYPE}"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Step 3 — Apply the fix
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[3/4] Applying fix for: ${CLUSTER_TYPE}${NC}"

case "$CLUSTER_TYPE" in

    docker-desktop)
        echo -e "${GRAY}  Docker Desktop Kubernetes stores the kubelet inside a lightweight VM."
        echo -e "  We enter that VM via a privileged container and delete the stale cert.${NC}"
        echo ""

        if [ "$DRY_RUN" = true ]; then
            echo -e "${GRAY}  [dry-run] Would run privileged nsenter container to delete kubelet PKI files and signal kubelet.${NC}"
        else
            echo -e "${GRAY}  Entering Docker Desktop VM to rotate kubelet serving cert...${NC}"
            docker run --rm --privileged \
                --pid=host \
                --net=host \
                --ipc=host \
                -v /:/host \
                alpine \
                nsenter \
                    --target 1 \
                    --mount \
                    --uts \
                    --ipc \
                    --net \
                    --pid \
                    -- \
                sh -euc '
                    CERT=/var/lib/kubelet/pki/kubelet.crt
                    KEY=/var/lib/kubelet/pki/kubelet.key
                    if [ -f "$CERT" ]; then
                        echo "  Deleting stale kubelet serving cert: $CERT"
                        rm -f "$CERT" "$KEY"
                    else
                        echo "  Cert not found at $CERT — already cleaned or different path"
                    fi

                    # Signal kubelet to request a new certificate
                    KUBELET_PID=$(pgrep -x kubelet 2>/dev/null || true)
                    if [ -n "$KUBELET_PID" ]; then
                        echo "  Sending SIGUSR1 to kubelet (PID $KUBELET_PID) to trigger cert reload..."
                        kill -SIGUSR1 "$KUBELET_PID" || true
                    else
                        echo "  kubelet not found via pgrep; trying HUP on the process..."
                    fi
                    echo "  Done inside VM."
                '
            echo -e "${GREEN}  Cert deleted inside Docker Desktop VM.${NC}"
        fi
        ;;

    k3s)
        echo -e "${GRAY}  k3s manages the kubelet internally. Rotating cert via service restart.${NC}"

        if [ "$DRY_RUN" = true ]; then
            echo -e "${GRAY}  [dry-run] Would: rm /var/lib/kubelet/pki/kubelet.crt|.key then restart k3s${NC}"
        else
            # k3s bundles kubelet; the cert lives at the standard location
            local_cert="/var/lib/kubelet/pki/kubelet.crt"
            local_key="/var/lib/kubelet/pki/kubelet.key"

            if [ -f "$local_cert" ]; then
                echo -e "${GRAY}  Removing stale cert files...${NC}"
                run sudo rm -f "$local_cert" "$local_key"
            else
                echo -e "${YELLOW}  Cert not found at ${local_cert}; k3s may use a different path.${NC}"
                echo -e "${YELLOW}  Trying /var/lib/rancher/k3s/agent/kubelet.crt ...${NC}"
                alt="/var/lib/rancher/k3s/agent/kubelet.crt"
                [ -f "$alt" ] && run sudo rm -f "$alt" "${alt%.crt}.key" || true
            fi

            echo -e "${GRAY}  Restarting k3s service so kubelet requests a fresh cert...${NC}"
            run sudo systemctl restart k3s
        fi
        ;;

    kubeadm)
        echo -e "${GRAY}  kubeadm cluster: deleting stale kubelet serving cert and restarting kubelet.${NC}"
        echo -e "${GRAY}  The kubelet will generate a CSR; you must approve it (step 4).${NC}"

        if [ "$DRY_RUN" = true ]; then
            echo -e "${GRAY}  [dry-run] Would: rm kubelet.crt|.key then systemctl restart kubelet${NC}"
        else
            local_cert="/var/lib/kubelet/pki/kubelet.crt"
            local_key="/var/lib/kubelet/pki/kubelet.key"

            if [ -f "$local_cert" ]; then
                echo -e "${GRAY}  Removing stale cert files...${NC}"
                run sudo rm -f "$local_cert" "$local_key"
            else
                echo -e "${YELLOW}  Cert not found at ${local_cert} — may have already been rotated.${NC}"
            fi

            echo -e "${GRAY}  Restarting kubelet...${NC}"
            run sudo systemctl restart kubelet
        fi
        ;;

    *)
        echo -e "${RED}  Could not detect cluster type automatically.${NC}"
        echo ""
        echo -e "${YELLOW}  Manual steps for kubeadm / generic systemd kubelet:${NC}"
        cat <<'MANUAL'

  1.  SSH onto the Kubernetes node (as root or with sudo).

  2.  Stop kubelet:
        sudo systemctl stop kubelet

  3.  Delete the stale serving cert and key:
        sudo rm -f /var/lib/kubelet/pki/kubelet.crt \
                   /var/lib/kubelet/pki/kubelet.key

  4.  Restart kubelet (it will generate a CSR automatically):
        sudo systemctl start kubelet

  5.  On the control plane, approve the new CSR within ~2 minutes:
        kubectl get csr
        kubectl certificate approve <csr-name>

  6.  Verify:
        kubectl logs <any-pod> -n <namespace>
        # Should now work without TLS errors.

MANUAL
        exit 1
        ;;
esac

echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Step 4 — Post-fix: approve pending CSR (kubeadm only) + verify
# ─────────────────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[4/4] Post-fix verification...${NC}"

if [ "$DRY_RUN" = false ]; then
    # Give kubelet a few seconds to generate a new cert or CSR
    sleep 8

    if [ "$CLUSTER_TYPE" = "kubeadm" ]; then
        echo -e "${GRAY}  Checking for pending CSRs to approve...${NC}"
        pending_csrs=$(kubectl get csr 2>/dev/null \
            | awk 'NR>1 && /Pending/ {print $1}' || true)
        if [ -n "$pending_csrs" ]; then
            for csr in $pending_csrs; do
                echo -e "${GRAY}  Approving CSR: ${csr}${NC}"
                run kubectl certificate approve "$csr"
            done
        else
            echo -e "${GRAY}  No pending CSRs found (may already be auto-approved by cert-manager).${NC}"
        fi
        sleep 5
    fi

    # Verify: try to fetch logs from a known-running pod
    echo -e "${GRAY}  Testing kubectl logs against a running pod...${NC}"
    test_pod=""
    for ns in kube-system default ai-data ai-application ai-gateway; do
        test_pod=$(kubectl get pods -n "$ns" \
            --field-selector=status.phase=Running \
            -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)
        if [ -n "$test_pod" ]; then
            test_ns="$ns"
            break
        fi
    done

    if [ -n "$test_pod" ]; then
        if kubectl logs "$test_pod" -n "$test_ns" --tail=1 >/dev/null 2>&1; then
            echo -e "${GREEN}  kubectl logs works — TLS SAN mismatch is resolved!${NC}"
        else
            echo -e "${YELLOW}  kubectl logs still failing for ${test_pod} in ${test_ns}.${NC}"
            echo -e "${YELLOW}  This may need a few more seconds for the new cert to propagate.${NC}"
            echo -e "${YELLOW}  Re-run this script or wait 30s and try: kubectl logs ${test_pod} -n ${test_ns}${NC}"
        fi
    else
        echo -e "${GRAY}  No Running pods found to test against; skipping log test.${NC}"
    fi
fi

echo ""
echo -e "${GREEN}fix-kubelet-tls.sh complete.${NC}"
echo ""

if [ "$CLUSTER_TYPE" = "docker-desktop" ]; then
    echo -e "${YELLOW}Note for Docker Desktop:${NC}"
    echo -e "  If the error persists after this script, the most reliable fix is:"
    echo -e "    Docker Desktop → Settings → Kubernetes → Reset Kubernetes Cluster"
    echo -e "  This regenerates all control-plane certs with the correct IPs."
    echo -e "  Your local images stay in Docker's image store; re-run deploy.sh afterwards."
fi
