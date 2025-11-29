COPY INTO stage.orders_rejects
FROM @landing/orders/
FILE_FORMAT=(TYPE=CSV)
ON_ERROR='CONTINUE';
