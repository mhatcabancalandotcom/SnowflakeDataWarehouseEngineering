-- Build the candidate
CREATE OR REPLACE DATABASE prod_candidate CLONE prod;
-- …apply migrations, load artifacts, run dbt…

-- One-time smoke probe
SELECT 'orders_today' AS check, COUNT(*) > 0 AS ok
FROM prod_candidate.mart.fact_orders
WHERE load_dt = CURRENT_DATE();

-- Flip
ALTER DATABASE prod_candidate SWAP WITH prod;
