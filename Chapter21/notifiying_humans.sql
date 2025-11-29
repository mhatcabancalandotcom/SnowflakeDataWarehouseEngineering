-- NEW alerts in the last run
WITH new_open AS (
  SELECT * FROM ops.alerts
  WHERE is_open = TRUE AND DATEDIFF(minute, first_seen, last_seen) < 1
)
CALL SYSTEM$SEND_EMAIL(
  'OPS_EMAIL',          -- alias configured inside the integration
  'dataops@example.com',
  'Snowflake alert(s): ' || (SELECT COUNT(*) FROM new_open),
  LISTAGG(subject || ' → ' || kind || ' @ ' || TO_VARCHAR(last_seen), '\n')
);
