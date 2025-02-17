-- search latest revisions of workflows by tenant_id
Limit  (cost=0.42..11.11 rows=100 width=90) (actual time=59.830..82.263 rows=100 loops=1)
  Buffers: shared hit=5 read=76
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..60801.17 rows=568907 width=90) (actual time=59.828..82.247 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: (is_latest_revision AND (name ~~* concat('%', NULL::unknown, '%')))
        Rows Removed by Filter: 4500
        Buffers: shared hit=5 read=76
Planning Time: 0.307 ms
Execution Time: 82.305 ms