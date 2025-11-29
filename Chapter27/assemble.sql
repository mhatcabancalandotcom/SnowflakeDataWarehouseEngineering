CREATE OR REPLACE PROCEDURE rag.sp_search_and_cite(q STRING, tenant STRING, k NUMBER)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
  -- 1) Embed outside or pass in; here we assume :embedding session var is set
  WITH topk AS (
    SELECT doc_id, chunk_id, text, source_uri,
           VECTOR_COSINE_SIMILARITY(embedding, :embedding) AS sim
    FROM rag.chunks
    WHERE tenant_id = :tenant
    ORDER BY sim DESC
    LIMIT :k
  ),
  context AS (
    SELECT LISTAGG(CONCAT('[', doc_id, '#', chunk_id, '] ', LEFT(text, 800)), '\n\n')
           WITHIN GROUP (ORDER BY sim DESC) AS ctx,
           ARRAY_AGG(OBJECT_CONSTRUCT('doc', doc_id, 'chunk', chunk_id, 'uri', source_uri, 'sim', sim))
           AS citations
    FROM topk
  )
  SELECT OBJECT_CONSTRUCT('context', ctx, 'citations', citations) FROM context;
$$;
