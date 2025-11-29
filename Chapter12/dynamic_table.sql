CREATE OR REPLACE DYNAMIC TABLE feat.customer_daily
TARGET_LAG = '10 MINUTE'
WAREHOUSE  = wh_elt
AS
SELECT
  c.customer_id,
  DATE_TRUNC('day', e.event_ts) AS as_of_ts,
  COUNT_IF(e.amount > 0)        AS cnt_pos_7d,
  SUM(e.amount)                 AS amt_30d
FROM fact_events e
JOIN dim_customer_scd c
  ON c.customer_id = e.customer_id
 AND c.valid_from <= e.event_ts
 AND COALESCE(c.valid_to, '9999-12-31') > e.event_ts
QUALIFY
  as_of_ts >= DATEADD(day, -30, CURRENT_DATE())
GROUP BY 1,2;
