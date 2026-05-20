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

let authToken = null;

/** Called from AuthContext whenever Keycloak issues or refreshes a token. */
export function setApiAuthToken(token) {
  authToken = token || null;
}

apiClient.interceptors.request.use((config) => {
  if (authToken && !config.headers.Authorization) {
    config.headers.Authorization = `Bearer ${authToken}`;
  }
  return config;
});

apiClient.interceptors.response.use(
  (response) => {
    console.log(`[Axios Success] ${response.config.url}`, response);
    return response;
  },
  (error) => {
    console.error(`[Axios Error] ${error.config?.url}`, error.message, error.response?.data);
    return Promise.reject(error);
  }
);

// Re-export for convenience — components use `api.get(...)` instead of `axios.get("/api/v1/...")`
export default apiClient;

// Also export the raw base URL for non-axios calls (e.g., native fetch for SSE)
export const API_BASE = "/api/v1";
