CREATE OR REPLACE TABLE ops.test_results (
  run_id STRING, ts TIMESTAMP_NTZ, layer STRING, name STRING, ok BOOLEAN, details STRING
);

CREATE OR REPLACE VIEW ops.v_test_failures AS
SELECT * FROM ops.test_results WHERE ok = FALSE ORDER BY ts DESC;
