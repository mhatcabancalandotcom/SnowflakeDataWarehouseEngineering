CREATE TABLE ops.model_registry (
  model_name STRING, version STRING, trained_at TIMESTAMP_NTZ,
  data_snapshot STRING, metrics VARIANT, artifact_uri STRING
);
INSERT INTO ops.model_registry VALUES
('churn','v7',CURRENT_TIMESTAMP(),'train.churn_2025_09_01',
 PARSE_JSON('{"auc":0.816,"pr_auc":0.44}'),
 's3://ml-models/churn/v7/');
