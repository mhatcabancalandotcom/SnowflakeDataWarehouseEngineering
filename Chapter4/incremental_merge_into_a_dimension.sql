MERGE INTO dim_customer d
USING staging_customer s
  ON d.customer_id = s.customer_id
WHEN MATCHED AND s._op IN ('U','D') THEN
  UPDATE SET
    d.email         = COALESCE(s.email, d.email),
    d.status        = s.status,
    d.updated_at    = CURRENT_TIMESTAMP()
WHEN NOT MATCHED AND s._op IN ('I','U') THEN
  INSERT (customer_id, email, status, created_at, updated_at)
  VALUES (s.customer_id, s.email, s.status, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());
