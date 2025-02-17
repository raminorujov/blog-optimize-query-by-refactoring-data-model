drop table if exists blog.workflow_v2;

CREATE TABLE if not exists blog.workflow_v2 (
    id uuid NOT NULL,
    name text NOT NULL,
    description text NULL,
    status text not null,
    series_id uuid NOT NULL,
    revision int NOT NULL,
    next_revision_id uuid,
    created_by text not null,
    created_at timestamp not null,
    tenant_id text not null,
    CONSTRAINT workflow_v2_pk PRIMARY KEY (id)
);

create unique index concurrently if not exists workflow_v2_series_id_revision_unique_idx on
    blog.workflow_v2(series_id, revision);

insert into blog.workflow_v2
select w.id, w.name, w.description, w.status, w.series_id, w.revision,
       (
           select v.id
           from blog.workflow v
           where v.tenant_id = w.tenant_id
             and v.series_id = w.series_id
             and v.revision = w.revision + 1
       ) as next_revision_id,
       w.created_by, w.created_at, w.tenant_id
from blog.workflow w;

create index concurrently if not exists workflow_v2_created_date_idx
    ON blog.workflow_v2 (tenant_id, created_at desc);

analyze blog.workflow_v2;

select count(*)
from blog.workflow_v2;

select count(*)
from blog.workflow_v2 w
where w.next_revision_id is null;

select count(*)
from blog.workflow_v2 w
where w.next_revision_id is not null;

explain (analyze, buffers)
SELECT w.*
FROM blog.workflow_v2 w
WHERE tenant_id = :tenantId
  AND (:statuses IS NULL or status = any(cast(:statuses as text[])))
  AND name ILIKE CONCAT('%', :name, '%')
    and (:latest is null or w.next_revision_id is null)
ORDER BY created_at desc
limit 100;
