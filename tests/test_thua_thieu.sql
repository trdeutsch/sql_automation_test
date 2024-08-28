{%set model_1 = ref("test_model")%}
{%set model_2 = source('database_name', 'table_alias')%}
{%set key = 'column_key'%}
select
{{model_1}}.{{key}},
{{model_2}}.{{key}}
from {{model_1}}
full join {{model_2}}
on {{model_1}}.{{key}} = {{model_2}}.{{key}}
where {{model_1}}.business_date = '{{var("business_date")}}' 
and {{model_2}}.business_date = '{{var("business_date")}}'
and (
    {{model_1}}.{{key}} is null
    or {{model_2}}.{{key}} is null
)