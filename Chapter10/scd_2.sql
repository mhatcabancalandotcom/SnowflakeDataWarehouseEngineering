CREATE OR REPLACE TASK t_dim_customer_scd2
  WAREHOUSE = wh_elt
  SCHEDULE  = '10 MINUTE'
AS
MERGE INTO dim_customer_scd d
USING (SELECT DISTINCT customer_id, email, status, event_ts FROM str_customers) s
ON d.customer_id = s.customer_id AND d.current_flag = TRUE
WHEN MATCHED AND (d.email <> s.email OR d.status <> s.status) THEN
  UPDATE SET current_flag = FALSE, valid_to = s.event_ts
WHEN NOT MATCHED THEN
  INSERT (customer_id, email, status, valid_from, valid_to, current_flag)
  VALUES (s.customer_id, s.email, s.status, s.event_ts, NULL, TRUE);
