SELECT TO_TIMESTAMP_TZ(created_ntz, 'UTC') AS created_utc
FROM core.orders;
