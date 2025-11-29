-- Ephemeral environment
CREATE OR REPLACE DATABASE ci_run CLONE prod;

-- Seed minimal fixtures
CREATE OR REPLACE TABLE ci_run.stage.orders_src AS
SELECT * FROM prod.stage.orders_src WHERE load_dt >= CURRENT_DATE()-1 LIMIT 1000;

-- Execute the same steps as prod (dbt run, Streams & Tasks, COPY, etc.)
