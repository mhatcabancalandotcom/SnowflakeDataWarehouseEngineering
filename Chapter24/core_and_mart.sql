-- Core opportunity (atomic grain: opportunity, day)
CREATE TABLE core.f_opportunity_daily (
  opp_id STRING,
  snapshot_dt DATE,
  account_id STRING,
  owner_user_id STRING,
  stage STRING,                -- e.g., 'Qualify','Commit'
  amount NUMBER(18,2),
  currency STRING,
  close_dt DATE,
  created_dt DATE,
  is_open BOOLEAN,
  is_won  BOOLEAN,
  is_lost BOOLEAN,
  source_system STRING
);

-- Slowly changing account dimension (type 2)
CREATE TABLE core.dim_account_scd (
  account_sk NUMBER AUTOINCREMENT,
  account_id STRING,
  name STRING,
  industry STRING,
  segment STRING,              -- Commercial/Enterprise
  territory STRING,
  effective_from DATE,
  effective_to   DATE,         -- '9999-12-31' when current
  is_current BOOLEAN
);
