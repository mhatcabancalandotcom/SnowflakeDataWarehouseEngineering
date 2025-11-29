CREATE TABLE IF NOT EXISTS rag.answer_cache (
  tenant_id STRING,
  q_norm STRING,
  answer STRING,
  citations VARIANT,
  expires_at TIMESTAMP_NTZ,
  PRIMARY KEY (tenant_id, q_norm)
);

-- On hit
SELECT answer, citations
FROM rag.answer_cache
WHERE tenant_id=:tenant AND q_norm=:q AND expires_at > CURRENT_TIMESTAMP();
