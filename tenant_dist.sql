drop table if exists blog.tenant_dist;

create table if not exists blog.tenant_dist
as
select 'tenant1' as tenant_id, 0.6 as dist
union all
select 'tenant2' as tenant_id, 0.2
union all
select 'tenant3' as tenant_id, 0.06
union all
select 'tenant4' as tenant_id, 0.05
union all
select 'tenant5' as tenant_id, 0.03
union all
select 'tenant6' as tenant_id, 0.02
union all
select 'tenant7' as tenant_id, 0.01
union all
select 'tenant8' as tenant_id, 0.01
union all
select 'tenant9' as tenant_id, 0.01
union all
select 'tenant10' as tenant_id, 0.01;