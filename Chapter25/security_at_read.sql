CREATE OR REPLACE ROW ACCESS POLICY rap_tenant AS (tenant_id STRING) RETURNS BOOLEAN ->
  EXISTS (SELECT 1 FROM gov.user_tenants t WHERE t.user_name=CURRENT_USER() AND t.tenant_id=tenant_id);

ALTER VIEW live.v_events_60m ADD ROW ACCESS POLICY rap_tenant ON (tenant_id);
