CREATE TABLE bronze.events_streaming (
  tenant_id STRING,
  event_ts  TIMESTAMP_NTZ,
  payload   VARIANT
);
-- The streaming client/connector writes rows directly into this table.
