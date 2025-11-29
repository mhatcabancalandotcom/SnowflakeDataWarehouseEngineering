ALTER TABLE fact_events CLUSTER BY (event_dt, user_id);
