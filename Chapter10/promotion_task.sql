CREATE OR REPLACE TASK t_orders_upsert
  WAREHOUSE = wh_elt
  SCHEDULE  = '5 MINUTE'
AS
MERGE INTO mart.orders t
USING (
  SELECT order_id, customer_id, total, event_ts
  FROM str_orders
) s
ON t.order_id = s.order_id
WHEN MATCHED THEN UPDATE SET total = s.total, updated_at = s.event_ts
WHEN NOT MATCHED THEN INSERT (order_id, customer_id, total, created_at, updated_at)
VALUES (s.order_id, s.customer_id, s.total, s.event_ts, s.event_ts);
