WITH sums AS (
  SELECT d, customer_id, SUM(amount) amt
  FROM core.fact_orders
  WHERE d >= :from_dt AND d <= :to_dt
  GROUP BY d, customer_id
)
SELECT * FROM sums WHERE amt > 0;
