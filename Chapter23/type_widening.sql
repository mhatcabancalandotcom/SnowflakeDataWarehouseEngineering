ALTER TABLE mart.fact_orders ADD COLUMN order_id_str STRING;
UPDATE mart.fact_orders SET order_id_str = TO_VARCHAR(order_id);
-- Eventually drop old, after v2 in place
