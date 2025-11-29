CREATE SCHEMA IF NOT EXISTS gov;

-- Object inventory (tables and views only)
CREATE OR REPLACE VIEW gov.v_objects AS
SELECT table_catalog AS db, table_schema AS sch, table_name AS name, table_type
FROM <DB>.INFORMATION_SCHEMA.TABLES
UNION ALL
SELECT table_catalog, table_schema, table_name, 'VIEW'
FROM <DB>.INFORMATION_SCHEMA.VIEWS;

-- Column catalog (with simple profiling hooks)
CREATE OR REPLACE VIEW gov.v_columns AS
SELECT table_schema, table_name, column_name, data_type
FROM <DB>.INFORMATION_SCHEMA.COLUMNS;

-- Structural lineage
CREATE OR REPLACE VIEW gov.v_lineage AS
SELECT REFERENCING_OBJECT_SCHEMA AS sch,
       REFERENCING_OBJECT_NAME   AS obj,
       REFERENCED_OBJECT_SCHEMA  AS src_sch,
       REFERENCED_OBJECT_NAME    AS src_obj,
       REFERENCED_OBJECT_DOMAIN  AS src_type
FROM <DB>.<SCHEMA>.INFORMATION_SCHEMA.OBJECT_DEPENDENCIES;
