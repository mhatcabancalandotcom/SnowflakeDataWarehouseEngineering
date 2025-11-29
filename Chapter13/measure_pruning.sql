-- How well the table aligns to (event_dt, user_id) filters?
SELECT SYSTEM$CLUSTERING_INFORMATION('FACT_EVENTS') AS info;

-- Storage/partition footprint
SELECT *
FROM INFORMATION_SCHEMA.TABLE_STORAGE_METRICS
WHERE TABLE_NAME = 'FACT_EVENTS';
