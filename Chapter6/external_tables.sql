CREATE EXTERNAL TABLE lake.orders_parquet
  WITH LOCATION = @lake_sales/orders/
  AUTO_REFRESH = TRUE
  FILE_FORMAT = (TYPE = PARQUET);

-- Snowflake exposes a VARIANT column named VALUE by default
SELECT
  value:order_id::STRING AS order_id,
  value:total::NUMBER    AS total,
  METADATA$FILE_ROW_NUMBER AS row_no
FROM lake.orders_parquet
WHERE value:event_dt::DATE >= CURRENT_DATE() - 7;
