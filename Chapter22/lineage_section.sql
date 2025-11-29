CREATE OR REPLACE VIEW docs.v_markdown_lineage AS
SELECT
  obj,
  CONCAT(
    '### Upstream sources for ', sch, '.', obj, '\n\n',
    LISTAGG(CONCAT('- `', src_sch, '.', src_obj, '` (', src_type, ')'), '\n')
      WITHIN GROUP (ORDER BY src_sch, src_obj)
  ) AS md
FROM docs.v_lineage
GROUP BY sch, obj;
