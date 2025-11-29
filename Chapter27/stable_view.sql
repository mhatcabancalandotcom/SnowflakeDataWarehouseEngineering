CREATE OR REPLACE VIEW ml.v_user_features_serving AS
SELECT f1.*
FROM ml.user_features_offline f1
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY user_id
  ORDER BY as_of_ts DESC
) = 1;  -- “now” serving; for backtests, filter as_of_ts <= :request_ts
