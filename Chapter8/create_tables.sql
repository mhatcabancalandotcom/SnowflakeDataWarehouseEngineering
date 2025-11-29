-- Permanent with 7-day Time Travel
CREATE TABLE core.fact_orders (... )
  DATA_RETENTION_TIME_IN_DAYS = 7;

-- Transient staging table (no fail-safe)
CREATE TRANSIENT TABLE stage.orders_work AS
SELECT ...;

-- Temporary scratch in a notebook/session
CREATE TEMP TABLE work.sample AS
SELECT * FROM core.dim_customer SAMPLE (1);
