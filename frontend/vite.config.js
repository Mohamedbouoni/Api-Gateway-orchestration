// vite.config.js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

/** Kong data-plane URL for dev-server proxy (Docker Compose + K8s ai-gateway). */
const API_PROXY_TARGET =
  process.env.VITE_API_PROXY_TARGET || "http://kong-dp:80";

/**
 * When the UI is served through Kong (VITE_APP_URL=http://localhost), tell Vite
 * the public origin so HMR WebSockets use port 80 instead of ws://localhost/.
 */
function resolveServerOrigin() {
  const appUrl = process.env.VITE_APP_URL?.trim();
  if (!appUrl) return undefined;
  try {
    return new URL(appUrl).origin;
  } catch {
    return undefined;
  }
}

function resolveHmrConfig() {
  // FORCE DISABLE for debugging: Kong does not proxy Vite's WebSocket path.
  return false;
}

export default defineConfig({
  plugins: [react()],
  optimizeDeps: {
    include: [
      "axios",
      "keycloak-js",
      "react",
      "react-dom",
      "react-dom/client",
      "react-markdown",
      "remark-gfm",
      "styled-components",
    ],
    noDiscovery: true,
    holdUntilCrawlEnd: false,
  },
  server: {
    // When HMR is off, do not set origin — avoids injecting a broken WebSocket client.
    origin: process.env.VITE_HMR_DISABLED === "true" ? undefined : resolveServerOrigin(),
    hmr: resolveHmrConfig(),
    warmup: {
      clientFiles: ["./src/**/*.jsx", "./src/**/*.tsx", "./src/main.jsx"],
    },
    proxy: {
      "/api": {
        target: API_PROXY_TARGET,
        changeOrigin: true,
      },
      "/ai": {
        target: API_PROXY_TARGET,
        changeOrigin: true,
      },
    },
    allowedHosts: true,
    watch: {
      usePolling: true,
    },
  },
});
