-- search workflows by tenant_id and status
Limit  (cost=0.42..26.54 rows=100 width=90) (actual time=6.192..6.281 rows=100 loops=1)
  Buffers: shared hit=81
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..61551.92 rows=235730 width=90) (actual time=6.191..6.267 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: ((status = ANY ('{DRAFT}'::text[])) AND (name ~~* concat('%', NULL::unknown, '%')))
        Rows Removed by Filter: 4500
        Buffers: shared hit=81
Planning Time: 0.261 ms
Execution Time: 6.321 ms