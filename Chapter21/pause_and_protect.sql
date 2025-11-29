-- Quiet write-heavy tasks
ALTER TASK elt_refresh_fact_orders SUSPEND;

-- BI elasticity (temporary)
ALTER WAREHOUSE wh_bi SET MAX_CLUSTER_COUNT = 6;
