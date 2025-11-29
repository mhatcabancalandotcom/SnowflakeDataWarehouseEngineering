CREATE OR REPLACE TABLE core.dim_product LIKE core.dim_product_template;
ALTER TABLE core.fact_orders ADD COLUMN IF NOT EXISTS order_channel STRING;
