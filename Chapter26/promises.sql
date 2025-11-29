CREATE OR REPLACE VIEW prod_sales.meta.v_freshness AS
SELECT 'V_ORDERS_V1' AS object_name,
       MAX(order_dt) AS newest_dt,
       DATEDIFF(minute, MAX(order_dt), CURRENT_TIMESTAMP()) AS lag_min
FROM prod_sales.dataset.v_orders_v1;

CREATE OR REPLACE VIEW prod_sales.meta.v_usage_7d AS
SELECT DIRECT_OBJECTS_ACCESSED:objectName::string AS object_name,
       ROLE_NAME, COUNT(*) AS reads
FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY
WHERE QUERY_START_TIME >= DATEADD(day,-7,CURRENT_TIMESTAMP())
GROUP BY 1,2;
