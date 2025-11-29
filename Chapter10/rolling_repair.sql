CREATE OR REPLACE TASK t_fact_orders_repair
  WAREHOUSE = wh_elt
  SCHEDULE  = '1 HOUR'
AS
MERGE INTO mart.fact_orders f
USING (
  SELECT * FROM stage.orders_norm
  WHERE event_ts >= DATEADD('day', -2, CURRENT_TIMESTAMP())
) s
ON f.order_id = s.order_id
WHEN MATCHED THEN UPDATE SET amount = s.total, order_ts = s.event_ts
WHEN NOT MATCHED THEN INSERT (order_id, customer_id, amount, order_ts)
VALUES (s.order_id, s.customer_id, s.total, s.event_ts);
