CREATE OR REPLACE VIEW docs.v_markdown_columns AS
SELECT
  obj,
  CONCAT(
    '## ', sch, '.', obj, '\n\n',
    '| Column | Type | Description | Classification |', '\n',
    '|---|---|---|---|', '\n',
    LISTAGG(
      CONCAT(
        '| `', col, '` | ', type,
        CASE WHEN len IS NOT NULL THEN CONCAT('(', len, ')') ELSE '' END,
        CASE WHEN p   IS NOT NULL THEN CONCAT('(', p, ',', s, ')') ELSE '' END,
        ' | ', COALESCE(description,''),
        ' | ', COALESCE(classification,''), ' |'
      ), '\n'
    ) WITHIN GROUP (ORDER BY col)
  ) AS md
FROM docs.v_columns
GROUP BY sch, obj;
