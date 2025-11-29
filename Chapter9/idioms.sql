WITH ranked AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY updated_at DESC) rn
  FROM stage.customer_updates
)
SELECT *
FROM ranked
QUALIFY rn = 1;  -- keep latest per customer
