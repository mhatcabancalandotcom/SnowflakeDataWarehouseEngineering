-- Target encoding with leakage guard: fit on t-1 window, apply to day t
WITH label as (
  SELECT order_id, customer_id, target, DATE_TRUNC('day', event_ts) as day
  FROM training_labels
),
fit AS (
  SELECT brand_id, day,
         AVG(target) AS te
  FROM label
  GROUP BY brand_id, day
),
apply AS (
  SELECT l.order_id, l.day, l.target, p.brand_id
  FROM label l
  JOIN dim_product p USING (order_id)
)
SELECT a.order_id, a.target,
       f_prev.te AS brand_te_prevday
FROM apply a
JOIN fit f_prev
  ON f_prev.brand_id = a.brand_id
 AND f_prev.day      = DATEADD('day', -1, a.day);
