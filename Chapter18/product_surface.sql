-- Provider account
CREATE OR REPLACE SECURE VIEW DATASET.V_TRIPS_V1 AS
SELECT trip_id, pickup_ts, dropoff_ts, pickup_zone, dropoff_zone, fare_amount
FROM RAW.TRIPS
WHERE trip_ts >= '2023-01-01';

CREATE OR REPLACE VIEW DATASET.V_RELEASE_NOTES AS
SELECT '2025-09-10' AS dt, 'V_TRIPS_V1 adds fare_amount' AS note
UNION ALL
SELECT '2025-07-01', 'Initial public release';
