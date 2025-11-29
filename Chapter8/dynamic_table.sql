CREATE OR REPLACE DYNAMIC TABLE mart.orders_recent
  TARGET_LAG = '5 MINUTE'
  WAREHOUSE  = wh_elt
AS
SELECT
  o.order_id,
  o.customer_id,
  d.region,
  o.total,
  o.order_ts
FROM bronze.orders o
JOIN dim_customer d USING (customer_id)
WHERE o.order_ts >= DATEADD(day, -30, CURRENT_TIMESTAMP());
