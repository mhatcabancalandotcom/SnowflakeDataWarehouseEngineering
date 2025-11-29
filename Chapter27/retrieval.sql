-- Tenant & region isolation
CREATE OR REPLACE ROW ACCESS POLICY rap_tenant_region
AS (tenant_id STRING, region STRING)
RETURNS BOOLEAN ->
  EXISTS (
    SELECT 1 FROM gov.user_entitlements e
    WHERE e.user_name = CURRENT_USER()
      AND e.tenant_id = tenant_id
      AND e.region = region
  );

ALTER TABLE rag.chunks
  ADD ROW ACCESS POLICY rap_tenant_region ON (tenant_id, region);

-- PII redaction carried by tag
CREATE OR REPLACE MASKING POLICY mask_email AS (v STRING) RETURNS STRING ->
  IFF(IS_ROLE_IN_SESSION('ROLE_PII_READER'), v, REGEXP_REPLACE(v,'(^.).+(@.+$)','\\1***\\2'));

-- Any column tagged classification = 'pii.email' will bind to mask_email via your governance job
