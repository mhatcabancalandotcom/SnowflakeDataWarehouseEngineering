CREATE TABLE IF NOT EXISTS gov.t_access_daily (
  day DATE, object_name STRING, role_name STRING, user_name STRING, reads NUMBER
);

MERGE INTO gov.t_access_daily t
USING (
  SELECT TO_DATE(QUERY_START_TIME) AS day,
         DIRECT_OBJECTS_ACCESSED:objectName::string AS object_name,
         ROLE_NAME, USER_NAME, COUNT(*) AS reads
  FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY
  WHERE QUERY_START_TIME >= DATEADD(day,-2,CURRENT_TIMESTAMP())
  GROUP BY 1,2,3,4
) s
ON t.day=s.day AND t.object_name=s.object_name AND t.role_name=s.role_name AND t.user_name=s.user_name
WHEN MATCHED THEN UPDATE SET reads=s.reads
WHEN NOT MATCHED THEN INSERT VALUES (s.day,s.object_name,s.role_name,s.user_name,s.reads);
