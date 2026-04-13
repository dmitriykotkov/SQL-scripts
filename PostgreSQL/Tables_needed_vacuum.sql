-- View tables needing vacuum
SELECT schemaname, tablename, 
       n_dead_tup, last_vacuum, last_autovacuum
FROM   pg_stat_user_tables
ORDER  BY n_dead_tup DESC;