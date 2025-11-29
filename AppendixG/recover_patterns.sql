-- Point-in-time query
SELECT * FROM core.fact_orders AT (TIMESTAMP => '2025-10-19 01:00:00');

-- Instant environment for hotfix
CREATE DATABASE prod_fix CLONE prod AT (TIMESTAMP => '2025-10-19 01:00:00');
