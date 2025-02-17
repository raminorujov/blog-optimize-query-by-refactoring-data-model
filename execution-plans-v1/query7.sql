-- search workflows by tenant_id and multiple status
Limit  (cost=0.42..11.34 rows=100 width=90) (actual time=1.200..1.314 rows=100 loops=1)
  Buffers: shared hit=55
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..62302.66 rows=570588 width=90) (actual time=1.199..1.297 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: ((status = ANY ('{DRAFT,PUBLISHED}'::text[])) AND (name ~~* concat('%', NULL::unknown, '%')))
        Rows Removed by Filter: 3000
        Buffers: shared hit=55
Planning Time: 0.197 ms
Execution Time: 1.344 ms