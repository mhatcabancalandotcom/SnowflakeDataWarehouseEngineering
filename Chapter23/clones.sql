-- Choose the scope
CREATE OR REPLACE SCHEMA mart_fix CLONE prod.mart;         -- schema-level
-- or
CREATE OR REPLACE DATABASE prod_fix CLONE prod;            -- database-level
