CREATE OR REPLACE TABLE ops.fx_daily (day DATE PRIMARY KEY, usd_per_credit NUMBER(10,4));

CREATE OR REPLACE VIEW ops.v_cost_by_warehouse_usd AS
SELECT v.day, v.WAREHOUSE_NAME, v.cost_center,
       v.credits, f.usd_per_credit, v.credits * f.usd_per_credit AS cost_usd
FROM ops.v_credits_by_warehouse v
JOIN ops.fx_daily f USING(day);
