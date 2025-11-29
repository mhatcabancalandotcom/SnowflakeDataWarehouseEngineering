WITH orders AS (
  SELECT
    o.order_id,
    o.customer_id,
    o.order_dt,
    o.amount
  FROM core.fact_orders AS o
  WHERE o.order_dt BETWEEN :from_dt AND :to_dt
),
enriched AS (
  SELECT
    o.*,
    c.segment,
    c.territory
  FROM orders AS o
  JOIN core.dim_customer AS c
    ON c.customer_id = o.customer_id AND c.is_current
)
SELECT
  order_dt,
  segment,
  SUM(amount) AS revenue
FROM enriched
GROUP BY order_dt, segment
ORDER BY order_dt, segment;
