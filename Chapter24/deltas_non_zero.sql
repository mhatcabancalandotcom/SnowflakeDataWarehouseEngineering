CREATE TABLE IF NOT EXISTS ops.recon_exceptions (
  created_at TIMESTAMP_NTZ, source STRING, period STRING, delta NUMBER(20,4), ticket STRING, status STRING
);
