-- Freshness under the same filters your app uses
SELECT MIN(DATEDIFF('minute', created_at, CURRENT_TIMESTAMP())) AS min_age_min,
       MAX(DATEDIFF('minute', created_at, CURRENT_TIMESTAMP())) AS max_age_min
FROM rag.chunks
WHERE tenant_id=:tenant AND topic=:topic;
