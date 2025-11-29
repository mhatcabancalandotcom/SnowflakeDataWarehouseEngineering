-- Minimal: show grants on schema level that differ
SELECT 'grant_in_prod_only' AS kind, g.*
FROM prod.information_schema.applicable_roles g
WHERE NOT EXISTS (
  SELECT 1 FROM prod_candidate.information_schema.applicable_roles c
  WHERE c.grantee = g.grantee AND c.role_name = g.role_name
);
