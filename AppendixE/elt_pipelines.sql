MERGE INTO core.dim_customer t
USING stage.customer_delta s
ON t.customer_id = s.customer_id
WHEN MATCHED THEN UPDATE SET name=s.name, segment=s.segment, updated_at=CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT (customer_id,name,segment,created_at)
VALUES (s.customer_id,s.name,s.segment,CURRENT_TIMESTAMP());
