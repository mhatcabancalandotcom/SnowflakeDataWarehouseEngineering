-- One-time: define cost center and environment tags
CREATE TAG cost_center ALLOWED_VALUES ('fin','mkt','ops','eng');
CREATE TAG environment  ALLOWED_VALUES ('prod','stg','dev');

-- Label warehouses (BI/ELT lanes)
ALTER WAREHOUSE wh_bi  SET TAG cost_center='fin', environment='prod';
ALTER WAREHOUSE wh_elt SET TAG cost_center='eng', environment='prod';

-- Label storage ownership at the database level
ALTER DATABASE prod SET TAG cost_center='fin', environment='prod';
