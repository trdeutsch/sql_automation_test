{%set model = source('database_name', 'tabel_alias')%}
{%set key = 'column_key'%}
select
count({{key}})
from {{model}}
where {{model}}.business_date = '{{var("business_date")}}'
group by {{key}}
having count({{key}}) > 1