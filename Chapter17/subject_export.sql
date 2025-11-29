CREATE OR REPLACE SECURE VIEW gov.v_subject_bundle AS
SELECT c.customer_id, c.email, c.phone, a.*
FROM core.dim_customer c
LEFT JOIN mart.activity a USING (customer_id);
