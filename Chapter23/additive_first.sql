-- Add columns safely (no-op if exists)
ALTER TABLE mart.fact_orders
  ADD COLUMN IF NOT EXISTS order_channel STRING,
  ADD COLUMN IF NOT EXISTS source_system STRING DEFAULT 'core';

-- Record the change for docs/release notes
COMMENT ON COLUMN mart.fact_orders.order_channel IS 'web|store|partner';
