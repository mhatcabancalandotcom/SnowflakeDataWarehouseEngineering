-- Explore recent queries and their shapes
SELECT *
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY(
  END_TIME_RANGE_START => DATEADD('hour', -6, CURRENT_TIMESTAMP()),
  RESULT_LIMIT => 200));

-- Inspect change data available to a stream (incremental pipelines)
SELECT METADATA$ACTION, *
FROM my_db.raw.orders_stream;
