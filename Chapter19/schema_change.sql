-- Rebuild from a known-good timestamp
CREATE OR REPLACE TABLE mart.fact_orders AS
SELECT * FROM mart.fact_orders AT (TIMESTAMP => '2025-09-12 01:00:00');

-- Or branch & promote
CREATE DATABASE prod_fix CLONE prod;
-- (run corrections in prod_fix…)
ALTER DATABASE prod_fix SWAP WITH prod;
