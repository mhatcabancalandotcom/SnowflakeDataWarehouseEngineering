MERGE INTO dim_customer d
USING stage.customer_deltas s
  ON d.customer_id = s.customer_id
WHEN MATCHED THEN
  UPDATE SET
    email      = COALESCE(s.email, d.email),
    status     = s.status,
    updated_at = s.event_ts
WHEN NOT MATCHED THEN
  INSERT (customer_id, email, status, created_at, updated_at)
  VALUES (s.customer_id, s.email, s.status, s.event_ts, s.event_ts);
