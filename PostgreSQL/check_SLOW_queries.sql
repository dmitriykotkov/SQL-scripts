-- Enable slow query logging
-- In postgresql.conf:
log_min_duration_statement = 1000  -- log queries > 1 second

-- Find currently running slow queries
SELECT pid, now() - pg_stat_activity.query_start AS duration,
       query, state
FROM   pg_stat_activity
WHERE  state != 'idle'
AND    query_start < now() - INTERVAL '5 seconds'
ORDER  BY duration DESC;

-- Enable pg_stat_statements for query analytics
CREATE EXTENSION pg_stat_statements;

-- Top 10 slowest queries by total time
SELECT query,
       calls,
       total_exec_time / 1000 AS total_sec,
       mean_exec_time / 1000  AS avg_sec,
       rows
FROM   pg_stat_statements
ORDER  BY total_exec_time DESC
LIMIT  10;

-- Kill a long-running query
SELECT pg_terminate_backend(pid);