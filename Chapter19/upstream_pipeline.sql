-- Example repair window merge
MERGE INTO mart.fact_orders t
USING (
  SELECT * FROM stage.orders_src
  WHERE ingested_at >= DATEADD('hour', -2, CURRENT_TIMESTAMP())
) s
ON t.order_id = s.order_id
WHEN MATCHED THEN UPDATE SET ...
WHEN NOT MATCHED THEN INSERT (...);
