-- Trial balance as-of a snapshot
CREATE OR REPLACE VIEW fin.v_trial_balance AS
SELECT jl.entity_id,
       j.period,
       a.account_code,
       SUM(jl.amount) * a.natural_sign AS balance
FROM core.f_journal_line jl
JOIN core.f_journal j USING (journal_id)
JOIN core.dim_account a USING (account_id)
GROUP BY 1,2,3;
