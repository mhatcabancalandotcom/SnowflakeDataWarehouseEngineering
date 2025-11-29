CREATE OR REPLACE TASK t_score_daily
  WAREHOUSE = wh_ml
  SCHEDULE  = 'DAILY USING CRON 5 1 * * * UTC'
AS
MERGE INTO pred.churn_daily t
USING (
  SELECT
    f.customer_id        AS entity_id,
    f.as_of_ts,
    'churn_v7'           AS model_version,
    score_probability(f.cnt_pos_7d, f.amt_30d, f.days_since_last) AS p_churn
  FROM feat.customer_daily f
  WHERE f.as_of_ts = DATE_TRUNC('day', CURRENT_DATE() - 1)
) s
ON t.entity_id = s.entity_id
AND t.as_of_ts = s.as_of_ts
AND t.model_version = s.model_version
WHEN MATCHED THEN UPDATE SET p_churn = s.p_churn, scored_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN
  INSERT (entity_id, as_of_ts, model_version, p_churn, scored_at)
  VALUES (s.entity_id, s.as_of_ts, s.model_version, s.p_churn, CURRENT_TIMESTAMP());
