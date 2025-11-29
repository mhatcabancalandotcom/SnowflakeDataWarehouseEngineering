CREATE OR REPLACE TABLE raw.events_json (
  src         STRING,
  received_ts TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP(),
  event_ts    TIMESTAMP_TZ,         -- from payload (producer clock)
  event_date  DATE,                  -- derived for pruning
  tenant_id   STRING,                -- envelope for filters
  user_id     STRING,
  device_id   STRING,
  event_type  STRING,
  event_id    STRING,                -- producer UUID for idempotence
  payload     VARIANT
);

-- Example: shaping stage for files (clickstream beacons in JSON)
CREATE OR REPLACE FILE FORMAT ff_json TYPE = JSON STRIP_OUTER_ARRAY=TRUE;

COPY INTO raw.events_json
FROM @landing/clicks/ 
FILE_FORMAT = (FORMAT_NAME=ff_json)
ON_ERROR = 'CONTINUE'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
-- Use SELECT to lift envelope fields (if files carry raw JSON rows)
-- COPY INTO supports column reordering; for complex transforms, stage → SELECT → INSERT.
;
