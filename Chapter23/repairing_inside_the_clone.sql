-- Rebuild a damaged table from pre-incident snapshot
CREATE OR REPLACE TABLE prod_fix.mart.fact_orders AS
SELECT *
FROM prod.mart.fact_orders AT (TIMESTAMP => '2025-09-12 01:00:00');

-- Remove accidental duplicates (keep newest by load_ts)
CREATE OR REPLACE TABLE prod_fix.mart.fact_orders AS
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY load_ts DESC) AS rn
  FROM prod_fix.mart.fact_orders
) WHERE rn = 1;
