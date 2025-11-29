CREATE TAG cost_center ALLOWED_VALUES ('fin','mkt','ops','eng');

ALTER WAREHOUSE wh_bi_fin SET TAG cost_center = 'fin';
ALTER SESSION SET QUERY_TAG = 'team=fin;purpose=dashboard';
