-- Anything present in prod must still be present in candidate
SELECT p.column_name
FROM prod.information_schema.columns p
LEFT JOIN prod_candidate.information_schema.columns c
  ON c.table_schema=p.table_schema AND c.table_name=p.table_name AND c.column_name=p.column_name
WHERE p.table_schema='MART' AND p.table_name='FACT_ORDERS' AND c.column_name IS NULL;
