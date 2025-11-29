SELECT 'fact_orders_today' AS check,
       COUNT(*) > 0 AS ok
FROM prod_candidate.mart.fact_orders
WHERE load_dt = CURRENT_DATE();
