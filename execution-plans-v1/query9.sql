-- search workflows by tenant_id, status and name
Limit  (cost=0.42..136.46 rows=100 width=90) (actual time=1.186..1.637 rows=100 loops=1)
  Buffers: shared hit=88
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..61551.92 rows=45246 width=90) (actual time=1.185..1.624 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: ((status = ANY ('{DRAFT}'::text[])) AND (name ~~* concat('%', 'a', '%')))
        Rows Removed by Filter: 4873
        Buffers: shared hit=88
Planning Time: 0.173 ms
Execution Time: 1.681 ms