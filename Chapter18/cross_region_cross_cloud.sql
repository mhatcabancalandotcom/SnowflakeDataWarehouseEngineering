-- Provider: enable replication on the source database
ALTER DATABASE SALES ENABLE REPLICATION TO ACCOUNTS (PROVIDER_ACCT_REPL_TARGET);

-- Create the replica in target region account
CREATE DATABASE SALES_REPLICA AS REPLICA OF PROVIDER_ACCT.SALES;

-- Create share in the target region account, grant from SALES_REPLICA
CREATE SHARE sales_public_eu;
GRANT USAGE ON DATABASE SALES_REPLICA TO SHARE sales_public_eu;
...
