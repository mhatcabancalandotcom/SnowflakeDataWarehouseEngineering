SELECT GRANTEE, PRIVILEGE
FROM prod.information_schema.object_privileges
WHERE object_name='V_ORDERS' AND privilege='SELECT'
  AND GRANTEE NOT IN ('ROLE_FIN_READER','ROLE_BI_APP');
