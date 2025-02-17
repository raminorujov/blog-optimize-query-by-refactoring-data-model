drop table if exists blog.workflow_v1;

CREATE TABLE if not exists blog.workflow_v1 (
    id uuid NOT NULL,
    name text NOT NULL,
    description text NULL,
    status text not null,
    series_id uuid NOT NULL,
    revision int DEFAULT 0 NOT NULL,
    is_latest_revision boolean not null,
    created_by text not null,
    created_at timestamp not null,
    tenant_id text not null,
    CONSTRAINT workflow_v1_pk PRIMARY KEY (id)
);

create unique index concurrently if not exists workflow_v1_series_id_revision_unique_idx on
    blog.workflow_v1(series_id, revision);

insert into blog.workflow_v1
select w.id, w.name, w.description, w.status, w.series_id, w.revision,
       case
           when w.revision = (
               select max(v.revision)
               from blog.workflow v
               where v.tenant_id = w.tenant_id
                 and v.series_id = w.series_id
           ) then true
           else false
           end as is_latest_revision,
       w.created_by, w.created_at, w.tenant_id
from blog.workflow w;

create index concurrently if not exists workflow_v1_created_date_idx
    ON blog.workflow_v1 (tenant_id, created_at desc);

analyze blog.workflow_v1;

select count(*)
from blog.workflow_v1;

select count(*)
from blog.workflow_v1 w
where w.is_latest_revision = true;

explain (analyze, buffers)
SELECT w.*
FROM blog.workflow_v1 w
WHERE tenant_id = :tenantId
  AND (:statuses IS NULL or status = any(cast(:statuses as text[])))
  AND name ILIKE CONCAT('%', :name, '%')
    and (:latest is null or w.is_latest_revision = :latest)
ORDER BY created_at desc
    limit 100;

