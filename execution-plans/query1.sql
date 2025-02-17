-- search workflows by tenant_id
Limit  (cost=140231.41..140231.66 rows=100 width=93) (actual time=1494.786..1494.793 rows=100 loops=1)
  Buffers: shared hit=999941 read=6371
  ->  Sort  (cost=140231.41..141740.59 rows=603673 width=93) (actual time=1494.785..1494.787 rows=100 loops=1)
        Sort Key: w.created_at DESC
        Sort Method: top-N heapsort  Memory: 39kB
        Buffers: shared hit=999941 read=6371
        ->  WindowAgg  (cost=0.42..117159.46 rows=603673 width=93) (actual time=1.627..1385.142 rows=600000 loops=1)
              Buffers: shared hit=999941 read=6371
              ->  Index Scan using workflow_series_id_revision_unique_idx on workflow w  (cost=0.42..108104.37 rows=603673 width=89) (actual time=1.378..1131.578 rows=600000 loops=1)
                    Filter: ((tenant_id = 'tenant1'::text) AND (name ~~* concat('%', NULL::unknown, '%')))
                    Rows Removed by Filter: 400000
                    Buffers: shared hit=999941 read=6371
Planning Time: 0.306 ms
Execution Time: 1494.836 ms