GRANT USAGE ON SCHEMA prod_sales.dataset TO ROLE ROLE_BI;
GRANT SELECT ON VIEW prod_sales.dataset.v_orders_v1 TO ROLE ROLE_BI;

CREATE OR REPLACE ROW ACCESS POLICY rap_region AS (region STRING)
RETURNS BOOLEAN ->
  EXISTS (SELECT 1 FROM gov.user_regions m WHERE m.user_name=CURRENT_USER() AND m.region=region);

ALTER VIEW prod_sales.dataset.v_orders_v1 ADD ROW ACCESS POLICY rap_region ON (region);
