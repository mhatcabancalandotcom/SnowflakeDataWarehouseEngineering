CREATE OR REPLACE VIEW docs.v_markdown_index AS
SELECT
  CONCAT(
    '# ', sch, ' — Datasets', '\n\n',
    '| Object | Kind | Owner | Description | Reads (7d) |', '\n',
    '|---|---|---|---|---|', '\n',
    LISTAGG(
      CONCAT(
        '| `', sch, '.', name, '` | ', kind, ' | ',
        owner, ' | ',
        COALESCE(description,'') , ' | ',
        COALESCE(CAST(u.reads_7d AS STRING),'0'), ' |'
      ), '\n'
    ) WITHIN GROUP (ORDER BY name)
  ) AS md
FROM (
  SELECT o.sch, o.name, o.kind, o.description, o.owner, u.reads_7d
  FROM docs.v_objects o
  LEFT JOIN docs.v_usage_7d u ON u.obj = o.name  -- simple join when names are unique within schema
) x
GROUP BY sch;
