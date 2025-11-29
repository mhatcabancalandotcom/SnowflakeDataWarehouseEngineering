CREATE TABLE IF NOT EXISTS ops.service_log (
  ts TIMESTAMP_NTZ, severity STRING, incident_id STRING,
  area STRING, summary STRING, actor STRING, status STRING
);
