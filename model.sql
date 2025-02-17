create schema if not exists blog;

drop table if exists blog.workflow;

CREATE TABLE if not exists blog.workflow (
     id uuid NOT NULL,
     name text NOT NULL,
     description text NULL,
     status text not null,
     series_id uuid NOT NULL,
     revision int NOT NULL,
     created_by text not null,
     created_at timestamp not null,
     tenant_id text not null,
     CONSTRAINT workflow_pk PRIMARY KEY (id)
);

create unique index concurrently if not exists workflow_series_id_revision_unique_idx on
    blog.workflow(series_id, revision);

CREATE OR REPLACE FUNCTION blog.random_string(int) RETURNS text
AS $$ SELECT
               array_to_string(ARRAY(SELECT chr(ascii('a') + round(random() * 25)::integer)
    FROM generate_series(1, $1)), '') $$
LANGUAGE sql;

--truncate blog.workflow;

-- 90% revision 1 (60% PUBLISHED, 40% DRAFT)
insert into blog.workflow
select gen_random_uuid() as id, blog.random_string(10) as name, blog.random_string(10) as description, 'PUBLISHED' as status, gen_random_uuid() as series_id, 1 as revision,
       'system' as created_by, now() as create_at, td.tenant_id
from blog.tenant_dist td cross join lateral generate_series(1, round(1000000 * td.dist * 0.9 * 0.6))
union all
select gen_random_uuid() as id, blog.random_string(10) as name, blog.random_string(10) as description, 'DRAFT' as status, gen_random_uuid() as series_id, 1 as revision,
       'system', now(), td.tenant_id
from blog.tenant_dist td cross join lateral generate_series(1, round(1000000 * td.dist * 0.9 * 0.4));

select count(*)
from blog.workflow;

-- 6% revision 2 ARCHIVED + DRAFT
insert into blog.workflow
with archived as (
    select gen_random_uuid() as id, blog.random_string(10) as name, blog.random_string(10) as description, 'ARCHIVED' as status, gen_random_uuid() as series_id, 1 as revision,
           'system' as created_by, now() as created_at, td.tenant_id
    from blog.tenant_dist td cross join lateral generate_series(1, round(1000000 * td.dist * 0.03))
)
,draft as (
select gen_random_uuid() as id, concat(name, ' 2') as name, description, 'DRAFT' as status, series_id, 2 as revision,
       created_by, now(), tenant_id
from archived
)
select *
from archived
union all
select *
from draft;

-- 3% revision 2 ARCHIVED + PUBLISHED
insert into blog.workflow
with archived as (
    select gen_random_uuid() as id, blog.random_string(10) as name, blog.random_string(10) as description, 'ARCHIVED' as status, gen_random_uuid() as series_id, 1 as revision,
           'system' as created_by, now() as created_at, td.tenant_id
    from blog.tenant_dist td cross join lateral generate_series(1, round(1000000 * td.dist * 0.015))
)
   ,published as (
    select gen_random_uuid() as id, concat(name, ' 2') as name, description, 'PUBLISHED' as status, series_id, 2 as revision,
           created_by, now(), tenant_id
    from archived
)
select *
from archived
union all
select *
from published;

-- 1% 4 revision 2x ARCHIVED + PUBLISHED + DRAFT
insert into blog.workflow
with archived1 as (
    select gen_random_uuid() as id, blog.random_string(10) as name, blog.random_string(10) as description, 'ARCHIVED' as status, gen_random_uuid() as series_id, 1 as revision,
           'system' as created_by, now() as created_at, td.tenant_id
    from blog.tenant_dist td cross join lateral generate_series(1, round(1000000 * td.dist * 0.01/4))
)
   ,archived2 as (
    select gen_random_uuid() as id, concat(name, ' 2') as name, description, status, series_id, 2 as revision, created_by, now(), tenant_id
    from archived1
)
   ,published as (
    select gen_random_uuid() as id, concat(name, ' 3') as name, description, 'PUBLISHED' as status, series_id, 3 as revision, created_by, now(), tenant_id
    from archived2
)
   ,draft as (
    select gen_random_uuid() as id, concat(name, ' 4') as name, description, 'DRAFT' as status, series_id, 4 as revision, created_by, now(), tenant_id
    from published
)
select *
from archived1
union all
select *
from archived2
union all
select *
from published
union all
select *
from draft;

select count(*)
from blog.workflow;

create index concurrently if not exists workflow_created_date_idx
    ON blog.workflow(tenant_id, created_at desc);

analyze blog.workflow;
