-- Safer defaults on shared data
ALTER DATABASE prod SET DATA_RETENTION_TIME_IN_DAYS = 7;

-- Transient staging with minimal retention
CREATE TRANSIENT SCHEMA stage;
ALTER SCHEMA stage SET DATA_RETENTION_TIME_IN_DAYS = 1;
