CREATE TAG cost_center ALLOWED_VALUES ('fin','mkt','ops');
ALTER WAREHOUSE wh_bi SET TAG cost_center = 'fin';
