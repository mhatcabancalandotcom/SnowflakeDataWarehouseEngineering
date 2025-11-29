CREATE OR REPLACE VIEW mart.v_orders_v2 AS
SELECT order_id AS id, order_dt, amount, order_channel FROM mart.fact_orders;
