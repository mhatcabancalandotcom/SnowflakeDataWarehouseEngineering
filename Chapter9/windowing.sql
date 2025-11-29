-- Rolling 7-day revenue and first/last timestamps per customer
SELECT
  customer_id,
  order_dt,
  SUM(amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_dt
    RANGE BETWEEN INTERVAL '6 DAY' PRECEDING AND CURRENT ROW
  ) AS rev_7d,
  FIRST_VALUE(order_dt) OVER (PARTITION BY customer_id ORDER BY order_dt) AS first_order_dt,
  LAST_VALUE(order_dt)  OVER (PARTITION BY customer_id ORDER BY order_dt
                              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_dt
FROM core.fact_orders;
