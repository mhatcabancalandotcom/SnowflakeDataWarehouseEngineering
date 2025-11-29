CREATE OR REPLACE NETWORK POLICY corp_office
  ALLOWED_IP_LIST = ('203.0.113.0/24','198.51.100.17')
  BLOCKED_IP_LIST = ('0.0.0.0/0');  -- deny all except allow-list

ALTER ACCOUNT SET NETWORK_POLICY = corp_office;
-- Exceptions (e.g., a jump host or a vendor user)
ALTER USER vendor_user SET NETWORK_POLICY = NULL; -- or a narrower policy
