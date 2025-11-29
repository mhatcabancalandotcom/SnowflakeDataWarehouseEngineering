-- Upsert fact table from the normalized batch
CREATE OR REPLACE TASK t_fact_orders
  WAREHOUSE = wh_elt
  AFTER t_normalize
AS
MERGE INTO mart.fact_orders t
USING work.orders_norm s
ON t.order_id = s.order_id
WHEN MATCHED THEN UPDATE SET amount = s.total, order_ts = s.event_ts
WHEN NOT MATCHED THEN INSERT (order_id, customer_id, amount, order_ts)
VALUES (s.order_id, s.customer_id, s.total, s.event_ts);

-- Maintain Type-2 dim with effective dating
CREATE OR REPLACE TASK t_dim_customer_scd2
  WAREHOUSE = wh_elt
  AFTER t_normalize
AS
MERGE INTO dim_customer_scd d
USING (SELECT DISTINCT customer_id, email, status, event_ts FROM work.orders_norm) s
ON d.customer_id = s.customer_id AND d.current_flag = TRUE
WHEN MATCHED AND (d.email <> s.email OR d.status <> s.status) THEN
  UPDATE SET current_flag = FALSE, valid_to = s.event_ts
WHEN NOT MATCHED THEN
  INSERT (customer_id, email, status, valid_from, valid_to, current_flag)
  VALUES (s.customer_id, s.email, s.status, s.event_ts, NULL, TRUE);
