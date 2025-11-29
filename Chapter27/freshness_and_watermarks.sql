-- Pin to a published release for durable workflows
SELECT * FROM rag.chunks
WHERE tenant_id = :tenant AND release_tag = :release
ORDER BY VECTOR_COSINE_SIMILARITY(embedding, :q) DESC
LIMIT :k;
