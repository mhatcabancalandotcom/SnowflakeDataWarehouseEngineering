-- One-time infra: external volume + (optionally) an external catalog
-- Below: create an Iceberg table using Snowflake’s catalog; data stays in your bucket

CREATE ICEBERG TABLE lake_core.fact_orders
  EXTERNAL_VOLUME = my_ext_volume
  CATALOG = 'SNOWFLAKE'
AS
SELECT
  order_id,
  customer_id,
  total::NUMBER(18,2) AS total,
  order_dt::DATE      AS order_dt
FROM staging.orders_parquet;

-- ACID mutations, visible to other Iceberg engines
MERGE INTO lake_core.fact_orders t
USING staging.orders_delta s
ON t.order_id = s.order_id
WHEN MATCHED THEN UPDATE SET total = s.total
WHEN NOT MATCHED THEN INSERT (order_id, customer_id, total, order_dt)
VALUES (s.order_id, s.customer_id, s.total, s.order_dt);
