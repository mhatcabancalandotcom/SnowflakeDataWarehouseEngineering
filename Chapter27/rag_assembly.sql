CREATE OR REPLACE TABLE rag.conversations (
  conv_id STRING, ts TIMESTAMP_NTZ, user_name STRING, tenant_id STRING,
  question STRING, answer STRING, chunks VARIANT
);
