-- search workflows by tenant_id and status
Limit  (cost=77330.21..77330.46 rows=100 width=93) (actual time=240.398..243.399 rows=100 loops=1)
  Buffers: shared hit=15106 read=12, temp read=2845 written=2851
  ->  Sort  (cost=77330.21..77923.22 rows=237203 width=93) (actual time=240.397..243.393 rows=100 loops=1)
        Sort Key: w.created_at DESC
        Sort Method: top-N heapsort  Memory: 39kB
        Buffers: shared hit=15106 read=12, temp read=2845 written=2851
        ->  WindowAgg  (cost=37080.24..68264.48 rows=237203 width=93) (actual time=110.131..203.944 rows=235500 loops=1)
              Buffers: shared hit=15106 read=12, temp read=2845 written=2851
              ->  Gather Merge  (cost=37080.24..64706.44 rows=237203 width=89) (actual time=110.116..139.967 rows=235500 loops=1)
                    Workers Planned: 2
                    Workers Launched: 2
                    Buffers: shared hit=15106 read=12, temp read=2845 written=2851
                    ->  Sort  (cost=36080.21..36327.30 rows=98835 width=89) (actual time=89.668..94.090 rows=78500 loops=3)
                          Sort Key: w.series_id
                          Sort Method: external merge  Disk: 7792kB
                          Buffers: shared hit=15106 read=12, temp read=2845 written=2851
                          Worker 0:  Sort Method: external merge  Disk: 7456kB
                          Worker 1:  Sort Method: external merge  Disk: 7512kB
                          ->  Parallel Seq Scan on workflow w  (cost=0.00..22812.50 rows=98835 width=89) (actual time=26.670..57.615 rows=78500 loops=3)
                                Filter: ((status = ANY ('{DRAFT}'::text[])) AND (tenant_id = 'tenant1'::text) AND (name ~~* concat('%', NULL::unknown, '%')))
                                Rows Removed by Filter: 254833
                                Buffers: shared hit=15006
Planning Time: 0.241 ms
Execution Time: 244.684 ms