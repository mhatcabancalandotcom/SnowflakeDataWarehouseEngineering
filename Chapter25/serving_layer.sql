-- “Live” fact: last 60 minutes, prunable first, cheap later
CREATE OR REPLACE VIEW live.v_events_60m AS
SELECT tenant_id, event_ts, event_type, metric_1, metric_2
FROM silver.events_flat
WHERE event_ts >= DATEADD(minute, -60, CURRENT_TIMESTAMP())       -- time envelope
  AND tenant_id = CURRENT_ACCOUNT()::string                        -- example tenant filter surface
;
