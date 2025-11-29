COMMENT ON TABLE mart.fact_orders IS 'Transactional fact table with one row per order; late-arriving updates patched hourly.';
COMMENT ON COLUMN mart.fact_orders.order_channel IS 'Channel taxonomy: web|store|partner.';
