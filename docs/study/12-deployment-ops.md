# Module 12 — Deployment & Operations

## Purpose

The primary deployment path is **`deploy.ps1` + Kustomize (`k8s/`)**. This module explains every step, what it creates, and how to access the running platform locally.

---

## Core concepts

1. **Local images** — `deploy.ps1` builds `:latest` tags with `imagePullPolicy: Never` for dev clusters.
2. **Vault-first secrets** — seed Vault, sync to K8s Secrets, then deploy workloads.
3. **Kustomize apply** — single `kubectl apply -k k8s/` deploys all namespaces.
4. **Deck sync job** — pushes `kong_final.yaml` to Kong CP after pods are ready.
5. **Ollama host dependency** — local LLM models warmed on the host before deploy.

---

## deploy.ps1 steps

| Step | Action | Creates |
|------|--------|---------|
| **Pre** | Ollama warmup | Loads `llama3.2:3b`, `qwen2.5-coder:7b` into host memory |
| **[0/8]** | Preflight + image build | `api-gateways-backend`, `-intent-classifier`, `-frontend`, `-kong-logger`, `-waf` |
| **[1/8]** | Namespaces | `ai-data`, `ai-application`, `ai-gateway`, `ai-monitoring` |
| **[1.5]** | Vault deploy | Vault dev server in `ai-data` |
| **[1.6]** | Vault seed | KV secrets: postgres×3, redis, keycloak, HF token, Kong mTLS, Grafana |
| **[1.7]** | Vault → K8s sync | Secrets in all four namespaces |
| **[2/8]** | DB ConfigMaps | `platform-db-init-scripts`, `platform-db-usage-scripts` |
| **[3/8]** | Kong + Grafana ConfigMaps | Plugins, deck config, dashboards, datasources |
| **[4/8]** | App ConfigMaps | Keycloak realm, Prometheus config |
| **[5/8]** | mTLS cert check | Verifies `kong-cluster-certs`; OpenSSL fallback if missing |
| **[6/8]** | `kubectl apply -k k8s/` | All Deployments, Services, NetworkPolicies, Jobs |
| **Wait** | Readiness | platform-db, kong-db, fastapi, classifier, OPA, Keycloak, WAF, kong-cp |
| **[7/8]** | kong-deck-sync Job | Syncs routes/plugins to Kong CP |
| **[8/8]** | keycloak-master-config Job | Master realm edge URLs + OAuth smoke test |

---

## Kustomize layout (`k8s/kustomization.yaml`)

| Directory | Resources |
|-----------|-----------|
| `k8s/data/` | Postgres×3, Redis, Vault |
| `k8s/application/` | FastAPI, classifier, OPA, Keycloak, kong-logger, cronjobs |
| `k8s/gateway/` | WAF, Kong CP/DP, deck sync |
| Root | Frontend, monitoring, network policies |

---

## Post-deploy access (`start-ui.ps1`)

| Service | Local URL | Method |
|---------|-----------|--------|
| Public edge (WAF) | `http://localhost` | LoadBalancer :80 |
| WAF (alt) | `http://localhost:8081` | Port-forward |
| Grafana | `http://localhost:3001` | Port-forward |
| Kong Admin | `http://localhost:8001`, `:8002` | Port-forward |

---

## Alternative deployment paths

| Path | Command | Scope |
|------|---------|-------|
| **Primary K8s** | `.\deploy.ps1` | Full 4-namespace stack |
| **Docker Compose** | `docker compose up` | Local dev; includes Loki |
| **Partial Helm** | `helm install` from `helm/ai-gateway/` | FastAPI + classifier only |
| **GitOps** | ArgoCD overlays in `k8s/gitops/` | dev auto-sync, prod manual |

---

## Verification scripts

| Script | Purpose |
|--------|---------|
| `scripts/test-waf-k8s.ps1` | 13-test WAF verification suite |
| `scripts/vault-seed.ps1` | Seed Vault KV |
| `scripts/vault-sync-k8s-secrets.ps1` | Vault → K8s Secrets |

---

## Key files

| Topic | Files |
|-------|-------|
| Main deploy | `deploy.ps1` |
| UI port-forwards | `start-ui.ps1` |
| K8s entry | `k8s/kustomization.yaml` |
| K8s guide | `k8s/README.md` |
| GitOps | `k8s/gitops/README.md` |
| Partial Helm | `helm/ai-gateway/values.yaml` |

---

## Wired vs scaffolded

| Feature | Status |
|---------|--------|
| Full K8s deploy via deploy.ps1 | Active |
| Vault dev mode | Active |
| GitOps overlays | Available; optional |
| Helm full stack | Not available |
| Production registry push | Manual; dev uses local images |

---

## Trace exercise

1. Run through `deploy.ps1` output (or read the script) and name what step [3/8] creates.
2. After deploy: `kubectl get pods -A | grep ai-` — confirm all namespaces have running pods.
3. Run `scripts/test-waf-k8s.ps1` — verify edge security chain.
4. Compare `k8s/kustomization.yaml` resource list with actual `kubectl get all -A`.

---

## Self-check

1. What images does step [0/8] build?
2. What happens in step [7/8] and why must it run after Kong CP is ready?
3. How do secrets get from Vault to running pods?
4. What is the public URL after K8s deploy?
5. What does Helm cover vs deploy.ps1?

---

## Next module

[13-admin-frontend.md](13-admin-frontend.md) — the user-facing React application.
