-- Minimal catalog of targets
CREATE OR REPLACE TABLE ops.dr_slo (
  product STRING,           -- e.g., 'sales_mart'
  scope   STRING,           -- 'database'|'account'
  rpo_min NUMBER,           -- e.g., 15
  rto_min NUMBER,           -- e.g., 10
  cadence STRING            -- 'hourly at :05', etc.
);

-- Assign clear owners
CREATE OR REPLACE TABLE ops.dr_contacts (
  role STRING, person STRING, contact STRING
);
