INSERT INTO mart.fact_orders (SELECT * FROM mart.fact_orders AT (TIMESTAMP => DATEADD('minute', -15, CURRENT_TIMESTAMP())) 
MINUS SELECT * FROM mart.fact_orders);
