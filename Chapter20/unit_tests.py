# snowpark/python/tests/test_scoring.py
from mypkg.scoring import score_row

def test_score_row_simple():
    row = {"cnt_pos_7d": 3, "amt_30d": 120.0, "days_since_last": 5}
    assert 0.0 <= score_row(row) <= 1.0

# Example: validating a SQL macro with snapshots
SQL_IN  = "SELECT 1 AS x UNION ALL SELECT 2"
EXPECTED= [(1,), (2,)]
