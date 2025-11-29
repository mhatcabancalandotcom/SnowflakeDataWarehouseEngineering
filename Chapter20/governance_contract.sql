-- PII must be masked
SELECT object_name, column_name
FROM SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES t
LEFT JOIN SNOWFLAKE.ACCOUNT_USAGE.POLICY_REFERENCES p
  ON p.object_name=t.object_name AND p.column_name=t.column_name
WHERE t.object_database='PROD_CANDIDATE'
  AND t.tag_name='CLASSIFICATION' AND t.tag_value LIKE 'pii.%'
  AND p.policy_name IS NULL;
