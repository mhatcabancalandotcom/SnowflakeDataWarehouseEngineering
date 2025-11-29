-- 013_add_order_channel.sql
BEGIN;

CREATE TABLE IF NOT EXISTS ops.schema_migrations (id STRING PRIMARY KEY, applied_at TIMESTAMP_NTZ);
-- no-op if already applied
INSERT INTO ops.schema_migrations SELECT '013', CURRENT_TIMESTAMP()
  WHERE NOT EXISTS (SELECT 1 FROM ops.schema_migrations WHERE id='013');

-- guarded DDL
ALTER TABLE IF EXISTS mart.fact_orders ADD COLUMN IF NOT EXISTS order_channel STRING;

COMMIT;
