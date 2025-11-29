-- Chart of accounts
CREATE TABLE core.dim_account (
  account_id STRING PRIMARY KEY,
  account_code STRING,
  account_name STRING,
  account_type STRING,           -- Asset, Liability, Equity, Revenue, Expense
  natural_sign NUMBER            -- +1 or -1 for balance direction
);

-- Journal header
CREATE TABLE core.f_journal (
  journal_id STRING,
  period DATE,
  entity_id STRING,
  source_system STRING,
  posted_at TIMESTAMP_NTZ,
  restatement_id STRING,         -- NULL for original close
  PRIMARY KEY (journal_id)
);

-- Journal lines (double-entry)
CREATE TABLE core.f_journal_line (
  journal_id STRING,
  line_no NUMBER,
  account_id STRING,
  amount NUMBER(20,4),           -- signed
  currency STRING,
  txn_dt DATE,
  cost_center STRING,
  project STRING
);
