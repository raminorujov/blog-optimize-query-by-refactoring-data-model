-- search latest revisions of workflows by tenant_id and name
Limit  (cost=0.42..56.11 rows=100 width=90) (actual time=1.438..6.420 rows=100 loops=1)
  Buffers: shared hit=81 read=7
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..60801.17 rows=109195 width=90) (actual time=1.437..6.405 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: (is_latest_revision AND (name ~~* concat('%', 'a', '%')))
        Rows Removed by Filter: 4873
        Buffers: shared hit=81 read=7
Planning Time: 0.152 ms
Execution Time: 6.447 ms