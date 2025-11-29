UNLOAD ('SELECT * FROM public.fact_orders')
TO 's3://company-migration/source=db/table=fact_orders/part_'
IAM_ROLE 'arn:aws:iam::...:role/redshift-unload'
FORMAT AS PARQUET;
