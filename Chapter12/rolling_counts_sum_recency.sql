-- 7d, 30d behaviors at (customer_id, as_of_ts) grain
WITH b AS (
  SELECT customer_id, event_ts, amount
  FROM fact_events
)
SELECT
  customer_id,
  event_ts AS as_of_ts,
  COUNT(*) FILTER (WHERE amount > 0)
    OVER (PARTITION BY customer_id
          ORDER BY event_ts
          RANGE BETWEEN INTERVAL '7 DAY' PRECEDING AND CURRENT ROW)  AS cnt_7d,
  SUM(amount)
    OVER (PARTITION BY customer_id
          ORDER BY event_ts
          RANGE BETWEEN INTERVAL '30 DAY' PRECEDING AND CURRENT ROW) AS amt_30d,
  DATEDIFF('day',
           MAX(event_ts) OVER (PARTITION BY customer_id
                               ORDER BY event_ts
                               RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
           event_ts) AS days_since_last
FROM b;
