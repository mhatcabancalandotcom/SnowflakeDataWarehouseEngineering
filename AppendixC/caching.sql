CREATE OR REPLACE DYNAMIC TABLE mart.orders_5m
TARGET_LAG='5 minutes' WAREHOUSE=wh_marts AS
SELECT d, tenant_id, SUM(amount) amt
FROM core.fact_orders
WHERE d >= DATEADD(day,-2,CURRENT_DATE())
GROUP BY d, tenant_id;
