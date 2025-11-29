-- Instant branch of a production schema
CREATE SCHEMA prod_candidate CLONE prod;

-- Undo a mistake by swapping in a point-in-time clone
CREATE TABLE core.fact_orders_restore
  CLONE core.fact_orders
  AT (OFFSET => -60*10);  -- 10 minutes ago
ALTER TABLE core.fact_orders_restore SWAP WITH core.fact_orders;
