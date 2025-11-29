-- From ORGADMIN: inventory accounts
SHOW ORGANIZATION ACCOUNTS;

-- Inside an account: keep superuser work minimal
CREATE ROLE data_engineer;
GRANT ROLE data_engineer TO USER alice;
