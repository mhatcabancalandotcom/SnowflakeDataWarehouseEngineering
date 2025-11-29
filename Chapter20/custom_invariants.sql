-- Fail if negative revenue appears
SELECT COUNT(*) AS bad_rows
FROM mart.fact_orders
WHERE revenue < 0;
