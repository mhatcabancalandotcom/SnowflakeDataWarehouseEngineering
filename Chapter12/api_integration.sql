-- (Admin) API integration bound to your serving gateway
CREATE API INTEGRATION ai_infer
  API_PROVIDER = aws_api_gateway
  API_AWS_ROLE_ARN = 'arn:aws:iam::123456789012:role/snowflake_extfn'
  API_ALLOWED_PREFIXES = ('https://api.myserve.company/')
  ENABLED = TRUE;

-- External Function: send feature vector; get score
CREATE OR REPLACE EXTERNAL FUNCTION ml.score_churn(v VARIANT, model_version STRING)
RETURNS FLOAT
API_INTEGRATION = ai_infer
HEADERS = ( 'x-model-version' = model_version )
URL = 'https://api.myserve.company/churn/score';

-- Use it sparingly and batch where possible
INSERT INTO pred.churn_events (entity_id, event_ts, model_version, score, scored_at)
SELECT
  e.customer_id,
  e.event_ts,
  'churn_v7',
  ml.score_churn(OBJECT_CONSTRUCT(
      'cnt_pos_7d', f.cnt_pos_7d, 'amt_30d', f.amt_30d, 'days_since_last', f.days_since_last
  ), 'churn_v7') AS score,
  CURRENT_TIMESTAMP()
FROM stage.events_norm e
JOIN feat.customer_latest f ON f.customer_id = e.customer_id;
