-- Backfill a late subledger window safely
MERGE INTO prod.core.f_journal_line t
USING (SELECT * FROM stage.subledger WHERE txn_dt BETWEEN :s AND :e) s
ON t.journal_id = s.journal_id AND t.line_no = s.line_no
WHEN MATCHED THEN UPDATE SET amount=s.amount
WHEN NOT MATCHED THEN INSERT (...);
