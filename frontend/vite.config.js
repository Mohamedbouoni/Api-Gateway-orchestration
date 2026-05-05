// vite.config.js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [
    react(),
    {
      name: "agent-debug-host-check",
      configureServer(server) {
        // #region agent log
        fetch("http://127.0.0.1:7681/ingest/76504c76-6478-495e-8fa9-ab02eca33ad7", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-Debug-Session-Id": "003fd1",
          },
          body: JSON.stringify({
            sessionId: "003fd1",
            runId: "pre-fix",
            hypothesisId: "H2",
            location: "frontend/vite.config.js:configureServer",
            message: "Vite dev server middleware registered",
            data: { hasMiddlewares: Boolean(server?.middlewares) },
            timestamp: Date.now(),
          }),
        }).catch(() => {});
        // #endregion

        server.middlewares.use((req, _res, next) => {
          const hostHeader = req.headers.host || "";
          const url = req.url || "";
          if (hostHeader.includes("frontend.ai-gateway.svc.cluster.local")) {
            // #region agent log
            fetch("http://127.0.0.1:7681/ingest/76504c76-6478-495e-8fa9-ab02eca33ad7", {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
                "X-Debug-Session-Id": "003fd1",
              },
              body: JSON.stringify({
                sessionId: "003fd1",
                runId: "pre-fix",
                hypothesisId: "H3",
                location: "frontend/vite.config.js:middleware",
                message: "Incoming request with cluster host header",
                data: { hostHeader, url },
                timestamp: Date.now(),
              }),
            }).catch(() => {});
            // #endregion
          }
          next();
        });
      },
    },
  ],
  server: {
    proxy: {
      "/api": {
        target: "http://kong-dp:80",
        changeOrigin: true,
        rewrite: (path) => path,
      },
      "/ai": {
        target: "http://kong-dp:80",
        changeOrigin: true,
        rewrite: (path) => path,
      },
    },
    allowedHosts: [
      "localhost",
      "127.0.0.1",
      "::1",
      "frontend",
      "197.14.4.163",
      "frontend.ai-gateway.svc.cluster.local",
    ],
    watch: {
      usePolling: true,
    },
  },
});

// #region agent log
fetch("http://127.0.0.1:7681/ingest/76504c76-6478-495e-8fa9-ab02eca33ad7", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "X-Debug-Session-Id": "003fd1",
  },
  body: JSON.stringify({
    sessionId: "003fd1",
    runId: "pre-fix",
    hypothesisId: "H1",
    location: "frontend/vite.config.js:module",
    message: "Vite config evaluated with allowed hosts",
    data: {
      allowedHosts: [
        "localhost",
        "127.0.0.1",
        "::1",
        "frontend",
        "197.14.4.163",
        "frontend.ai-gateway.svc.cluster.local",
      ],
      nodeEnv: process.env.NODE_ENV || "",
    },
    timestamp: Date.now(),
  }),
}).catch(() => {});
// #endregion
