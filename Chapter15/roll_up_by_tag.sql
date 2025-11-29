SELECT
  SPLIT_PART(query_tag,';',1) AS team_kv,
  SUM(credits_used_compute + credits_used_cloud_services) AS credits
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE start_time >= DATEADD(day,-30,CURRENT_TIMESTAMP())
GROUP BY 1
ORDER BY credits DESC;
