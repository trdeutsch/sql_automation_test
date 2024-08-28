{{config(materialized = 'table')}}
{%set model_1 = source('database_name', 'table_alias')%}
select
{%for value in dbt_utils.get_column_values(ref('column_name'), column = 'column_name')%}
    {{value}}
{%if not loop.last%},{%endif%}
{%endfor%}
from {{model_1}}
where {{model_1}}.business_date = '{{var("business_date")}}'