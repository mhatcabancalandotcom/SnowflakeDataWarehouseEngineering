CREATE OR REPLACE TABLE ops.release_log (
  release_id STRING, started_at TIMESTAMP_NTZ, finished_at TIMESTAMP_NTZ,
  commit_sha STRING, actor STRING, status STRING, notes STRING
);
