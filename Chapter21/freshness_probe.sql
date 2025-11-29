SELECT 'fact_orders' AS object_name,
       MAX(load_dt)   AS newest_dt,
       CURRENT_DATE() - MAX(load_dt) AS days_late
FROM prod.mart.fact_orders;
