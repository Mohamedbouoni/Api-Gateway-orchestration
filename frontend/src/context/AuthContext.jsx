import { createContext, useEffect, useState, useRef } from "react";
import Keycloak from "keycloak-js";
import { setApiAuthToken } from "../api/client";

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

        const client = new Keycloak({
            url: import.meta.env.VITE_KEYCLOAK_URL,
            realm: import.meta.env.VITE_KEYCLOAK_REALM,
            clientId: import.meta.env.VITE_KEYCLOAK_CLIENT_ID
        });
        clientRef.current = client;

        // redirectUri must match a Kong-routed URL (VITE_APP_URL), not a raw port-forward.
        const redirectUri = import.meta.env.VITE_APP_URL
            ? import.meta.env.VITE_APP_URL + '/'
            : window.location.origin + '/';

        client.init({
            onLoad: "login-required",
            checkLoginIframe: false,
            redirectUri
        }).then((authenticated) => {
            setIsLogin(authenticated);
            setToken(client.token);
            setApiAuthToken(client.token);
            setRoles(client.realmAccess?.roles || []);
        }).catch(err => {
            console.error("Keycloak init failed:", err);
        });
    }, []);

    useEffect(() => {
        if (!clientRef.current || !isLogin) return;

        const client = clientRef.current;
        const refresh = () => {
            client
                .updateToken(30)
                .then((refreshed) => {
                    if (refreshed && client.token) {
                        setToken(client.token);
                        setApiAuthToken(client.token);
                    }
                })
                .catch(() => {
                    setApiAuthToken(null);
                    client.logout();
                });
        };

        refresh();
        const id = setInterval(refresh, 30_000);
        return () => clearInterval(id);
    }, [isLogin]);

    const logout = () => {
        setApiAuthToken(null);
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
