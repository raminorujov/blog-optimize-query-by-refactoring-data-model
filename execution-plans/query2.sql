-- search latest revisions of workflows by tenant_id
Limit  (cost=124820.72..124820.97 rows=100 width=93) (actual time=8570.555..8570.562 rows=100 loops=1)
  Buffers: shared hit=999941 read=6371
  ->  Sort  (cost=124820.72..124828.27 rows=3018 width=93) (actual time=8570.554..8570.557 rows=100 loops=1)
        Sort Key: t.created_at DESC
        Sort Method: top-N heapsort  Memory: 38kB
        Buffers: shared hit=999941 read=6371
        ->  Subquery Scan on t  (cost=0.42..124705.38 rows=3018 width=93) (actual time=24.074..8413.472 rows=568500 loops=1)
              Filter: (t.revision = t.max_rev)
              Rows Removed by Filter: 31500
              Buffers: shared hit=999941 read=6371
              ->  WindowAgg  (cost=0.42..117159.46 rows=603673 width=93) (actual time=24.072..8338.617 rows=600000 loops=1)
                    Buffers: shared hit=999941 read=6371
                    ->  Index Scan using workflow_series_id_revision_unique_idx on workflow w  (cost=0.42..108104.37 rows=603673 width=89) (actual time=24.043..7933.028 rows=600000 loops=1)
                          Filter: ((tenant_id = 'tenant1'::text) AND (name ~~* concat('%', NULL::unknown, '%')))
                          Rows Removed by Filter: 400000
                          Buffers: shared hit=999941 read=6371
Planning Time: 0.248 ms
Execution Time: 8570.599 ms