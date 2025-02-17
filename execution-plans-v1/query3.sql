-- search workflows by tenant_id and name
Limit  (cost=0.42..53.17 rows=100 width=90) (actual time=0.076..0.491 rows=100 loops=1)
  Buffers: shared hit=11
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..60801.17 rows=115266 width=90) (actual time=0.075..0.478 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: (name ~~* concat('%', 'a', '%'))
        Rows Removed by Filter: 373
        Buffers: shared hit=11
Planning Time: 0.182 ms
Execution Time: 0.522 ms