-- Keep the latest record per natural key (dedupe)
WITH ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY updated_at DESC) AS rn
  FROM stage.customer_updates
)
SELECT * FROM ranked WHERE rn = 1;
