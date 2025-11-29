-- Upsert the daily slice (idempotent)
MERGE INTO core.f_opportunity_daily t
USING stage.crm_opportunities s
ON t.opp_id = s.opp_id AND t.snapshot_dt = CURRENT_DATE()
WHEN MATCHED THEN UPDATE SET
  account_id = s.account_id, stage = s.stage, amount = s.amount,
  close_dt = s.close_dt, is_open = s.is_open, is_won = s.is_won, is_lost = s.is_lost
WHEN NOT MATCHED THEN INSERT (opp_id, snapshot_dt, account_id, stage, amount, close_dt, created_dt, is_open, is_won, is_lost, source_system)
VALUES (s.opp_id, CURRENT_DATE(), s.account_id, s.stage, s.amount, s.close_dt, s.created_dt, s.is_open, s.is_won, s.is_lost, 'sf');
