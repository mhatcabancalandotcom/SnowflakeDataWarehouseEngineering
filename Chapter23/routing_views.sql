-- Router exposes a stable surface while you cut over
CREATE OR REPLACE VIEW mart.v_orders AS
SELECT * FROM mart.v_orders_v1;  -- later switch to v2 in one-line edit
