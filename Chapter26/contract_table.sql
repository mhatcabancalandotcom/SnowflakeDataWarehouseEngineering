CREATE OR REPLACE VIEW provider.prod_weather.v_freshness AS
SELECT MAX(as_of_date) AS newest_dt, CURRENT_TIMESTAMP() AS observed_at
FROM provider.prod_weather.v_daily_v1;

CREATE OR REPLACE TABLE provider.prod_weather.contract AS
SELECT 'V_DAILY_V1' AS object_name, 'daily 02:00 UTC' AS cadence,  'v1.3.0' AS version, 14 AS max_lag_days;
