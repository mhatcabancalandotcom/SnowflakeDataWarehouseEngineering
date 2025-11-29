SELECT
  TO_DATE(start_time) AS day,
  direction,  -- EGRESS/INGRESS
  sum(egress_from_snowflake_bytes)/POWER(1024,3) AS egress_gb,
  sum(internal_bytes_transferred)/POWER(1024,3)  AS internal_gb
FROM SNOWFLAKE.ACCOUNT_USAGE.DATA_TRANSFER_HISTORY
WHERE start_time >= DATEADD(day, -30, CURRENT_TIMESTAMP())
GROUP BY 1,2
ORDER BY 1,2;
