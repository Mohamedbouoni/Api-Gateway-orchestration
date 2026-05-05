import { createContext, useEffect, useState, useRef } from "react";
import Keycloak from "keycloak-js";

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
    const [isLogin, setIsLogin] = useState(false);
    const [token, setToken] = useState(null);
    const [roles, setRoles] = useState([]);
    const isRun = useRef(false);
    const clientRef = useRef(null);

    useEffect(() => {
        if (isRun.current) return;
        isRun.current = true;

        // #region agent log
        fetch("http://127.0.0.1:7681/ingest/76504c76-6478-495e-8fa9-ab02eca33ad7", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-Debug-Session-Id": "003fd1"
            },
            body: JSON.stringify({
                sessionId: "003fd1",
                runId: "pre-fix",
                hypothesisId: "H1",
                location: "frontend/src/context/AuthContext.jsx:useEffect",
                message: "Auth init starting with keycloak env",
                data: {
                    keycloakUrl: import.meta.env.VITE_KEYCLOAK_URL || "",
                    keycloakRealm: import.meta.env.VITE_KEYCLOAK_REALM || "",
                    appUrl: import.meta.env.VITE_APP_URL || ""
                },
                timestamp: Date.now()
            })
        }).catch(() => {});
        // #endregion

        const client = new Keycloak({
            url: import.meta.env.VITE_KEYCLOAK_URL,
            realm: import.meta.env.VITE_KEYCLOAK_REALM,
            clientId: import.meta.env.VITE_KEYCLOAK_CLIENT_ID
        });
        clientRef.current = client;

        // redirectUri tells Keycloak where to send the browser after login.
        // Use VITE_APP_URL (the Kong gateway) so the flow goes through Kong,
        // not the raw Vite dev server. Falls back to current origin if not set.
        const redirectUri = import.meta.env.VITE_APP_URL
            ? import.meta.env.VITE_APP_URL + '/'
            : window.location.origin + '/';

        client.init({
            onLoad: "login-required",
            checkLoginIframe: false,
            redirectUri
        }).then((authenticated) => {
            // #region agent log
            fetch("http://127.0.0.1:7681/ingest/76504c76-6478-495e-8fa9-ab02eca33ad7", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-Debug-Session-Id": "003fd1"
                },
                body: JSON.stringify({
                    sessionId: "003fd1",
                    runId: "pre-fix",
                    hypothesisId: "H2",
                    location: "frontend/src/context/AuthContext.jsx:init-then",
                    message: "Keycloak init resolved",
                    data: { authenticated, redirectUri },
                    timestamp: Date.now()
                })
            }).catch(() => {});
            // #endregion
            setIsLogin(authenticated);
            setToken(client.token);
            setRoles(client.realmAccess?.roles || []);
        }).catch(err => {
            // #region agent log
            fetch("http://127.0.0.1:7681/ingest/76504c76-6478-495e-8fa9-ab02eca33ad7", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-Debug-Session-Id": "003fd1"
                },
                body: JSON.stringify({
                    sessionId: "003fd1",
                    runId: "pre-fix",
                    hypothesisId: "H3",
                    location: "frontend/src/context/AuthContext.jsx:init-catch",
                    message: "Keycloak init rejected",
                    data: {
                        errorName: err?.name || "",
                        errorMessage: err?.message || "",
                        redirectUri
                    },
                    timestamp: Date.now()
                })
            }).catch(() => {});
            // #endregion
            console.error("Keycloak init failed:", err);
        });
    }, []);

    const logout = () => {
        if (clientRef.current) {
            clientRef.current.logout();
        }
    };

    return (
        <AuthContext.Provider value={{ isLogin, token, roles, logout }}>
            {children}
        </AuthContext.Provider>
    );
};
