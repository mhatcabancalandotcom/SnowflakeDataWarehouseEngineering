-- Fixed-schema extract
CREATE OR REPLACE VIEW fin_close_2025M09.v_regulatory_template AS
SELECT entity_id, period, account_code, balance
FROM fin_close_2025M09.fin.v_trial_balance
WHERE account_code IN ('1000','1100','2000', ...);

-- Emit file with a manifest
COPY INTO @fin_exports/2025-09/reg_template.csv
FROM (SELECT * FROM fin_close_2025M09.v_regulatory_template)
FILE_FORMAT = (TYPE=CSV FIELD_DELIMITER=',' HEADER=TRUE)
OVERWRITE = TRUE;

CREATE TABLE IF NOT EXISTS fin_exports.manifest (
  path STRING, rows NUMBER, bytes NUMBER, created_at TIMESTAMP_NTZ, source_clone STRING, git_sha STRING
);
INSERT INTO fin_exports.manifest
SELECT '2025-09/reg_template.csv', METADATA$FILE_ROW_COUNT, METADATA$FILE_SIZE, CURRENT_TIMESTAMP(), 'fin_close_2025M09', 'git:abcd1234';
