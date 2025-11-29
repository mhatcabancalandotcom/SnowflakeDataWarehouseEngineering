CREATE OR REPLACE VIEW ops.pred_freshness AS
SELECT
  'churn' AS model,
  (SELECT MAX(as_of_ts) FROM feat.customer_daily)      AS newest_features,
  (SELECT MAX(scored_at) FROM pred.churn_daily)        AS newest_scores,
  TIMESTAMPDIFF('minute',
    (SELECT MAX(as_of_ts) FROM feat.customer_daily),
    (SELECT MAX(scored_at) FROM pred.churn_daily)
  ) AS minutes_lag;
