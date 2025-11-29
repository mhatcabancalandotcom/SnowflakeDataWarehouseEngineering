-- Policies
SELECT 'policy_missing_in_candidate' AS kind, p.*
FROM SNOWFLAKE.ACCOUNT_USAGE.POLICY_REFERENCES p
WHERE p.object_database = 'PROD'
  AND NOT EXISTS (
    SELECT 1 FROM SNOWFLAKE.ACCOUNT_USAGE.POLICY_REFERENCES c
    WHERE c.object_database = 'PROD_CANDIDATE'
      AND c.object_name = p.object_name
      AND COALESCE(c.column_name,'') = COALESCE(p.column_name,'')
      AND c.policy_name = p.policy_name
  );

-- Tags (classification/owner/etc.)
SELECT 'tag_missing_in_candidate' AS kind, t.*
FROM SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES t
WHERE t.object_database = 'PROD'
  AND NOT EXISTS (
    SELECT 1 FROM SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES c
    WHERE c.object_database = 'PROD_CANDIDATE'
      AND c.object_name = t.object_name
      AND COALESCE(c.column_name,'') = COALESCE(t.column_name,'')
      AND c.tag_name = t.tag_name
      AND c.tag_value = t.tag_value
  );
