CREATE OR REPLACE VIEW live.v_freshness AS
SELECT
  'events'  AS feed,
  MAX(event_ts) AS newest_event_ts,
  MAX(received_ts) AS newest_ingest_seen_ts,
  CURRENT_TIMESTAMP() AS observed_ts
FROM raw.events_json;
