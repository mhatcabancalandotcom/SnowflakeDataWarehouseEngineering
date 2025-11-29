-- Whole-environment branch for a release
CREATE DATABASE prod_candidate_2025_10_01 CLONE prod;

-- Run migrations, backfills, and tests safely
-- ...

-- Promote a finished mart atomically
ALTER SCHEMA prod.mart_sales
  SWAP WITH prod_candidate_2025_10_01.mart_sales;
