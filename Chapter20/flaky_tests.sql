-- Use a fixed checkpoint instead of CURRENT_DATE in CI
SET checkpoint_ts = TO_TIMESTAMP('2025-09-12 03:00:00');

SELECT COUNT(*) FROM mart.fact_orders
WHERE order_ts < $checkpoint_ts;
