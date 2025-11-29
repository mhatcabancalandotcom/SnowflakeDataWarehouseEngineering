SELECT database_name,
       (active_bytes+time_travel_bytes+failsafe_bytes)/POWER(1024,3) AS total_gb
FROM SNOWFLAKE.ACCOUNT_USAGE.DATABASE_STORAGE_USAGE_HISTORY
QUALIFY ROW_NUMBER() OVER (PARTITION BY database_name ORDER BY USAGE_DATE DESC)=1
ORDER BY total_gb DESC;
