-- search workflows by tenant_id and multiple status
Limit  (cost=141118.66..141118.91 rows=100 width=93) (actual time=1125.691..1125.698 rows=100 loops=1)
  Buffers: shared hit=999941 read=6371
  ->  Sort  (cost=141118.66..142552.08 rows=573369 width=93) (actual time=1125.689..1125.692 rows=100 loops=1)
        Sort Key: w.created_at DESC
        Sort Method: top-N heapsort  Memory: 38kB
        Buffers: shared hit=999941 read=6371
        ->  WindowAgg  (cost=0.42..119204.90 rows=573369 width=93) (actual time=3.099..1037.975 rows=570000 loops=1)
              Buffers: shared hit=999941 read=6371
              ->  Index Scan using workflow_series_id_revision_unique_idx on workflow w  (cost=0.42..110604.37 rows=573369 width=89) (actual time=3.081..808.289 rows=570000 loops=1)
                    Filter: ((status = ANY ('{DRAFT,PUBLISHED}'::text[])) AND (tenant_id = 'tenant1'::text) AND (name ~~* concat('%', NULL::unknown, '%')))
                    Rows Removed by Filter: 430000
                    Buffers: shared hit=999941 read=6371
Planning Time: 0.330 ms
Execution Time: 1125.747 ms