-- search latest revisions of workflows by tenant_id and multiple status
Limit  (cost=0.42..11.95 rows=100 width=90) (actual time=2.258..2.447 rows=100 loops=1)
  Buffers: shared hit=81
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..62302.66 rows=540537 width=90) (actual time=2.257..2.424 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: (is_latest_revision AND (status = ANY ('{DRAFT,PUBLISHED}'::text[])) AND (name ~~* concat('%', NULL::unknown, '%')))
        Rows Removed by Filter: 4500
        Buffers: shared hit=81
Planning Time: 0.254 ms
Execution Time: 2.488 ms