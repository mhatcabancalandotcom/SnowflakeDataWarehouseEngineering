{% macro skey(cols) -%}
md5({{ cols | map('string') | join(" || '|' || ") }})
{%- endmacro %}
