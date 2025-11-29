CREATE SCHEMA IF NOT EXISTS rag;

-- Core chunk store
CREATE OR REPLACE TABLE rag.chunks (
  doc_id STRING,
  chunk_id STRING,
  tenant_id STRING,
  created_at TIMESTAMP_NTZ,
  valid_from TIMESTAMP_NTZ,
  valid_to   TIMESTAMP_NTZ,
  source_uri STRING,
  text STRING,
  -- store embedding either in a native VECTOR column (if available) or as ARRAY<FLOAT>
  embedding ARRAY,   -- or VECTOR(FLOAT, 1536)
  PRIMARY KEY (tenant_id, chunk_id)
);

-- Indexable filters live in scalar columns: tenant_id, created_at, doc type, etc.
