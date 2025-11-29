-- Upsert with idempotence
MERGE INTO rag.chunks t
USING staged.new_chunks s
ON t.tenant_id = s.tenant_id AND t.chunk_id = s.chunk_id
WHEN MATCHED THEN UPDATE SET
  text = s.text, embedding = s.embedding, created_at = s.created_at, valid_from = s.valid_from, valid_to = s.valid_to, source_uri = s.source_uri
WHEN NOT MATCHED THEN INSERT (doc_id, chunk_id, tenant_id, created_at, valid_from, valid_to, source_uri, text, embedding)
VALUES (s.doc_id, s.chunk_id, s.tenant_id, s.created_at, s.valid_from, s.valid_to, s.source_uri, s.text, s.embedding);
