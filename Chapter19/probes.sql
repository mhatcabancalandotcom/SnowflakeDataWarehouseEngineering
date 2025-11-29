CREATE OR REPLACE VIEW ops.v_freshness AS
SELECT 'fact_orders' AS object_name,
       (SELECT MAX(order_dt) FROM mart.fact_orders) AS newest_partition;

CREATE OR REPLACE VIEW ops.v_health AS
SELECT 'row_count_check' AS check_name,
       (SELECT COUNT(*) FROM mart.dim_date) > 0 AS ok
UNION ALL
SELECT 'fact_orders_today', (SELECT COUNT(*) FROM mart.fact_orders WHERE order_dt=CURRENT_DATE()) > 0;
