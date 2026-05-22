/**
 * Verifies Admin Portal Vault badge via API (same data source as the UI).
 * Run: node scripts/verify-vault-badge-ui.mjs
 */
const KEYCLOAK_PF = "http://127.0.0.1:18080";
const API_BASE = "http://localhost/api/v1";

async function getToken() {
  const body = new URLSearchParams({
    client_id: "myclient",
    grant_type: "password",
    username: "test",
    password: "test",
  });
  const res = await fetch(
    `${KEYCLOAK_PF}/realms/newRealm/protocol/openid-connect/token`,
    { method: "POST", headers: { "Content-Type": "application/x-www-form-urlencoded" }, body },
  );
  if (!res.ok) throw new Error(`Keycloak token failed: ${res.status}`);
  const data = await res.json();
  return data.access_token;
}

async function main() {
  const token = await getToken();
  const res = await fetch(`${API_BASE}/admin/metrics`, {
    headers: { Authorization: `Bearer ${token}`, "kong-header": "true" },
  });
  if (!res.ok) throw new Error(`metrics failed: ${res.status} ${await res.text()}`);
  const metrics = await res.json();
  const vault = metrics?.system?.vault;
  if (!vault) throw new Error("system.vault missing from /admin/metrics");
  console.log("system.vault:", JSON.stringify(vault, null, 2));
  const badgeLabel = `Vault: ${vault.label ?? "..."}`;
  console.log("UI badge would show:", badgeLabel);
  if (vault.status !== "ok" || vault.label !== "OK") {
    process.exit(1);
  }
  console.log("PASS: dynamic Vault badge data is OK");
}

main().catch((err) => {
  console.error("FAIL:", err.message);
  process.exit(1);
});
