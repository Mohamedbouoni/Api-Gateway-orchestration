import api from "../api/client";
import { useEffect, useState, useCallback } from "react";
import useAuth from "./useAuth";

export default function useIntent() {
  const [intents, setIntents] = useState([]);
  const { token } = useAuth();

  const fetchIntents = useCallback(async () => {
    if (!token) return;
    try {
      const res = await api.get("/admin/intent-mappings", {
        headers: { Authorization: `Bearer ${token}` },
      });
      setIntents(res.data);
    } catch (err) {
      console.error("Failed to fetch intents", err);
    }
  }, [token]);

  useEffect(() => {
    fetchIntents();
  }, [fetchIntents]);

  return { intents, refresh: fetchIntents };
}
