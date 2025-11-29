-- Product namespace
CREATE SCHEMA IF NOT EXISTS prod_sales.dataset;

-- Stable interface (secure view)
CREATE OR REPLACE SECURE VIEW prod_sales.dataset.v_orders_v1 AS
SELECT order_id, order_dt, customer_id, amount, channel
FROM prod_sales.core.fact_orders
WHERE order_dt >= '2023-01-01';

-- Ownership and classification
CREATE TAG IF NOT EXISTS owner ALLOWED_VALUES ('sales_ops','fin_ops','platform');
CREATE TAG IF NOT EXISTS data_domain ALLOWED_VALUES ('sales','finance','marketing');
CREATE TAG IF NOT EXISTS classification;

ALTER VIEW prod_sales.dataset.v_orders_v1
  SET TAG owner='sales_ops', data_domain='sales';

-- Mask PII at read
CREATE OR REPLACE MASKING POLICY mask_email AS (val STRING) RETURNS STRING ->
  IFF(IS_ROLE_IN_SESSION('ROLE_PII_READER'), val, REGEXP_REPLACE(val,'(^.).+(@.+$)','\\1***\\2'));

ALTER TABLE prod_sales.core.dim_customer
  MODIFY COLUMN email SET MASKING POLICY mask_email;
