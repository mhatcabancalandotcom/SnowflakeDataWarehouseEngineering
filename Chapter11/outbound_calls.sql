-- Allow only specific HTTPS domains
CREATE NETWORK RULE ext_refdata
  TYPE = HOST_PORT
  MODE = EGRESS
  VALUE_LIST = ('api.example.com:443');

CREATE EXTERNAL ACCESS INTEGRATION eai_refdata
  ALLOWED_NETWORK_RULES = (ext_refdata)
  ENABLED = TRUE;

-- Bind to a procedure
CREATE OR REPLACE PROCEDURE refdata.refresh()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.10'
EXTERNAL_ACCESS_INTEGRATIONS = (eai_refdata)
PACKAGES = ('requests')
AS $$
# call out to api.example.com and write results to a table
$$;
