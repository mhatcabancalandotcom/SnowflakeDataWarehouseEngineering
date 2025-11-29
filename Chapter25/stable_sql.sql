-- Parameterized via BI tool: :p_tenant_id, :p_win_min
SELECT event_type, COUNT(*) AS n
FROM live.v_events_60m
WHERE tenant_id = :p_tenant_id
  AND event_ts >= DATEADD(minute, -:p_win_min, CURRENT_TIMESTAMP())
GROUP BY event_type;
