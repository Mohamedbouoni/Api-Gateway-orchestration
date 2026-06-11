# Study Guides Index

Concept-first deep-dive curriculum for the Enterprise AI Gateway platform.

**Start here:** [00-architecture-overview.md](00-architecture-overview.md)

**Roadmap & schedule:** See `.cursor/plans/project_revision_guide_1fc80023.plan.md` in your Cursor plans folder.

## Modules

| # | Guide | Topic |
|---|-------|-------|
| 00 | [architecture-overview](00-architecture-overview.md) | Platform map, namespaces, deploy options |
| 01 | [edge-waf](01-edge-waf.md) | ModSecurity CRS, exclusions |
| 02 | [kong-gateway](02-kong-gateway.md) | Hybrid CP/DP, routes, plugins |
| 03 | [network-zero-trust](03-network-zero-trust.md) | NetworkPolicies, TLS |
| 04 | [identity-auth](04-identity-auth.md) | Keycloak, JWT, RLS |
| 05 | [ai-orchestration](05-ai-orchestration.md) | Pre-flight pipeline, SSE |
| 06 | [security-services](06-security-services.md) | Injection, PII, quota |
| 07 | [intent-classifier](07-intent-classifier.md) | Rules, NLI, routing |
| 08 | [opa-governance](08-opa-governance.md) | Rego policies, audit |
| 09 | [ai-providers](09-ai-providers.md) | Ollama, OpenAI, Gemini |
| 10 | [data-layer](10-data-layer.md) | Postgres, Redis, Vault |
| 11 | [monitoring-logging](11-monitoring-logging.md) | Prometheus, Grafana, kong-logger |
| 12 | [deployment-ops](12-deployment-ops.md) | deploy.ps1, GitOps |
| 13 | [admin-frontend](13-admin-frontend.md) | React UI, Admin Portal |
| 99 | [end-to-end-trace](99-end-to-end-trace.md) | Capstone exercise |

## Study order

```
00 → 01 → 02 → 03 → 04 → 05 → (06|07|08|09 any order) → 10 → 11 → 12 → 13 → 99
```
