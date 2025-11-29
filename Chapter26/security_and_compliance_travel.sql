CREATE OR REPLACE MASKING POLICY mask_email AS (val STRING) RETURNS STRING ->
  IFF(IS_ROLE_IN_SESSION('ROLE_PROVIDER_PII'), val, REGEXP_REPLACE(val,'(^.).+(@.+$)','\\1***\\2'));

ALTER TABLE provider.core.customers
  MODIFY COLUMN email SET MASKING POLICY mask_email;

CREATE OR REPLACE ROW ACCESS POLICY rap_region AS (region STRING) RETURNS BOOLEAN ->
  region IN ('EU','US');   -- example: only export allowed regions
ALTER VIEW provider.prod_weather.v_daily_v1 ADD ROW ACCESS POLICY rap_region ON (region);
