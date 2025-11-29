SELECT COUNT(*)
FROM raw.events
WHERE payload:type::STRING = 'click'
  AND payload:user_id::STRING = 'U123'
  AND payload:ts::DATE BETWEEN '2025-09-01' AND '2025-09-07';
