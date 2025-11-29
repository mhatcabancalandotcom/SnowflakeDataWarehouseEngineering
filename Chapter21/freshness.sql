SELECT 'fact_orders' AS object_name,
       MAX(load_dt)  AS newest_dt,
       DATEDIFF(minute, MAX(load_dt), CURRENT_TIMESTAMP()) AS lag_min
FROM prod.mart.fact_orders;
