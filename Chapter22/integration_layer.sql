CREATE SCHEMA IF NOT EXISTS gov_api;

-- Inventory (tables + views)
CREATE OR REPLACE VIEW gov_api.v_objects AS
SELECT table_catalog AS db, table_schema AS sch, table_name AS name, table_type
FROM <DB>.INFORMATION_SCHEMA.TABLES
UNION ALL
SELECT table_catalog, table_schema, table_name, 'VIEW'
FROM <DB>.INFORMATION_SCHEMA.VIEWS;

-- Columns
CREATE OR REPLACE VIEW gov_api.v_columns AS
SELECT table_catalog AS db, table_schema AS sch, table_name AS obj, column_name, data_type
FROM <DB>.INFORMATION_SCHEMA.COLUMNS;

-- Structural lineage (within the DB)
CREATE OR REPLACE VIEW gov_api.v_lineage AS
SELECT REFERENCING_OBJECT_DATABASE  AS db,
       REFERENCING_OBJECT_SCHEMA    AS sch,
       REFERENCING_OBJECT_NAME      AS obj,
       REFERENCED_OBJECT_DATABASE   AS src_db,
       REFERENCED_OBJECT_SCHEMA     AS src_sch,
       REFERENCED_OBJECT_NAME       AS src_obj,
       REFERENCED_OBJECT_DOMAIN     AS src_type
FROM <DB>.<SCHEMA>.INFORMATION_SCHEMA.OBJECT_DEPENDENCIES;

-- Tags & classifications
CREATE OR REPLACE VIEW gov_api.v_tags AS
SELECT OBJECT_DATABASE AS db, OBJECT_SCHEMA AS sch, OBJECT_NAME AS obj,
       COLUMN_NAME AS col, TAG_NAME AS tag, TAG_VALUE AS val, MODIFIED
FROM SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES;
