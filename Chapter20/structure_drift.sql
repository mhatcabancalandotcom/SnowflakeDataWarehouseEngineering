-- Compare prod vs candidate object lists
WITH prod_objs AS (
  SELECT object_type, object_schema, object_name
  FROM prod.information_schema.objects
  WHERE object_type IN ('TABLE','VIEW','FUNCTION','PROCEDURE')
),
cand_objs AS (
  SELECT object_type, object_schema, object_name
  FROM prod_candidate.information_schema.objects
)
SELECT 'missing_in_candidate' AS kind, p.*
FROM prod_objs p
LEFT JOIN cand_objs c USING(object_type, object_schema, object_name)
WHERE c.object_name IS NULL
UNION ALL
SELECT 'extra_in_candidate', c.*
FROM cand_objs c
LEFT JOIN prod_objs p USING(object_type, object_schema, object_name)
WHERE p.object_name IS NULL;
