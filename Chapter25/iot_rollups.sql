-- Minute rollup per device
CREATE OR REPLACE VIEW silver.iot_minute AS
SELECT
  tenant_id, device_id,
  DATE_TRUNC('minute', event_ts) AS ts_min,
  AVG(TRY_TO_DOUBLE(v:temp_c))   AS avg_temp_c,
  MAX(TRY_TO_DOUBLE(v:rpm))      AS max_rpm,
  COUNT(*)                       AS msg_count
FROM bronze.events_shaped
WHERE event_type='telemetry'
GROUP BY 1,2,3;

-- Simple anomaly flag (example thresholds)
CREATE OR REPLACE VIEW silver.iot_anoms AS
SELECT *,
  (avg_temp_c > 80 OR max_rpm > 9000) AS is_anom
FROM silver.iot_minute;
