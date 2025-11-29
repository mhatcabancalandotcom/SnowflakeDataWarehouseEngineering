WITH prod_cols AS (
  SELECT table_schema, table_name, column_name, data_type, ordinal_position
  FROM prod.information_schema.columns
),
cand_cols AS (
  SELECT table_schema, table_name, column_name, data_type, ordinal_position
  FROM prod_candidate.information_schema.columns
)
SELECT 'diff' AS kind, p.table_schema, p.table_name, p.column_name,
       p.data_type AS prod_type, c.data_type AS cand_type
FROM prod_cols p
FULL JOIN cand_cols c
  USING(table_schema, table_name, column_name)
WHERE (p.data_type IS DISTINCT FROM c.data_type)
   OR (p.table_name IS NULL OR c.table_name IS NULL);
