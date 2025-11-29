CREATE OR REPLACE FUNCTION util.parse_json(s STRING)
RETURNS VARIANT
LANGUAGE JAVASCRIPT
AS $$
  try { return JSON.parse(s); } catch (e) { return null; }
$$;
