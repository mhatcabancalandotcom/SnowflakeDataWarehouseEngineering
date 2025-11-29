SELECT
  database_name,
  active_bytes/POWER(1024,3)  AS active_gb,
  time_travel_bytes/POWER(1024,3) AS tt_gb,
  failsafe_bytes/POWER(1024,3)    AS fs_gb,
  (active_bytes+time_travel_bytes+failsafe_bytes)/POWER(1024,3) AS total_gb
FROM SNOWFLAKE.ACCOUNT_USAGE.DATABASE_STORAGE_USAGE_HISTORY
QUALIFY ROW_NUMBER() OVER (PARTITION BY database_name ORDER BY usage_date DESC) = 1
ORDER BY total_gb DESC;
