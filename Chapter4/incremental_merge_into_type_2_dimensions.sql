-- SCD Type 2 (simplified)
MERGE INTO dim_customer_scd d
USING inc_customer s
  ON d.customer_id = s.customer_id
 AND d.current_flag = TRUE
WHEN MATCHED AND (d.email <> s.email OR d.status <> s.status) THEN
  UPDATE SET current_flag = FALSE, valid_to = CURRENT_DATE()
WHEN NOT MATCHED THEN
  INSERT (customer_id, email, status, valid_from, valid_to, current_flag)
  VALUES (s.customer_id, s.email, s.status, CURRENT_DATE(), NULL, TRUE);
