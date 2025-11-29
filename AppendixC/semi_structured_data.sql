CREATE OR REPLACE VIEW stage.events_flat AS
SELECT
  TO_DATE(v:event_ts)            AS event_dt,
  v:tenant_id::string            AS tenant_id,
  v:type::string                 AS type,
  TRY_TO_NUMBER(v:amount)        AS amount,
  v                               AS payload
FROM raw.events_json;
