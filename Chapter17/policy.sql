CREATE OR REPLACE ROW ACCESS POLICY rap_tenant_guard AS (tenant_id STRING)
RETURNS BOOLEAN ->
  EXISTS (
    SELECT 1
    FROM gov.user_tenants m
    WHERE m.user_name = CURRENT_USER()
      AND m.tenant_id = tenant_id
  );
