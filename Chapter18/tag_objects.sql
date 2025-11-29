CREATE TAG data_domain ALLOWED_VALUES ('mobility','retail','finance');
ALTER VIEW DATASET.V_TRIPS_V1 SET TAG data_domain='mobility';
