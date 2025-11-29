CREATE OR REPLACE TASK t_dim_customer
  WAREHOUSE = wh_elt
  SCHEDULE = '5 MINUTE'
AS
MERGE INTO dim_customer d
USING (
  SELECT DISTINCT customer_id, email, status, event_ts
  FROM str_customers
) s
ON d.customer_id = s.customer_id
WHEN MATCHED THEN UPDATE SET
  email = COALESCE(s.email, d.email),
  status = s.status,
  updated_at = s.event_ts
WHEN NOT MATCHED THEN INSERT (customer_id, email, status, created_at, updated_at)
VALUES (s.customer_id, s.email, s.status, s.event_ts, s.event_ts);
