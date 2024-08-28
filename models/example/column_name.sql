{{config(materialized = 'view')}}
with columns_name as(
    select 
    c.column_name
    from information_schema.columns c
    where c.table_schema = 'schema_name' and c.table_name = 'table_name'
)
select * from columns_name