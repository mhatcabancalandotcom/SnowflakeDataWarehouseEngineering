SELECT
  tenant_id,
  event_dt,
  SUM(amount) AS revenue
FROM stage.events_flat
WHERE event_dt BETWEEN :from_dt AND :to_dt
  AND tenant_id = :tenant_id
GROUP BY 1,2;
