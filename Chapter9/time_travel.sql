-- Query a table as it existed at a precise time (UTC or TZ-aware)
SELECT *
FROM core.fact_orders
  AT (TIMESTAMP => TO_TIMESTAMP_TZ('2025-09-01 12:00:00 +00:00'))
WHERE order_dt >= '2025-08-01';

-- Restore damage using a point-in-time clone and an atomic swap
CREATE TABLE core.fact_orders_restore
  CLONE core.fact_orders
  AT (OFFSET => -60*10);  -- 10 minutes ago

ALTER TABLE core.fact_orders_restore
  SWAP WITH core.fact_orders;  -- no data copy, instant cutover
