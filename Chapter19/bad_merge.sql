-- Verify good state at 01:00 without touching prod
SELECT COUNT(*) FROM mart.fact_orders AT (TIMESTAMP => '2025-09-12 01:00:00');

-- Rebuild table from the last good snapshot
CREATE OR REPLACE TABLE mart.fact_orders AS
SELECT * FROM mart.fact_orders AT (TIMESTAMP => '2025-09-12 01:00:00');

-- Optionally, run a diff to confirm
WITH now AS (SELECT * FROM mart.fact_orders),
     was AS (SELECT * FROM mart.fact_orders AT (TIMESTAMP => '2025-09-12 01:00:00'))
SELECT 'missing' AS kind, * FROM was MINUS SELECT * FROM now
UNION ALL
SELECT 'extra', * FROM now MINUS SELECT * FROM was;
