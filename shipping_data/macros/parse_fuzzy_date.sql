{% macro parse_fuzzy_date(date_string) %}
    case
        --  '2011-12-05'
        when {{ date_string }} ~ '^\d{4}-\d{2}-\d{2}$' then
            to_date({{ date_string }}, 'YYYY-MM-DD')

        -- '2011/12/12'
        when {{ date_string }} ~ '^\d{4}/\d{2}/\d{2}$' then
            to_date({{ date_string }}, 'YYYY/MM/DD')

        --  '12-24-2011', '12/24/2011', '12.24.2011'
        when {{ date_string }} ~ '^\d{1,2}[-/.]\d{1,2}[-/.]\d{4}$' then
            to_date({{ date_string }}, 'MM/DD/YYYY')

        -- '3/14/12', '9.2.13', '12-1-13'
        when {{ date_string }} ~ '^\d{1,2}[-/.]\d{1,2}[-/.]\d{2}$' then
            to_date({{ date_string }}, 'MM/DD/YY')

        -- '01/12/2012', '12/01/2012' (ambiguous formats)
        when {{ date_string }} ~ '^\d{2}/\d{2}/\d{4}$' then
            to_date({{ date_string }}, 'DD/MM/YYYY')

        --  '12.14.2011' (dots as separators)
        when {{ date_string }} ~ '^\d{2}\.\d{2}\.\d{4}$' then
            to_date({{ date_string }}, 'MM.DD.YYYY')

        --  'Mar 7 2013', 'Sep 16 2012'
        when {{ date_string }} ~ '^[A-Za-z]{3} \d{1,2} \d{4}$' then
            to_date({{ date_string }}, 'Mon DD YYYY')

        -- fallback
        else null
    end
{% endmacro %}
