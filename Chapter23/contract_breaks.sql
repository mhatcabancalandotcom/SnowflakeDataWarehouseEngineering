CREATE TABLE IF NOT EXISTS ops.contract_columns (
  env STRING, sch STRING, obj STRING, col STRING, dtype STRING, snap_ts TIMESTAMP_NTZ
);

-- Snapshot prod and candidate
INSERT INTO ops.contract_columns
SELECT 'prod', table_schema, table_name, column_name, data_type, CURRENT_TIMESTAMP()
FROM prod.information_schema.columns
WHERE table_schema='MART';

INSERT INTO ops.contract_columns
SELECT 'candidate', table_schema, table_name, column_name, data_type, CURRENT_TIMESTAMP()
FROM prod_candidate.information_schema.columns
WHERE table_schema='MART';

-- Diff
SELECT p.obj, p.col, p.dtype AS prod_type, c.dtype AS cand_type
FROM ops.contract_columns p
FULL JOIN ops.contract_columns c
  ON c.env='candidate' AND p.env='prod'
 AND p.sch=c.sch AND p.obj=c.obj AND p.col=c.col
WHERE p.env='prod' AND (c.col IS NULL OR p.dtype <> c.dtype);
