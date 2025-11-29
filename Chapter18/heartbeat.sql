CREATE OR REPLACE VIEW MART.V_FRESHNESS AS
SELECT 'V_ORDERS_V1' AS object_name,
       (SELECT MAX(order_dt) FROM MART.V_ORDERS_V1) AS newest_partition,
       CURRENT_TIMESTAMP() AS observed_at;
