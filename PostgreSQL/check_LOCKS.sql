-- View current locks
SELECT pid, locktype, relation::regclass,
       mode, granted, query
FROM   pg_locks l
JOIN   pg_stat_activity a USING (pid)
WHERE  NOT granted;

-- Find blocking queries
SELECT blocked.pid AS blocked_pid,
       blocked.query AS blocked_query,
       blocking.pid AS blocking_pid,
       blocking.query AS blocking_query
FROM   pg_stat_activity blocked
JOIN   pg_stat_activity blocking
       ON blocking.pid = ANY(pg_blocking_pids(blocked.pid))
WHERE  cardinality(pg_blocking_pids(blocked.pid)) > 0;

-- PostgreSQL detects deadlocks automatically
-- Configure deadlock detection timeout
-- In postgresql.conf:
deadlock_timeout = 1s   -- check for deadlock after 1 second

------------------------------

SELECT pid, 
       usename, 
       pg_blocking_pids(pid) AS blocked_by, 
       QUERY AS blocked_query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;