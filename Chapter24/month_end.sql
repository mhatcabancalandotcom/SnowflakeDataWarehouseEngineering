-- Freeze books at T-0:01 (or the approved checkpoint)
CREATE DATABASE fin_close_2025M09 CLONE prod;

-- Compute disclosures inside the clone
CREATE OR REPLACE TABLE fin_close_2025M09.report_ifrs_income AS
SELECT ... FROM fin_close_2025M09.fin.v_trial_balance ...;

-- Attest by recording code hash and inputs
CREATE TABLE IF NOT EXISTS fin_close_2025M09.ops.attestation (
  report_name STRING, run_ts TIMESTAMP_NTZ, git_sha STRING, params VARIANT, approver STRING
);
INSERT INTO fin_close_2025M09.ops.attestation
VALUES ('ifrs_income', CURRENT_TIMESTAMP(), 'git:abcd1234', OBJECT_CONSTRUCT('period','2025-09'), CURRENT_USER());

-- Publish as secure views to consumers
CREATE OR REPLACE SECURE VIEW prod_finpub.v_ifrs_income_2025M09 AS
SELECT * FROM fin_close_2025M09.report_ifrs_income;
