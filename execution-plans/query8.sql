-- search latest revisions of workflows by tenant_id and multiple status
Limit  (cost=126481.59..126481.84 rows=100 width=93) (actual time=1154.728..1154.735 rows=100 loops=1)
  Buffers: shared hit=999941 read=6371
  ->  Sort  (cost=126481.59..126488.76 rows=2867 width=93) (actual time=1154.726..1154.729 rows=100 loops=1)
        Sort Key: t.created_at DESC
        Sort Method: top-N heapsort  Memory: 38kB
        Buffers: shared hit=999941 read=6371
        ->  Subquery Scan on t  (cost=0.42..126372.02 rows=2867 width=93) (actual time=0.196..1063.477 rows=568500 loops=1)
              Filter: (t.revision = t.max_rev)
              Rows Removed by Filter: 1500
              Buffers: shared hit=999941 read=6371
              ->  WindowAgg  (cost=0.42..119204.90 rows=573369 width=93) (actual time=0.195..1036.847 rows=570000 loops=1)
                    Buffers: shared hit=999941 read=6371
                    ->  Index Scan using workflow_series_id_revision_unique_idx on workflow w  (cost=0.42..110604.37 rows=573369 width=89) (actual time=0.180..821.256 rows=570000 loops=1)
                          Filter: ((status = ANY ('{DRAFT,PUBLISHED}'::text[])) AND (tenant_id = 'tenant1'::text) AND (name ~~* concat('%', NULL::unknown, '%')))
                          Rows Removed by Filter: 430000
                          Buffers: shared hit=999941 read=6371
Planning Time: 0.224 ms
Execution Time: 1154.772 ms