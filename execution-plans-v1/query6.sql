-- search latest revision of workflows by tenant_id and status
Limit  (cost=0.42..27.99 rows=100 width=90) (actual time=1.539..1.616 rows=100 loops=1)
  Buffers: shared hit=81
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..61551.92 rows=223315 width=90) (actual time=1.538..1.604 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: (is_latest_revision AND (status = ANY ('{DRAFT}'::text[])) AND (name ~~* concat('%', NULL::unknown, '%')))
        Rows Removed by Filter: 4500
        Buffers: shared hit=81
Planning Time: 0.204 ms
Execution Time: 1.641 ms