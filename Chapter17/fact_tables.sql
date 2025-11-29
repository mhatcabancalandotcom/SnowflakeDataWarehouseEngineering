ALTER TABLE mart.fact_events
  ADD ROW ACCESS POLICY rap_tenant_guard ON (tenant_id);

ALTER TABLE mart.fact_orders
  ADD ROW ACCESS POLICY rap_tenant_guard ON (tenant_id);
