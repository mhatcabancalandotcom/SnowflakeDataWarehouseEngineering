-- Query-time parameters (bound by app): :tenant, :topic, :since_days, :k
WITH base AS (
  SELECT doc_id, chunk_id, text, source_uri, embedding
  FROM rag.chunks
  WHERE tenant_id = :tenant
    AND (:topic IS NULL OR topic = :topic)
    AND created_at >= DATEADD(day, -:since_days, CURRENT_TIMESTAMP())
    AND CURRENT_TIMESTAMP() BETWEEN valid_from AND COALESCE(valid_to, '9999-12-31')
),
scored AS (
  SELECT doc_id, chunk_id, text, source_uri,
         VECTOR_COSINE_SIMILARITY(embedding, :query_embedding) AS sim
  FROM base
)
SELECT * FROM scored
ORDER BY sim DESC
LIMIT :k;
