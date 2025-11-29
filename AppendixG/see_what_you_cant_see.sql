-- If this returns rows, the name is right but your role can’t read it
SELECT * FROM DB.INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'FACT_ORDERS';
