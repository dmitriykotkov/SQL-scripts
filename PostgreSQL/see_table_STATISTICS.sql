
 SELECT schemaname, relname, last_analyze, n_live_tup FROM pg_stat_all_tables where relname='measurement_high';