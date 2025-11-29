EXPORT DATA WITH PARTITION OPTIONS(partition_expiration_days=30)
OPTIONS(
  uri='gs://company-migration/fact_orders/part-*.parquet',
  format='PARQUET',
  compression='SNAPPY') AS
SELECT * FROM `project.dataset.fact_orders`;
