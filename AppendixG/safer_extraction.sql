SELECT
  v:tenant::string            AS tenant_id,
  TO_DATE(v:event_ts)         AS event_dt,
  TRY_TO_NUMBER(v:amount)     AS amount
FROM stage.events;
