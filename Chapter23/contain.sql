-- Pause noisy background tasks, not user BI
ALTER TASK IF EXISTS etl.hourly_refresh SUSPEND;

-- Cap elastic spread for BI temporarly (keep 1–2 clusters)
ALTER WAREHOUSE wh_bi SET MAX_CLUSTER_COUNT = 2;

-- Put a temporary statements timeout on a noisy warehouse
ALTER WAREHOUSE wh_ad_hoc SET STATEMENT_TIMEOUT_IN_SECONDS = 600;

-- Cancel the single worst offender (capture QUERY_ID from detection)
CALL SYSTEM$CANCEL_QUERY('01a1b-...-000');
