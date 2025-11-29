ALTER TABLE fact_events SUSPEND RECLUSTER;  -- pause maintenance
ALTER TABLE fact_events RESUME RECLUSTER;   -- resume later
