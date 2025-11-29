CREATE SCHEMA IF NOT EXISTS docs;

-- Objects with owner and comments (if you use COMMENT ON)
CREATE OR REPLACE VIEW docs.v_objects AS
SELECT
  t.table_catalog    AS db,
  t.table_schema     AS sch,
  t.table_name       AS name,
  t.table_type       AS kind,
  t.comment          AS description,
  COALESCE(o.tag_value, 'unknown') AS owner
FROM <DB>.INFORMATION_SCHEMA.TABLES t
LEFT JOIN SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES o
  ON o.object_database = t.table_catalog
 AND o.object_schema   = t.table_schema
 AND o.object_name     = t.table_name
 AND o.tag_name        = 'OWNER';

-- Columns with type, comment, and classification
CREATE OR REPLACE VIEW docs.v_columns AS
SELECT
  c.table_schema AS sch,
  c.table_name   AS obj,
  c.column_name  AS col,
  c.data_type    AS type,
  c.character_maximum_length AS len,
  c.numeric_precision        AS p,
  c.numeric_scale            AS s,
  c.comment      AS description,
  COALESCE(t.tag_value,'') AS classification
FROM <DB>.INFORMATION_SCHEMA.COLUMNS c
LEFT JOIN SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES t
  ON t.object_database = c.table_catalog
 AND t.object_schema   = c.table_schema
 AND t.object_name     = c.table_name
 AND COALESCE(t.column_name,'') = c.column_name
 AND t.tag_name = 'CLASSIFICATION';

-- Structural lineage (what feeds this object)
CREATE OR REPLACE VIEW docs.v_lineage AS
SELECT
  REFERENCING_OBJECT_SCHEMA AS sch,
  REFERENCING_OBJECT_NAME   AS obj,
  REFERENCED_OBJECT_SCHEMA  AS src_sch,
  REFERENCED_OBJECT_NAME    AS src_obj,
  REFERENCED_OBJECT_DOMAIN  AS src_type
FROM <DB>.<SCHEMA>.INFORMATION_SCHEMA.OBJECT_DEPENDENCIES;

-- Operational usage (snapshot this nightly for stability)
CREATE OR REPLACE VIEW docs.v_usage_7d AS
SELECT
  DIRECT_OBJECTS_ACCESSED:objectName::string AS obj,
  COUNT(*) AS reads_7d
FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY
WHERE QUERY_START_TIME >= DATEADD(day,-7,CURRENT_TIMESTAMP())
GROUP BY 1;
