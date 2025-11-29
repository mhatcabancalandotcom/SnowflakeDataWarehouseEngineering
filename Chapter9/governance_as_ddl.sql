-- Masking policy for PII
CREATE OR REPLACE MASKING POLICY mask_email AS (val STRING) 
RETURNS STRING ->
  CASE WHEN CURRENT_ROLE() IN ('PII_READER','SYSADMIN') THEN val
       ELSE REGEXP_REPLACE(val, '(^.).+(@.+$)', '\\1***\\2') END;

ALTER TABLE dim_customer MODIFY COLUMN email SET MASKING POLICY mask_email;

-- Row access policy for tenancy
CREATE OR REPLACE ROW ACCESS POLICY tenant_guard AS (tenant_id STRING) 
RETURNS BOOLEAN ->
  tenant_id = CURRENT_USER();  -- or look up from a mapping table

ALTER TABLE fact_events ADD ROW ACCESS POLICY tenant_guard ON (tenant_id);
