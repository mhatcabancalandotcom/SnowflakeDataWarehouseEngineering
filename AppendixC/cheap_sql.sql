-- Good: prunes by date and tenant up front
SELECT d, tenant_id, SUM(amount) AS revenue
FROM core.fact_orders
WHERE d BETWEEN :from_dt AND :to_dt
  AND tenant_id = :tenant
GROUP BY d, tenant_id;
