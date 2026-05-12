// frontend/src/api/client.js
/**
 * Centralized Axios instance with versioned API base URL.
 *
 * All frontend components should import this instead of raw `axios`
 * to ensure consistent versioning, headers, and error handling.
 */
import axios from "axios";

const apiClient = axios.create({
  baseURL: "/api/v1",
  headers: {
    "Content-Type": "application/json",
    "kong-header": "true",
  },
});

// Re-export for convenience — components use `api.get(...)` instead of `axios.get("/api/v1/...")`
export default apiClient;

// Also export the raw base URL for non-axios calls (e.g., native fetch for SSE)
export const API_BASE = "/api/v1";
