-- Create a share
CREATE OR REPLACE SHARE sales_public COMMENT='Sales mart public v1';

-- Add objects (schemas/tables/views must be in databases you own)
GRANT USAGE ON DATABASE SALES TO SHARE sales_public;
GRANT USAGE ON SCHEMA   SALES.MART TO SHARE sales_public;

-- Share secure views or tables
GRANT SELECT ON VIEW SALES.MART.V_ORDERS_V1 TO SHARE sales_public;
GRANT SELECT ON VIEW SALES.MART.V_CUSTOMERS_V1 TO SHARE sales_public;

-- Allow a consumer account to see it (same region)
ALTER SHARE sales_public ADD ACCOUNTS = ('CONSUMER_ACCT_NAME');
