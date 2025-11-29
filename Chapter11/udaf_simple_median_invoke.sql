SELECT customer_id, median_udaf(amount) AS median_amount
FROM fact_orders
GROUP BY customer_id;
