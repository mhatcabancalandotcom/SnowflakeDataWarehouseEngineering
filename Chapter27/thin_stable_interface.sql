-- Session defaults for BI/API lanes
ALTER SESSION SET
  STATEMENT_TIMEOUT_IN_SECONDS = 15,
  QUERY_TAG = 'app=genai;surface=qa';

-- Stable surface (apps call this only)
CREATE OR REPLACE VIEW rag.v_search_latest AS
SELECT doc_id, chunk_id, text, source_uri
FROM rag.chunks
WHERE CURRENT_TIMESTAMP() BETWEEN valid_from AND COALESCE(valid_to,'9999-12-31');
