/**
 * Turn an Axios error into a short message for the admin UI.
 */
export function formatApiError(err, fallback = "Request failed") {
  if (!err) return fallback;

  if (!err.response) {
    const msg = err.message || "";
    if (msg.includes("Network Error") || err.code === "ERR_NETWORK") {
      return "Cannot reach the API. Open the app at http://localhost (Kong), not port 5173.";
    }
    return msg || fallback;
  }

  const status = err.response.status;
  const detail = err.response.data?.detail;

  if (status === 401) {
    return "Session expired or invalid. Sign out and sign in again at http://localhost.";
  }
  if (status === 403) {
    if (typeof detail === "string" && detail.includes("kong")) {
      return "Request blocked: traffic must go through Kong (http://localhost).";
    }
    return typeof detail === "string"
      ? detail
      : "Forbidden — admin role required.";
  }
  if (status === 502 && detail?.error === "policy_sync_failed") {
    return `Policy sync failed: ${detail.reason || detail.detail || "OPA unavailable"}`;
  }
  if (typeof detail === "string") return detail;
  if (Array.isArray(detail)) {
    return detail.map((d) => d.msg || JSON.stringify(d)).join("; ");
  }
  if (detail && typeof detail === "object") {
    return detail.message || detail.reason || JSON.stringify(detail);
  }

  return `${fallback} (HTTP ${status})`;
}
