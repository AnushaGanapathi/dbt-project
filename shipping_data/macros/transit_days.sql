{% macro transit_days(transit_string) %}
    case
        -- If it's already a number like '4', '7'
        when {{ transit_string }} ~ '^\d+$' then
            cast({{ transit_string }} as integer)

        -- If it's like '4 days', '6 Days', '5 DAYS'
        when {{ transit_string }} ~ '^\d+\s*(day|days)?$' then
            cast(regexp_replace(lower({{ transit_string }}), '[^0-9]', '', 'g') as integer)

        -- If it says "Same Day", treat as 1
        when lower({{ transit_string }}) like '%same day%' then
            1

        -- Anything else (e.g., 'Express', 'First Class')
        else null
    end
{% endmacro %}
