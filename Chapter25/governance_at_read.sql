-- Mask email if present
CREATE OR REPLACE MASKING POLICY mask_email AS (val STRING) RETURNS STRING ->
  IFF(IS_ROLE_IN_SESSION('ROLE_PII_READER'), val, REGEXP_REPLACE(val, '(^.).+(@.+$)', '\\1***\\2'));

ALTER TABLE raw.events_json
  MODIFY COLUMN payload:email::string SET MASKING POLICY mask_email;

-- Row-level isolation by tenant
CREATE OR REPLACE ROW ACCESS POLICY rap_tenant AS (tenant_id STRING) RETURNS BOOLEAN ->
  EXISTS (SELECT 1 FROM gov.user_tenants m WHERE m.user_name = CURRENT_USER() AND m.tenant_id = tenant_id);

ALTER VIEW bronze.events_shaped ADD ROW ACCESS POLICY rap_tenant ON (tenant_id);
