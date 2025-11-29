-- Values must remain in the accepted set
SELECT DISTINCT order_channel
FROM prod_candidate.mart.fact_orders
WHERE order_channel IS NOT NULL
  AND order_channel NOT IN ('web','store','partner');
