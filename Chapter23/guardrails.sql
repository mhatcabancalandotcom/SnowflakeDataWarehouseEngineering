CREATE TABLE IF NOT EXISTS ops.event_log
  (ts TIMESTAMP_NTZ, incident_id STRING, scope STRING, action STRING, notes STRING);

INSERT INTO ops.event_log
VALUES (CURRENT_TIMESTAMP(), 'INC-2025-0912-01', 'prod.mart', 'swap', 'Rebuilt fact_orders from 01:00 snapshot; backfilled 01:00–03:00');
