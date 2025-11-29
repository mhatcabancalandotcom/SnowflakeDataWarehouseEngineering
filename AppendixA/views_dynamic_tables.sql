CREATE OR REPLACE SECURE VIEW mart.v_orders AS
SELECT ... FROM core.fact_orders WHERE order_dt >= '2023-01-01';

CREATE OR REPLACE DYNAMIC TABLE mart.orders_5m
TARGET_LAG = '5 minutes'
WAREHOUSE = wh_marts
AS
SELECT ... FROM core.fact_orders WHERE order_dt >= DATEADD(day,-2,CURRENT_DATE());
