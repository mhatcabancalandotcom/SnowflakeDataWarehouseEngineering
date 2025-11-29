-- Primary: authorize where this database may replicate
ALTER DATABASE SALES ENABLE REPLICATION TO ACCOUNTS (PROD_DR_EU);

-- Secondary (target region/cloud): create the replica
CREATE DATABASE SALES_REPL AS REPLICA OF PROD_US.SALES;

-- Optional: refresh on a schedule (via Task) or ad hoc
-- (Task runs: ALTER DATABASE SALES_REPL REFRESH; )
