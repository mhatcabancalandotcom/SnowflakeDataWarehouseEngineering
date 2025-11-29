-- Emit run metrics at the end of a task
INSERT INTO ops.run_metrics(feed, max_event_ts, loaded_rows, ran_at)
SELECT 'orders', MAX(event_ts), COUNT(*), CURRENT_TIMESTAMP()
FROM work.orders_norm;

-- Task runs
SELECT name, state, scheduled_time, query_id, return_value
FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY(
  SCHEDULED_TIME_RANGE_START => DATEADD('hour', -6, CURRENT_TIMESTAMP())
))
ORDER BY scheduled_time DESC;

-- Freshness SLO
CREATE OR REPLACE VIEW ops.freshness AS
SELECT
  'orders' AS feed,
  MAX(event_ts) AS newest_event,
  TIMESTAMPDIFF('minute', MAX(event_ts), CURRENT_TIMESTAMP()) AS minutes_lag
FROM stage.orders_norm;
