{% macro safe_cast(value, type) %}
    case
        when {{ value }} ~ '^[0-9]+(\.[0-9]+)?$' then {{ value }}::{{ type }}
        else null
    end
{% endmacro %}