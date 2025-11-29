-- Expose deltas from the landing table
CREATE OR REPLACE STREAM str_orders ON TABLE bronze.orders;

-- Promote changes into the mart on a schedule
CREATE OR REPLACE TASK t_merge_orders
  WAREHOUSE = wh_elt
  SCHEDULE  = '5 MINUTE'
AS
MERGE INTO mart.orders_recent t
USING (
  SELECT order_id, customer_id, total, order_ts
  FROM str_orders
  WHERE order_ts >= DATEADD(day, -30, CURRENT_TIMESTAMP())
) s
ON t.order_id = s.order_id
WHEN MATCHED THEN UPDATE SET
  total    = s.total,
  order_ts = s.order_ts
WHEN NOT MATCHED THEN
  INSERT (order_id, customer_id, total, order_ts)
  VALUES (s.order_id, s.customer_id, s.total, s.order_ts);
