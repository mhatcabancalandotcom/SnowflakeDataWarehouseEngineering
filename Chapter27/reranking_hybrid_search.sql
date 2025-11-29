WITH cand AS (
  SELECT *, VECTOR_COSINE_SIMILARITY(embedding, :q_vec) AS vscore
  FROM rag.chunks
  WHERE tenant_id = :tenant
),
kw AS (
  SELECT chunk_id, SCORE AS kscore
  FROM TABLE(FT_SEARCH(rag.chunks, :q_text))             -- example full-text function
)
SELECT c.doc_id, c.chunk_id, c.text, c.source_uri,
       0.6 * c.vscore + 0.4 * COALESCE(k.kscore, 0) AS score
FROM cand c
LEFT JOIN kw k USING (chunk_id)
ORDER BY score DESC
LIMIT :k;
