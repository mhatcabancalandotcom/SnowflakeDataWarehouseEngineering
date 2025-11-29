CREATE OR REPLACE TABLE ml.model_registry (
  model_name STRING, version STRING, created_at TIMESTAMP_NTZ,
  training_query STRING, feature_list ARRAY, artifact_stage STRING, metrics VARIANT
);
