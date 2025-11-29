-- Frequent queries: WHERE event_dt BETWEEN ... AND ... AND user_id = ?
-- Native partitioning by load date is suboptimal for user_id filters
ALTER TABLE fact_events
  CLUSTER BY (event_dt, user_id);
