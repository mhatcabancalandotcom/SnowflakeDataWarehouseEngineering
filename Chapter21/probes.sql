-- Avg queued vs. exec per warehouse (10-min window)
WITH q AS (
  SELECT WAREHOUSE_NAME,
         AVG((QUEUED_OVERLOAD_TIME+QUEUED_PROVISIONING_TIME)/1000) AS avg_queued_s,
         AVG(EXECUTION_TIME/1000)                                  AS avg_exec_s,
         COUNT(*) as q_count
  FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
  WHERE START_TIME >= DATEADD(minute, -10, CURRENT_TIMESTAMP())
  GROUP BY 1
)
SELECT *
FROM q
WHERE q_count >= 20               -- ignore tiny samples
  AND avg_queued_s > 5;           -- your SLO threshold
