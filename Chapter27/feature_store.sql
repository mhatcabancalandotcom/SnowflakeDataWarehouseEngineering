-- 1) Registry: declare ownership, grain, refresh promise
CREATE SCHEMA IF NOT EXISTS ml;

CREATE OR REPLACE TABLE ml.feature_registry (
  feature_name STRING,             -- e.g., 'user_7d_txn_cnt'
  entity       STRING,             -- 'user_id'
  owner        STRING,             -- 'growth-ml'
  version      STRING,             -- 'v1'
  cadence      STRING,             -- 'hourly'
  description  STRING
);

-- 2) Offline store (wide feature table; entity + as_of_ts)
CREATE OR REPLACE TABLE ml.user_features_offline (
  user_id STRING,
  as_of_ts TIMESTAMP_NTZ,
  txn_cnt_7d NUMBER,
  amt_sum_30d NUMBER(18,2),
  last_seen_minutes NUMBER,
  plan STRING,
  -- keep the envelope columns first for pruning
  PRIMARY KEY (user_id, as_of_ts)
);
