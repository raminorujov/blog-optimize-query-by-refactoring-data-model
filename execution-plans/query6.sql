-- search latest revision of workflows by tenant_id and status
Limit  (cost=71274.85..71275.10 rows=100 width=93) (actual time=271.956..304.490 rows=100 loops=1)
  Buffers: shared hit=15118, temp read=2845 written=2851
  ->  Sort  (cost=71274.85..71277.81 rows=1186 width=93) (actual time=271.956..304.486 rows=100 loops=1)
        Sort Key: t.created_at DESC
        Sort Method: top-N heapsort  Memory: 39kB
        Buffers: shared hit=15118, temp read=2845 written=2851
        ->  Subquery Scan on t  (cost=37080.24..71229.52 rows=1186 width=93) (actual time=127.627..264.247 rows=235500 loops=1)
              Filter: (t.revision = t.max_rev)
              Buffers: shared hit=15118, temp read=2845 written=2851
              ->  WindowAgg  (cost=37080.24..68264.48 rows=237203 width=93) (actual time=127.626..253.259 rows=235500 loops=1)
                    Buffers: shared hit=15118, temp read=2845 written=2851
                    ->  Gather Merge  (cost=37080.24..64706.44 rows=237203 width=89) (actual time=127.619..188.756 rows=235500 loops=1)
                          Workers Planned: 2
                          Workers Launched: 2
                          Buffers: shared hit=15118, temp read=2845 written=2851
                          ->  Sort  (cost=36080.21..36327.30 rows=98835 width=89) (actual time=85.775..90.423 rows=78500 loops=3)
                                Sort Key: w.series_id
                                Sort Method: external merge  Disk: 7888kB
                                Buffers: shared hit=15118, temp read=2845 written=2851
                                Worker 0:  Sort Method: external merge  Disk: 7408kB
                                Worker 1:  Sort Method: external merge  Disk: 7464kB
                                ->  Parallel Seq Scan on workflow w  (cost=0.00..22812.50 rows=98835 width=89) (actual time=22.109..52.041 rows=78500 loops=3)
                                      Filter: ((status = ANY ('{DRAFT}'::text[])) AND (tenant_id = 'tenant1'::text) AND (name ~~* concat('%', NULL::unknown, '%')))
                                      Rows Removed by Filter: 254833
                                      Buffers: shared hit=15006
Planning Time: 0.202 ms
Execution Time: 305.697 ms