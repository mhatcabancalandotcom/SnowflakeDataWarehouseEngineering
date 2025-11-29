{% macro recent_days(column, days=7) -%}
{% if is_incremental() -%}
  where {{ column }} >= dateadd(day,-{{ days }}, current_date())
{%- endif %}
{%- endmacro %}
