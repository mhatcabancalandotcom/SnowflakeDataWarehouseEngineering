CREATE OR REPLACE TASK t_feat_customer_daily
  WAREHOUSE = wh_elt
  SCHEDULE  = '15 MINUTE'
AS
MERGE INTO feat.customer_daily t
USING (
  SELECT /* recompute last 2 days only */
    c.customer_id,
    DATE_TRUNC('day', e.event_ts) AS as_of_ts,
    COUNT_IF(e.amount > 0)        AS cnt_pos_7d,
    SUM(e.amount)                 AS amt_30d
  FROM fact_events e
  JOIN dim_customer_scd c
    ON c.customer_id = e.customer_id
   AND c.valid_from <= e.event_ts
   AND COALESCE(c.valid_to,'9999-12-31') > e.event_ts
  WHERE e.event_ts >= DATEADD(day, -2, CURRENT_TIMESTAMP())
  GROUP BY 1,2
) s
ON t.customer_id = s.customer_id AND t.as_of_ts = s.as_of_ts
WHEN MATCHED THEN UPDATE SET cnt_pos_7d = s.cnt_pos_7d, amt_30d = s.amt_30d
WHEN NOT MATCHED THEN INSERT (customer_id, as_of_ts, cnt_pos_7d, amt_30d)
VALUES (s.customer_id, s.as_of_ts, s.cnt_pos_7d, s.amt_30d);
