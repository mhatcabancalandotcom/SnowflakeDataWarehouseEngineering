-- Parameterize the gap (start/end)
SET bf_start = '2025-09-12 01:00:00'::timestamp;
SET bf_end   = '2025-09-12 03:00:00'::timestamp;

-- Idempotent merge from stage into fixed table
MERGE INTO prod.mart.fact_orders t
USING (
  SELECT * FROM prod.stage.orders_src
  WHERE ingested_at >= $bf_start AND ingested_at < $bf_end
) s
ON t.order_id = s.order_id
WHEN MATCHED THEN UPDATE SET  -- only mutable columns
  load_ts = s.load_ts,
  amount  = s.amount
WHEN NOT MATCHED THEN INSERT (order_id, load_ts, amount, ...)
VALUES (s.order_id, s.load_ts, s.amount, ...);
