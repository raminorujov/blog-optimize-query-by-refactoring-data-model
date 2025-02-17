-- search workflows by tenant_id and name
Limit  (cost=51949.18..51949.43 rows=100 width=93) (actual time=172.909..175.396 rows=100 loops=1)
  Buffers: shared hit=15118, temp read=1395 written=1398
  ->  Sort  (cost=51949.18..52269.34 rows=128065 width=93) (actual time=172.908..175.391 rows=100 loops=1)
        Sort Key: w.created_at DESC
        Sort Method: top-N heapsort  Memory: 39kB
        Buffers: shared hit=15118, temp read=1395 written=1398
        ->  WindowAgg  (cost=30218.38..47054.63 rows=128065 width=93) (actual time=109.572..157.614 rows=110366 loops=1)
              Buffers: shared hit=15118, temp read=1395 written=1398
              ->  Gather Merge  (cost=30218.38..45133.66 rows=128065 width=89) (actual time=109.565..126.703 rows=110366 loops=1)
                    Workers Planned: 2
                    Workers Launched: 2
                    Buffers: shared hit=15118, temp read=1395 written=1398
                    ->  Sort  (cost=29218.35..29351.75 rows=53360 width=89) (actual time=96.992..98.971 rows=36789 loops=3)
                          Sort Key: w.series_id
                          Sort Method: external merge  Disk: 4048kB
                          Buffers: shared hit=15118, temp read=1395 written=1398
                          Worker 0:  Sort Method: external merge  Disk: 3608kB
                          Worker 1:  Sort Method: external merge  Disk: 3504kB
                          ->  Parallel Seq Scan on workflow w  (cost=0.00..22291.67 rows=53360 width=89) (actual time=0.038..80.252 rows=36789 loops=3)
                                Filter: ((tenant_id = 'tenant1'::text) AND (name ~~* concat('%', 'a', '%')))
                                Rows Removed by Filter: 296545
                                Buffers: shared hit=15006
Planning Time: 0.217 ms
Execution Time: 176.136 ms