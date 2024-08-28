{%set model_1 = ref('test_model')%}
{%set model_2 = source('database_name', 'table_alias')%}
{%set column_1 = dbt_utils.get_filtered_columns_in_relation(ref('test_model'), except = ['column_name'])|sort(reverse = False)%}
{%set column_2 = dbt_utils.get_filtered_columns_in_relation(source('database_name', 'table_alias'), except = ['column_name'])|sort(reverse = False)%}
{%set key = 'cloumn_key'%}
select * from
(
    select
    {{model_1}}.{{key}}
    ,case 
    {%for col_1 in column_1%}
        when coalesce(cast({{model_1}}.{{col_1}} as nvarchar), '') != coalesce(cast({{model_2}}.{{col_1}} as nvarchar), '')
        then concat('{{col_1}}: ', concat(concat('prem: ', concat({{model_1}}.{{col_1}}, ', ')), concat('cloud: ', {{model_2}}.{{col_1}})))
    {%endfor%}
    else 'True' end col_check
    from {{model_1}}
    join {{model_2}}
    on {{model_1}}.{{key}} = {{model_2}}.{{key}}
    where {{model_1}}.business_date = '{{var("business_date")}}' and {{model_2}}.business_date = '{{var("business_date")}}'
) a
where col_check != 'True'