-- Source to ledger control total
CREATE OR REPLACE VIEW ops.v_recon_orders AS
SELECT  'orders' AS source,
        SUM(amount) AS src_sum,
        (SELECT SUM(amount) FROM core.f_journal_line jl
         JOIN core.dim_account a USING (account_id)
         WHERE a.account_code='4000') AS ledger_sum,
        (src_sum - ledger_sum) AS delta
FROM raw.orders_daily
WHERE load_dt BETWEEN :period_start AND :period_end;
