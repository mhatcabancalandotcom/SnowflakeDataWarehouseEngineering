CREATE OR REPLACE TASK t_score_repair
  WAREHOUSE = wh_ml
  SCHEDULE  = 'HOURLY'
AS
MERGE INTO pred.events_online t
USING (
  SELECT
    e.customer_id AS entity_id,
    e.event_ts,
    'churn_v7'    AS model_version,
    score_probability(f.cnt_pos_7d, f.amt_30d, f.days_since_last) AS score
  FROM stage.events_norm e
  JOIN feat.customer_latest f ON f.customer_id = e.customer_id
  WHERE e.event_ts >= DATEADD('hour', -2, CURRENT_TIMESTAMP())
) s
ON (t.entity_id, t.event_ts, t.model_version) = (s.entity_id, s.event_ts, s.model_version)
WHEN MATCHED THEN UPDATE SET score = s.score, scored_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN
  INSERT (entity_id, event_ts, model_version, score, scored_at)
  VALUES (s.entity_id, s.event_ts, s.model_version, s.score, CURRENT_TIMESTAMP());
