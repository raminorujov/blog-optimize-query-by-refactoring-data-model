-- search workflows by tenant_id
Limit  (cost=0.42..10.55 rows=100 width=90) (actual time=0.965..1.168 rows=100 loops=1)
  Buffers: shared read=5
  ->  Index Scan using workflow_v1_created_date_idx on workflow_v1 w  (cost=0.42..60801.17 rows=600535 width=90) (actual time=0.963..1.156 rows=100 loops=1)
        Index Cond: (tenant_id = 'tenant1'::text)
        Filter: (name ~~* concat('%', NULL::unknown, '%'))
        Buffers: shared read=5
Planning:
  Buffers: shared hit=1 read=3
Planning Time: 1.309 ms
Execution Time: 1.194 ms