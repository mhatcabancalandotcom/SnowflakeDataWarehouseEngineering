CREATE OR REPLACE TASK ops.t_monitor_every_5m
  WAREHOUSE = wh_ops
  SCHEDULE  = 'USING CRON 0/5 * * * * UTC'
AS
BEGIN
  -- Upsert queued spikes
  /* MERGE block above */

  -- Upsert task failures (similar MERGE keyed by 'task_fail:<db>.<sch>.<name>')
  /* MERGE for TASK_HISTORY */

  -- Send one summary email for new alerts
  /* SYSTEM$SEND_EMAIL block */
END;
ALTER TASK ops.t_monitor_every_5m RESUME;
