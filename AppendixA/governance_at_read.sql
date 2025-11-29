CREATE OR REPLACE MASKING POLICY mask_email AS (v STRING) RETURNS STRING ->
  IFF(IS_ROLE_IN_SESSION('ROLE_PII_READER'), v, REGEXP_REPLACE(v,'(^.).+(@.+$)','\\1***\\2'));

ALTER TABLE core.dim_customer
  MODIFY COLUMN email SET MASKING POLICY mask_email;

CREATE OR REPLACE ROW ACCESS POLICY rap_tenant AS (tenant_id STRING) RETURNS BOOLEAN ->
  EXISTS (SELECT 1 FROM gov.user_tenants WHERE user_name=CURRENT_USER() AND tenant_id=tenant_id);

ALTER VIEW mart.v_orders ADD ROW ACCESS POLICY rap_tenant ON (tenant_id);
