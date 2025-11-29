-- Example: UA → device/os (Snowpark Python UDF skeleton)
CREATE OR REPLACE FUNCTION util.parse_ua(ua STRING)
RETURNS OBJECT
LANGUAGE PYTHON
RUNTIME_VERSION='3.10'
PACKAGES=('user-agents')
HANDLER='f'
AS
$$
from user_agents import parse
def f(ua):
    try:
        u = parse(ua or '')
        return {"device": u.device.family, "os": u.os.family, "browser": u.browser.family}
    except:
        return {"device": None, "os": None, "browser": None}
$$;

-- Shaped view for downstream SQL
CREATE OR REPLACE VIEW bronze.events_shaped AS
SELECT
  tenant_id, user_id, device_id, event_ts, event_date, event_type, event_id,
  util.parse_ua(payload:user_agent::string):device::string   AS device_family,
  util.parse_ua(payload:user_agent::string):os::string       AS os_family,
  payload                                                     AS v
FROM raw.events_json;
