CREATE OR REPLACE VIEW lake.orders_avro_norm AS
SELECT
  COALESCE(
    TRY_TO_VARCHAR(value:order_id),
    TO_VARCHAR(value:order_id_int)
  ) AS order_id,
  TRY_TO_TIMESTAMP_NTZ(value:created_at) AS created_at,
  TRY_TO_DECIMAL(value:total, 18, 2)     AS total
FROM lake.orders_avro;  -- external table over AVRO objects
