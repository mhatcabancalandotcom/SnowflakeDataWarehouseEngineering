-- Role defaults steer users to the right lane
ALTER ROLE analyst SET DEFAULT_WAREHOUSE = wh_bi;
ALTER ROLE elt_runner SET DEFAULT_WAREHOUSE = wh_elt;

-- Query tagging for attribution
ALTER SESSION SET QUERY_TAG = 'team=finance;purpose=dashboard';

-- Spend guardrails
CREATE OR REPLACE RESOURCE MONITOR rm_bi
  WITH CREDIT_QUOTA = 500
  FREQUENCY = MONTHLY
  TRIGGERS ON 80 PERCENT DO NOTIFY
           ON 95 PERCENT DO SUSPEND
           ON 100 PERCENT DO SUSPEND_IMMEDIATE;
ALTER WAREHOUSE wh_bi SET RESOURCE_MONITOR = rm_bi;
