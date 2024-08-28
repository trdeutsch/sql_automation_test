{%set model_1 = ref('test_model')%}
{%set model_2 = source('database_name', 'table_alias')%}
{{config(error_if = '=2', warn_if = '=2')}}
select count(*) 
from {{model_1}}
where business_date = '{{var("business_date")}}'
union
select count(*)
from {{model_2}}
where business_date = '{{var("business_date")}}'