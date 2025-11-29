SELECT
  WAREHOUSE_NAME,
  AVG((QUEUED_OVERLOAD_TIME + QUEUED_PROVISIONING_TIME)/1000) AS avg_queued_s,
  AVG(EXECUTION_TIME/1000)                                    AS avg_exec_s,
  COUNT(*)                                                    AS q_count
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE START_TIME >= DATEADD(hour, -2, CURRENT_TIMESTAMP())
GROUP BY 1
ORDER BY avg_queued_s DESC;
