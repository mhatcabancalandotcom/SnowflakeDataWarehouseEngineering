-- Bronze: lossless ingest
CREATE OR REPLACE TABLE bronze.events (
  tenant_id STRING,
  ingest_dt DATE,
  payload   VARIANT
);

COPY INTO bronze.events
FROM @ext_events
FILE_FORMAT = (TYPE=JSON, STRIP_OUTER_ARRAY=TRUE)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- Silver: curated, typed interface
CREATE OR REPLACE VIEW silver.orders AS
SELECT
  tenant_id,
  TRY_TO_VARCHAR(payload:order_id)             AS order_id,
  TRY_TO_NUMBER(payload:total)                 AS total,
  TRY_TO_TIMESTAMP_NTZ(payload:created_at)     AS created_at
FROM bronze.events
WHERE payload:type::STRING = 'order_created';
