CREATE OR REPLACE VIEW ops.v_credits_by_warehouse AS
SELECT
  TO_DATE(m.START_TIME)                         AS day,
  m.WAREHOUSE_NAME,
  COALESCE(OBJECT_TAGS:'COST_CENTER'::string,'unTagged') AS cost_center,
  SUM(m.CREDITS_USED)                           AS credits
FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY m
GROUP BY 1,2,3;
