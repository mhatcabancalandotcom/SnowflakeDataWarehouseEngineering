-- Recent stage activity (confirms KMS-encrypted writes/reads by user/file)
SELECT * 
FROM SNOWFLAKE.ACCOUNT_USAGE.COPY_HISTORY
WHERE START_TIME >= DATEADD(day,-7,CURRENT_TIMESTAMP());

-- Who accessed sensitive tables (tie to masking/row policies separately)
SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY
WHERE QUERY_START_TIME >= DATEADD(day,-7,CURRENT_TIMESTAMP())
  AND OBJECT_NAME IN ('PII.CUSTOMERS','PII.PAYMENTS');
