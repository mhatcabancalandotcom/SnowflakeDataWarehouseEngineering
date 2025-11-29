-- Consumer-friendly contract facts (you maintain the rows during releases)
CREATE OR REPLACE VIEW MART.V_CONTRACT AS
SELECT 'V_ORDERS_V1'    AS object_name,
       'daily 02:00 UTC' AS update_cadence,
       INTERVAL '2 HOUR'  AS max_expected_lag,
       '2025-12-31'::DATE AS support_until,
       'v1.6.0'           AS version
UNION ALL
SELECT 'V_CUSTOMERS_V1','hourly at :05', INTERVAL '30 MINUTE', '2025-12-31', 'v1.4.2';
