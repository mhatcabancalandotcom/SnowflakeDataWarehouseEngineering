-- Create an isolated release branch of a production database
CREATE DATABASE prod_candidate_2025_10_01 CLONE prod;

-- Run transforms and tests in isolation (dbt/Snowpark/SQL)

-- Fast rollback if a step misbehaves
ALTER TABLE fact_orders
  SWAP WITH fact_orders_backup;  -- metadata-only swap

-- Once validated, publish new marts into prod
CREATE SCHEMA prod.mart_sales_2025_10_01 CLONE prod_candidate_2025_10_01.mart_sales;
