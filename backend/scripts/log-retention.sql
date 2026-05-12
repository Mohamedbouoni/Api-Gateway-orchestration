-- ─────────────────────────────────────────────────────────────────────────────
-- Log Retention Policy — Automated Cleanup of Historical Records
-- ─────────────────────────────────────────────────────────────────────────────
-- This script creates a stored procedure that deletes records older than a
-- configurable retention period. It is designed to be called by a Kubernetes
-- CronJob or manually via the Admin API.
--
-- Default retention periods (tunable per table):
--   • api_usage_records:              30 days  (high volume)
--   • ai_requests:                    30 days  (high volume)
--   • usage_token_logs:               90 days  (billing-relevant)
--   • security_events:                90 days  (compliance-relevant)
--   • policy_evaluation_audit_logs:   60 days  (medium volume)
--   • permission_audit_logs:         180 days  (low volume, governance)
--   • intent_mapping_audit_logs:     180 days  (low volume, governance)
-- ─────────────────────────────────────────────────────────────────────────────

CREATE OR REPLACE FUNCTION cleanup_old_logs(
    p_usage_days      INTEGER DEFAULT 30,
    p_requests_days   INTEGER DEFAULT 30,
    p_tokens_days     INTEGER DEFAULT 90,
    p_security_days   INTEGER DEFAULT 90,
    p_policy_days     INTEGER DEFAULT 60,
    p_audit_days      INTEGER DEFAULT 180
)
RETURNS TABLE (
    table_name TEXT,
    rows_deleted BIGINT
) AS $$
DECLARE
    v_count BIGINT;
BEGIN
    -- 1. api_usage_records (highest volume — Kong access logs)
    DELETE FROM api_usage_records
    WHERE request_time < NOW() - (p_usage_days || ' days')::INTERVAL;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    table_name := 'api_usage_records';
    rows_deleted := v_count;
    RETURN NEXT;

    -- 2. ai_requests (AI orchestration tracking)
    DELETE FROM ai_requests
    WHERE started_at < NOW() - (p_requests_days || ' days')::INTERVAL;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    table_name := 'ai_requests';
    rows_deleted := v_count;
    RETURN NEXT;

    -- 3. usage_token_logs (token consumption — billing relevant)
    DELETE FROM usage_token_logs
    WHERE created_at < NOW() - (p_tokens_days || ' days')::INTERVAL;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    table_name := 'usage_token_logs';
    rows_deleted := v_count;
    RETURN NEXT;

    -- 4. security_events (prompt injection blocks, PII redactions)
    DELETE FROM security_events
    WHERE created_at < NOW() - (p_security_days || ' days')::INTERVAL;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    table_name := 'security_events';
    rows_deleted := v_count;
    RETURN NEXT;

    -- 5. policy_evaluation_audit_logs
    DELETE FROM policy_evaluation_audit_logs
    WHERE created_at < NOW() - (p_policy_days || ' days')::INTERVAL;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    table_name := 'policy_evaluation_audit_logs';
    rows_deleted := v_count;
    RETURN NEXT;

    -- 6. permission_audit_logs
    DELETE FROM permission_audit_logs
    WHERE performed_at < NOW() - (p_audit_days || ' days')::INTERVAL;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    table_name := 'permission_audit_logs';
    rows_deleted := v_count;
    RETURN NEXT;

    -- 7. intent_mapping_audit_logs
    DELETE FROM intent_mapping_audit_logs
    WHERE created_at < NOW() - (p_audit_days || ' days')::INTERVAL;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    table_name := 'intent_mapping_audit_logs';
    rows_deleted := v_count;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

-- ─────────────────────────────────────────────────────────────────────────────
-- Helper view: check current table sizes to monitor storage growth
-- ─────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW log_table_stats AS
SELECT
    C.relname AS table_name,
    S.n_live_tup AS estimated_rows,
    pg_size_pretty(pg_total_relation_size(C.oid)) AS total_size,
    pg_total_relation_size(C.oid) AS total_bytes
FROM pg_class C
JOIN pg_namespace N ON N.oid = C.relnamespace
LEFT JOIN pg_stat_user_tables S ON S.relname = C.relname
WHERE C.relname IN (
    'api_usage_records',
    'ai_requests',
    'usage_token_logs',
    'security_events',
    'policy_evaluation_audit_logs',
    'permission_audit_logs',
    'intent_mapping_audit_logs'
)
AND N.nspname = 'public'
ORDER BY pg_total_relation_size(C.oid) DESC;

-- ─────────────────────────────────────────────────────────────────────────────
-- Usage:
--   SELECT * FROM cleanup_old_logs();                    -- Use defaults
--   SELECT * FROM cleanup_old_logs(7, 7, 30, 30, 14, 90); -- Aggressive cleanup
--   SELECT * FROM log_table_stats;                       -- Check sizes
-- ─────────────────────────────────────────────────────────────────────────────
