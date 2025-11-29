CREATE OR REPLACE SECURE VIEW prod_sales.dataset.v_orders_v2 AS
SELECT order_id, order_dt, customer_id, amount, channel, currency
FROM prod_sales.core.fact_orders;

-- Router the BI layer uses
CREATE OR REPLACE VIEW prod_sales.dataset.v_orders AS
SELECT * FROM prod_sales.dataset.v_orders_v1;  -- later switch to v2

-- Announce deprecations
INSERT INTO prod_sales.meta.release_notes
VALUES (CURRENT_DATE(),'V_ORDERS_V1','Deprecates in 60 days; use V2', DATEADD(day,60,CURRENT_DATE()));
