CREATE SCHEMA mart_dev CLONE prod.mart;
CREATE TABLE  mart.fact_orders_dev CLONE prod.mart.fact_orders;
