CREATE OR REPLACE TABLE ops.dr_runs (
  run_id STRING, started TIMESTAMP_NTZ, finished TIMESTAMP_NTZ,
  scenario STRING, rto_seconds NUMBER, rpo_minutes NUMBER, notes STRING
);
