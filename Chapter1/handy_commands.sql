-- Inspect query performance & pruning
SELECT *
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_SESSION(RESULT_LIMIT => 50));

-- Warehouse utilization
SELECT *
FROM TABLE(INFORMATION_SCHEMA.WAREHOUSE_LOAD_HISTORY(
  WAREHOUSE_NAME => 'WH_BI',
  START_TIME => DATEADD('hour', -24, CURRENT_TIMESTAMP()))
);

-- Time Travel restore (point-in-time)
CREATE TABLE dim_customer_restore CLONE dim_customer
  AT (TIMESTAMP => TO_TIMESTAMP_TZ('2025-09-01 12:00:00 +00:00'));

-- Zero-copy clone for a release branch
CREATE SCHEMA prod_release_2025_09_26 CLONE prod;
