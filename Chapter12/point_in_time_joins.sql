-- Fact grain: (customer_id, event_ts)
-- Dim SCD2: valid_from, valid_to, current_flag
SELECT
  f.customer_id,
  f.event_ts AS as_of_ts,
  d.segment,
  d.status
FROM fact_events f
JOIN dim_customer_scd d
  ON d.customer_id = f.customer_id
 AND d.valid_from <= f.event_ts
 AND COALESCE(d.valid_to, '9999-12-31') > f.event_ts;
