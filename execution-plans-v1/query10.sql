-- search latest revision of workflows by tenant_id, status and name
Limit  (cost=0.42..144.03 rows=100 width=90) (actual time=1.516..1.923 rows=100 loops=1)
  Buffers: shared hit=88
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..61551.92 rows=42863 width=90) (actual time=1.514..1.909 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: (is_latest_revision AND (status = ANY ('{DRAFT}'::text[])) AND (name ~~* concat('%', 'a', '%')))
        Rows Removed by Filter: 4873
        Buffers: shared hit=88
Planning Time: 0.255 ms
Execution Time: 1.965 ms