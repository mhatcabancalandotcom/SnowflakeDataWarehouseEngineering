CREATE OR REPLACE SECURE VIEW mart.v_orders_v2 AS
SELECT order_id, order_dt, order_channel, amount
FROM mart.fact_orders;

-- Keep v1 until <date>; announce in release notes
