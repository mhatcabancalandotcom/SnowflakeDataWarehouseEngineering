CREATE OR REPLACE DYNAMIC TABLE gold.click_sessions
TARGET_LAG = '5 minutes'
WAREHOUSE = wh_streaming
AS
SELECT * FROM /* sessionization SELECT above, wrapped as a view */;
