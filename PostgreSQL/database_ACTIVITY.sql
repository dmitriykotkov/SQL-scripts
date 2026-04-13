-- Full database activity view
SELECT pid,
       usename,
       application_name,
       client_addr,
       state,
       wait_event_type,
       wait_event,
       now() - query_start AS duration,
       left(query, 80) AS query_snippet
FROM   pg_stat_activity
WHERE  state != 'idle'
ORDER  BY duration DESC NULLS LAST;

-- Count connections by state
SELECT state, count(*)
FROM   pg_stat_activity
GROUP  BY state;

-- Count connections by application
SELECT application_name, count(*)
FROM   pg_stat_activity
GROUP  BY application_name
ORDER  BY count(*) DESC;

-- Terminate idle connections older than 10 minutes
SELECT pg_terminate_backend(pid)
FROM   pg_stat_activity
WHERE  state = 'idle'
AND    query_start < now() - INTERVAL '10 minutes';