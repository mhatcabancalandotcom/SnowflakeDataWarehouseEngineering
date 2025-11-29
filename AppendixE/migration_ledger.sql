CREATE SCHEMA IF NOT EXISTS mig;

CREATE TABLE IF NOT EXISTS mig.run_log (
  run_id STRING, source STRING, table_name STRING,
  started_at TIMESTAMP_NTZ, finished_at TIMESTAMP_NTZ,
  files NUMBER, rows_loaded NUMBER, checksum STRING, status STRING, notes STRING
);

CREATE TABLE IF NOT EXISTS mig.cutovers (
  system STRING, at TIMESTAMP_NTZ, actor STRING, scope STRING, rollback_plan STRING
);
