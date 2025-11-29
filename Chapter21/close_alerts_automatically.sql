-- Any open queued_spike that is no longer observed becomes closed
UPDATE ops.alerts
SET is_open = FALSE, last_seen = CURRENT_TIMESTAMP()
WHERE is_open = TRUE
  AND kind = 'queued_spike'
  AND subject NOT IN (SELECT WAREHOUSE_NAME FROM /* current queued probe */);
