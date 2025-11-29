-- Given a query vector :qv
SELECT product_id
FROM nlp.product_text_features
ORDER BY VECTOR_COSINE_DISTANCE(embedding, :qv)
LIMIT 50;
