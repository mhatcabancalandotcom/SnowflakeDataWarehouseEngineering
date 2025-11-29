-- Append new events
INSERT INTO fact_orders (order_id, customer_id, amount, order_ts)
SELECT order_id, customer_id, total, event_ts
FROM str_orders
WHERE op IN ('I','U')  -- Debezium upserts map to inserts here
  AND event_ts >= DATEADD('day', -2, CURRENT_TIMESTAMP()); -- guard for reorder

-- Periodic repair of the last N days for true updates/deletes
MERGE INTO fact_orders f
USING (
  SELECT * FROM str_orders
  WHERE event_ts >= DATEADD('day', -2, CURRENT_TIMESTAMP())
) s
ON f.order_id = s.order_id
WHEN MATCHED AND s.op = 'U' THEN
  UPDATE SET amount = s.total, order_ts = s.event_ts
WHEN MATCHED AND s.op = 'D' THEN
  DELETE;
