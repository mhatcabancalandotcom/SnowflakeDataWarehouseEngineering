-- Safer default on the prod database
ALTER DATABASE prod SET DATA_RETENTION_TIME_IN_DAYS = 7;

-- Leaner on staging/intermediate layers
ALTER SCHEMA stage SET DATA_RETENTION_TIME_IN_DAYS = 1;
