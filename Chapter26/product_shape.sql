CREATE SCHEMA IF NOT EXISTS provider.prod_weather;
CREATE OR REPLACE SECURE VIEW provider.prod_weather.v_daily_v1 AS
SELECT
  as_of_date, iso_country, region, station_id,
  temp_c, precip_mm, wind_kph
FROM provider.core.weather_daily
WHERE as_of_date >= '2020-01-01';

ALTER VIEW provider.prod_weather.v_daily_v1
  SET TAG owner='data_products', classification='public.commercial';
