-- Where alerts live
CREATE SCHEMA IF NOT EXISTS ops;
CREATE OR REPLACE TABLE ops.alerts (
  id STRING,                    -- stable hash of the finding
  first_seen TIMESTAMP_NTZ,
  last_seen  TIMESTAMP_NTZ,
  severity   STRING,            -- info|warn|crit
  kind       STRING,            -- 'queued_spike' | 'task_fail' | ...
  subject    STRING,            -- warehouse, task, etc.
  details    STRING,
  is_open    BOOLEAN
);

-- Optional: email notifications (use your account name/region specifics)
CREATE OR REPLACE NOTIFICATION INTEGRATION ops_email
  TYPE = EMAIL
  ENABLED = TRUE
  ALLOWED_RECIPIENTS = ('dataops@example.com');

-- Helper view for operators
CREATE OR REPLACE VIEW ops.v_alerts_open AS
SELECT * FROM ops.alerts WHERE is_open ORDER BY last_seen DESC;
