-- search workflows by tenant_id, status and name
Limit  (cost=33856.27..33856.52 rows=100 width=93) (actual time=112.496..113.121 rows=100 loops=1)
Buffers: shared hit=15118
->  Sort  (cost=33856.27..33982.08 rows=50321 width=93) (actual time=112.495..113.115 rows=100 loops=1)
Sort Key: w.created_at DESC
Sort Method: top-N heapsort  Memory: 39kB
Buffers: shared hit=15118
->  WindowAgg  (cost=25317.52..31933.04 rows=50321 width=93) (actual time=87.877..105.641 rows=43172 loops=1)
Buffers: shared hit=15118
->  Gather Merge  (cost=25317.52..31178.23 rows=50321 width=89) (actual time=87.870..93.432 rows=43172 loops=1)
Workers Planned: 2
Workers Launched: 2
Buffers: shared hit=15118
->  Sort  (cost=24317.49..24369.91 rows=20967 width=89) (actual time=77.060..77.793 rows=14391 loops=3)
Sort Key: w.series_id
Sort Method: quicksort  Memory: 1912kB
Buffers: shared hit=15118
Worker 0:  Sort Method: quicksort  Memory: 1787kB
Worker 1:  Sort Method: quicksort  Memory: 1869kB
->  Parallel Seq Scan on workflow w  (cost=0.00..22812.50 rows=20967 width=89) (actual time=43.368..73.853 rows=14391 loops=3)
Filter: ((status = ANY ('{DRAFT}'::text[])) AND (tenant_id = 'tenant1'::text) AND (name ~~* concat('%', 'a', '%')))
Rows Removed by Filter: 318943
Buffers: shared hit=15006
Planning Time: 0.213 ms
Execution Time: 113.162 ms