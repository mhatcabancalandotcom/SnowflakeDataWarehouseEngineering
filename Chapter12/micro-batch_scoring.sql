-- 1) Expose deltas
CREATE OR REPLACE STREAM str_events ON VIEW stage.events_norm;

-- 2) Near-real-time scoring task
CREATE OR REPLACE TASK t_score_stream
  WAREHOUSE = wh_ml
  SCHEDULE  = '5 MINUTE'
AS
INSERT INTO pred.events_online (entity_id, event_ts, model_version, score, scored_at)
SELECT
  e.customer_id,
  e.event_ts,
  'churn_v7',
  score_probability(f.cnt_pos_7d, f.amt_30d, f.days_since_last) AS score,
  CURRENT_TIMESTAMP()
FROM str_events e
JOIN feat.customer_latest f
  ON f.customer_id = e.customer_id
 -- Optionally guard for “ready” features:
 -- AND f.as_of_ts >= e.event_ts - INTERVAL '2 MINUTE';
