BEGIN;

CREATE TABLE IF NOT EXISTS ops.schema_migrations (id STRING PRIMARY KEY, applied_at TIMESTAMP_NTZ);

INSERT INTO ops.schema_migrations
SELECT '013_add_order_channel', CURRENT_TIMESTAMP()
WHERE NOT EXISTS (SELECT 1 FROM ops.schema_migrations WHERE id='013_add_order_channel');

ALTER TABLE IF EXISTS core.fact_orders
  ADD COLUMN IF NOT EXISTS order_channel STRING;

COMMENT ON COLUMN core.fact_orders.order_channel IS 'web|store|partner';

COMMIT;
