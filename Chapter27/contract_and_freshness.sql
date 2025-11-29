CREATE OR REPLACE VIEW ml.v_feature_freshness AS
SELECT 'user_features' AS object_name,
       MAX(as_of_ts) AS newest_tick,
       DATEDIFF('minute', MAX(as_of_ts), CURRENT_TIMESTAMP()) AS lag_min
FROM ml.user_features_offline;
