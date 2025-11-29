-- Example cosine similarity in SQL when embedding stored as array
CREATE OR REPLACE FUNCTION util.cosine_sim(a ARRAY, b ARRAY)
RETURNS FLOAT
LANGUAGE SQL
AS
$$
  -- simple dot / (||a|| * ||b||); assumes equal length
  SELECT (SUM(value * b[index]) / (SQRT(SUM(value*value)) * SQRT(SUM(b[index]*b[index]))))
  FROM TABLE(FLATTEN(input => a)) WITH ORDINALITY
$$;

-- Top-k with filters and watermark
WITH candidates AS (
  SELECT
    tenant_id, chunk_id, text, source_uri,
    util.cosine_sim(embedding, :query_embedding) AS sim
  FROM rag.chunks
  WHERE tenant_id = :tenant
    AND CURRENT_TIMESTAMP() BETWEEN valid_from AND COALESCE(valid_to, '9999-12-31')
    AND created_at >= DATEADD(day, -90, CURRENT_TIMESTAMP())      -- freshness window
)
SELECT * FROM candidates
ORDER BY sim DESC
LIMIT 10;
