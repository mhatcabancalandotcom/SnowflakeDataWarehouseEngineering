INSERT INTO ops.service_log
SELECT CURRENT_TIMESTAMP(), 'info', 'INC-2025-0912-01', 'BI',
       'Queued P95 above 3s; added lanes to WH_BI; root-cause: top queries scanning >200GB',
       CURRENT_USER(), 'mitigating';
