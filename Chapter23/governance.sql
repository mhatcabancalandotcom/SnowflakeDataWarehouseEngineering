-- PII columns must remain masked after rebuilds
SELECT t.object_schema, t.object_name, t.column_name
FROM SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES t
LEFT JOIN SNOWFLAKE.ACCOUNT_USAGE.POLICY_REFERENCES p
  ON p.object_database='PROD_CANDIDATE'
 AND p.object_schema=t.object_schema AND p.object_name=t.object_name AND COALESCE(p.column_name,'')=COALESCE(t.column_name,'')
WHERE t.object_database='PROD_CANDIDATE'
  AND t.tag_name='CLASSIFICATION' AND t.tag_value LIKE 'pii.%'
  AND p.policy_name IS NULL;
