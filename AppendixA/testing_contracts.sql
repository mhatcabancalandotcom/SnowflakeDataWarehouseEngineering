-- Required columns/types on a public view
WITH expected(col, dtype) AS (
  SELECT 'ORDER_ID','NUMBER' UNION ALL
  SELECT 'ORDER_DT','DATE'  UNION ALL
  SELECT 'AMOUNT','NUMBER'
)
SELECT e.col, e.dtype, c.data_type AS found
FROM expected e
LEFT JOIN prod_candidate.information_schema.columns c
  ON c.table_schema='MART' AND c.table_name='V_ORDERS' AND c.column_name=e.col
WHERE c.column_name IS NULL OR UPPER(c.data_type)<>e.dtype;
