SELECT table_schema, table_name, column_name, data_type, ordinal_position
FROM <DB>.INFORMATION_SCHEMA.COLUMNS
WHERE table_schema = 'MART'
ORDER BY table_name, ordinal_position;
