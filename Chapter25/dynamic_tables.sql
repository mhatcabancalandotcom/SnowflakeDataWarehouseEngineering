CREATE OR REPLACE DYNAMIC TABLE live.sessions_5m
TARGET_LAG = '3 minutes'
WAREHOUSE = wh_realtime
AS
SELECT tenant_id,
       DATE_TRUNC('minute', session_start) AS t_min,
       COUNT(*) AS sessions
FROM gold.click_sessions
WHERE session_start >= DATEADD(hour,-2,CURRENT_TIMESTAMP())
GROUP BY 1,2;
