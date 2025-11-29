CREATE OR REPLACE VIEW provider.prod_weather.v_contract AS
SELECT 'V_DAILY_V1'   AS object_name,
       'daily 02:00 UTC' AS cadence,
       14 AS max_lag_days,
       'redistribution: prohibited; model training: permitted with commercial license' AS terms_summary;
