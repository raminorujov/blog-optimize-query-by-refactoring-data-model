-- search latest revisions of workflows by tenant_id and name
Limit  (cost=48679.90..48680.15 rows=100 width=93) (actual time=193.253..195.060 rows=100 loops=1)
  Buffers: shared hit=15105 read=13, temp read=1395 written=1398
  ->  Sort  (cost=48679.90..48681.50 rows=640 width=93) (actual time=193.251..195.054 rows=100 loops=1)
        Sort Key: t.created_at DESC
        Sort Method: top-N heapsort  Memory: 38kB
        Buffers: shared hit=15105 read=13, temp read=1395 written=1398
        ->  Subquery Scan on t  (cost=30218.38..48655.44 rows=640 width=93) (actual time=127.980..178.613 rows=104463 loops=1)
              Filter: (t.revision = t.max_rev)
              Rows Removed by Filter: 5903
              Buffers: shared hit=15105 read=13, temp read=1395 written=1398
              ->  WindowAgg  (cost=30218.38..47054.63 rows=128065 width=93) (actual time=127.978..173.678 rows=110366 loops=1)
                    Buffers: shared hit=15105 read=13, temp read=1395 written=1398
                    ->  Gather Merge  (cost=30218.38..45133.66 rows=128065 width=89) (actual time=127.970..143.542 rows=110366 loops=1)
                          Workers Planned: 2
                          Workers Launched: 2
                          Buffers: shared hit=15105 read=13, temp read=1395 written=1398
                          ->  Sort  (cost=29218.35..29351.75 rows=53360 width=89) (actual time=101.358..103.205 rows=36789 loops=3)
                                Sort Key: w.series_id
                                Sort Method: external merge  Disk: 4016kB
                                Buffers: shared hit=15105 read=13, temp read=1395 written=1398
                                Worker 0:  Sort Method: external merge  Disk: 3592kB
                                Worker 1:  Sort Method: external merge  Disk: 3552kB
                                ->  Parallel Seq Scan on workflow w  (cost=0.00..22291.67 rows=53360 width=89) (actual time=0.036..84.992 rows=36789 loops=3)
                                      Filter: ((tenant_id = 'tenant1'::text) AND (name ~~* concat('%', 'a', '%')))
                                      Rows Removed by Filter: 296545
                                      Buffers: shared hit=15006
Planning Time: 0.475 ms
Execution Time: 196.647 ms