CREATE OR REPLACE SECURE VIEW provider.prod_weather.v_daily_v2 AS
SELECT as_of_date, iso_country, region, station_id, temp_c, precip_mm, wind_kph, dewpoint_c
FROM provider.core.weather_daily;

-- Router you use internally and flip later
CREATE OR REPLACE VIEW provider.prod_weather.v_daily AS
SELECT * FROM provider.prod_weather.v_daily_v1;
