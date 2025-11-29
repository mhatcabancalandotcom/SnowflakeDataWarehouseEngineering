COPY INTO 'https://account.dfs.core.windows.net/migration/fact_orders/'
FROM fact_orders
WITH (FILE_TYPE = 'PARQUET', MAXERRORS = 0);
