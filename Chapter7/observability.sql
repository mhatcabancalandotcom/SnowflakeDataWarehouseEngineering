-- What changed and what was consumed
SELECT * FROM TABLE(INFORMATION_SCHEMA.STREAMS()) WHERE TABLE_NAME ILIKE 'STR_%';

-- Task health and runtimes
SELECT * FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY(
  SCHEDULED_TIME_RANGE_START => DATEADD('hour', -6, CURRENT_TIMESTAMP())
));

-- End-to-end freshness (simple SLA probe)
SELECT MAX(event_ts) AS newest_event, CURRENT_TIMESTAMP() AS now
FROM stage.orders_norm;
