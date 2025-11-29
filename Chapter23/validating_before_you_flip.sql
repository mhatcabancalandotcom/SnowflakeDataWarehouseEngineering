-- Row counts and freshness
SELECT load_dt, COUNT(*) AS rows
FROM prod_fix.mart.fact_orders
GROUP BY load_dt
ORDER BY load_dt DESC
LIMIT 3;

-- Schema contract (example)
SELECT column_name, data_type
FROM prod_fix.information_schema.columns
WHERE table_schema='MART' AND table_name='FACT_ORDERS';

-- Policy attachment spot check
SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.POLICY_REFERENCES
WHERE OBJECT_DATABASE='PROD_FIX' AND OBJECT_NAME='FACT_ORDERS';
