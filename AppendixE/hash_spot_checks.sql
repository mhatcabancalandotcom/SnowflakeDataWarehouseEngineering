-- Deterministic hash on canonical column list
SELECT MD5(ARRAY_TO_STRING(ARRAY_AGG(TO_VARCHAR(order_id||'|'||order_dt||'|'||amount) ORDER BY order_id), ',')) AS sig
FROM raw.fact_orders_like_source
WHERE d BETWEEN '2025-10-01' AND '2025-10-07';
