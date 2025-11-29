USE ROLE ROLE_ANALYST;
SELECT EMAIL FROM mart.v_customer_sample LIMIT 1;   -- should be masked

USE ROLE ROLE_PII_READER;
SELECT EMAIL FROM mart.v_customer_sample LIMIT 1;   -- should be clear
