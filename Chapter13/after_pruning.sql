-- Land envelope columns at ingest:
-- (tenant_id, event_dt, type, payload VARIANT)

SELECT COUNT(*)
FROM raw.events
WHERE type = 'click'
  AND user_id = 'U123'             -- extracted once into a scalar
  AND event_dt BETWEEN '2025-09-01' AND '2025-09-07';

-- If pruning remains weak for (event_dt, user_id), add:
ALTER TABLE raw.events CLUSTER BY (event_dt, user_id);
