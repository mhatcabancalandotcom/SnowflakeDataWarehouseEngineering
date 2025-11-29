CREATE SCHEMA IF NOT EXISTS prod_sales.meta;

CREATE OR REPLACE TABLE prod_sales.meta.contract (
  object_name STRING,          -- 'V_ORDERS_V1'
  version     STRING,          -- 'v1.6.0'
  cadence     STRING,          -- 'hourly at :05'
  max_lag_min NUMBER,          -- 15
  support_until DATE,          -- '2026-06-30'
  owner_email STRING
);

INSERT INTO prod_sales.meta.contract
VALUES ('V_ORDERS_V1','v1.6.0','hourly at :05',15,'2026-06-30','salesops@example.com');

CREATE OR REPLACE TABLE prod_sales.meta.release_notes (
  dt DATE, object_name STRING, note STRING, deprecates_on DATE
);

INSERT INTO prod_sales.meta.release_notes
VALUES (CURRENT_DATE(),'V_ORDERS_V1','Added column channel (non-breaking)', NULL);
