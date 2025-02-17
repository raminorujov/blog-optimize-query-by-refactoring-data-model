-- search latest revision of workflows by tenant_id, status and name
Limit  (cost=36300.80..36301.05 rows=100 width=93) (actual time=130.638..131.540 rows=100 loops=1)
  Buffers: shared hit=15118
  ->  Sort  (cost=36300.80..36301.69 rows=357 width=93) (actual time=130.635..131.532 rows=100 loops=1)
        Sort Key: t.created_at DESC
        Sort Method: top-N heapsort  Memory: 38kB
        Buffers: shared hit=15118
        ->  Subquery Scan on t  (cost=26020.19..36287.16 rows=357 width=93) (actual time=93.619..122.110 rows=61565 loops=1)
              Filter: (t.revision = t.max_rev)
              Buffers: shared hit=15118
              ->  WindowAgg  (cost=26020.19..35395.72 rows=71315 width=93) (actual time=93.618..119.326 rows=61565 loops=1)
                    Buffers: shared hit=15118
                    ->  Gather Merge  (cost=26020.19..34325.99 rows=71315 width=89) (actual time=93.609..102.316 rows=61565 loops=1)
                          Workers Planned: 2
                          Workers Launched: 2
                          Buffers: shared hit=15118
                          ->  Sort  (cost=25020.16..25094.45 rows=29715 width=89) (actual time=75.595..76.465 rows=20522 loops=3)
                                Sort Key: w.series_id
                                Sort Method: quicksort  Memory: 3200kB
                                Buffers: shared hit=15118
                                Worker 0:  Sort Method: quicksort  Memory: 2807kB
                                Worker 1:  Sort Method: quicksort  Memory: 2897kB
                                ->  Parallel Seq Scan on workflow w  (cost=0.00..22812.50 rows=29715 width=89) (actual time=0.031..70.555 rows=20522 loops=3)
                                      Filter: ((status = ANY ('{PUBLISHED}'::text[])) AND (tenant_id = 'tenant1'::text) AND (name ~~* concat('%', 'a', '%')))
                                      Rows Removed by Filter: 312812
                                      Buffers: shared hit=15006
Planning Time: 0.221 ms
Execution Time: 131.637 ms