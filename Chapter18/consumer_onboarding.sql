-- In consumer account after approval
CREATE DATABASE MOBILITY_TRIPS FROM SHARE PROVIDER_ACCT.trips_marketplace;

-- Optional: local view to pin a stable contract internally
CREATE OR REPLACE VIEW shared.trips_v1 AS
SELECT * FROM MOBILITY_TRIPS.DATASET.V_TRIPS_V1;

-- Tag queries for chargeback
ALTER SESSION SET QUERY_TAG='team=product;purpose=mobility_feature';
