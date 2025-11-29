-- What the dim looked like exactly at a past cutoff
SELECT *
FROM dim_customer
  AT (TIMESTAMP => TO_TIMESTAMP_TZ('2025-09-01 00:00:00 +00:00'));
