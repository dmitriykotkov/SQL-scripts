sql-- Find blocking chains
SELECT blocking.session_id AS blocking_session,
       blocked.session_id  AS blocked_session,
       blocking_text.text  AS blocking_query,
       blocked_text.text   AS blocked_query,
       blocked.wait_type,
       blocked.wait_time / 1000 AS wait_seconds
FROM   sys.dm_exec_requests blocked
JOIN   sys.dm_exec_requests blocking 
       ON blocked.blocking_session_id = blocking.session_id
CROSS  APPLY sys.dm_exec_sql_text(blocked.sql_handle) blocked_text
CROSS  APPLY sys.dm_exec_sql_text(blocking.sql_handle) blocking_text;

-- Find head blocker
SELECT session_id, blocking_session_id,
       wait_type, wait_time,
       status, command
FROM   sys.dm_exec_requests
WHERE  blocking_session_id > 0;

-- View all locks held
SELECT request_session_id,
       resource_type,
       resource_database_id,
       resource_associated_entity_id,
       request_mode,
       request_status
FROM   sys.dm_tran_locks
WHERE  request_session_id > 50
ORDER  BY request_session_id;

-- Kill blocking session (last resort)
KILL 75;  -- session_id of head blocker