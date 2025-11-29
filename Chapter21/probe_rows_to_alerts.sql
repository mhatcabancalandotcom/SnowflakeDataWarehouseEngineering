-- Example: record queued-spike per warehouse
MERGE INTO ops.alerts t
USING (
  SELECT
    MD5('queued_spike:'||WAREHOUSE_NAME) AS id,
    CURRENT_TIMESTAMP()                  AS now_ts,
    'warn'                               AS severity,
    'queued_spike'                       AS kind,
    WAREHOUSE_NAME                       AS subject,
    TO_JSON(OBJECT_CONSTRUCT('avg_queued_s', avg_queued_s, 'avg_exec_s', avg_exec_s)) AS details
  FROM (
    /* paste the queued-time probe here */
  ) q
) s
ON t.id = s.id AND t.is_open = TRUE
WHEN MATCHED THEN
  UPDATE SET last_seen = s.now_ts, details = s.details
WHEN NOT MATCHED THEN
  INSERT (id, first_seen, last_seen, severity, kind, subject, details, is_open)
  VALUES (s.id, s.now_ts, s.now_ts, s.severity, s.kind, s.subject, s.details, TRUE);
