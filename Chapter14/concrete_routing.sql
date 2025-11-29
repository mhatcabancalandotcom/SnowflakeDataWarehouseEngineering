-- Default lanes by role
ALTER ROLE ANALYST    SET DEFAULT_WAREHOUSE = wh_bi;
ALTER ROLE ELT_RUNNER SET DEFAULT_WAREHOUSE = wh_elt;

-- Hard boundaries: only the right roles can use the lane
GRANT USAGE ON WAREHOUSE wh_bi  TO ROLE ANALYST;
REVOKE USAGE ON WAREHOUSE wh_bi FROM ROLE ELT_RUNNER;

-- Require attribution; set in apps and schedulers too
ALTER SESSION SET QUERY_TAG = 'team=finance;purpose=dashboard';
