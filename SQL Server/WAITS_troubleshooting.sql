sql-- Top waits across entire server
SELECT TOP 20
       wait_type,
       waiting_tasks_count,
       wait_time_ms / 1000.0 AS wait_time_sec,
       max_wait_time_ms / 1000.0 AS max_wait_sec,
       signal_wait_time_ms / 1000.0 AS signal_wait_sec,
       CAST(100.0 * wait_time_ms / 
            SUM(wait_time_ms) OVER() AS DECIMAL(5,2)) AS pct
FROM   sys.dm_os_wait_stats
WHERE  wait_type NOT IN (
  'SLEEP_TASK','BROKER_TO_FLUSH','BROKER_EVENTHANDLER',
  'CHECKPOINT_QUEUE','DBMIRROR_EVENTS_QUEUE','SQLTRACE_BUFFER_FLUSH',
  'CLR_AUTO_EVENT','DISPATCHER_QUEUE_SEMAPHORE','FT_IFTS_SCHEDULER_IDLE_WAIT'
)
ORDER  BY wait_time_ms DESC;

-- Current active waits
SELECT s.session_id, r.wait_type, r.wait_time,
       r.blocking_session_id, t.text AS query_text
FROM   sys.dm_exec_requests r
JOIN   sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS  APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE  r.wait_type IS NOT NULL
ORDER  BY r.wait_time DESC;
```

**Common wait types and meanings:**

| Wait Type | Indicates | Solution |
|---|---|---|
| PAGEIOLATCH_SH/EX | Disk I/O bottleneck | Add indexes, more RAM, faster disk |
| LCK_M_X | Lock contention | Review transactions, reduce lock duration |
| CXPACKET | Parallel query issues | Tune MAXDOP, fix skewed parallelism |
| SOS_SCHEDULER_YIELD | CPU pressure | Add CPU, tune queries |
| WRITELOG | Log I/O bottleneck | Move log to faster disk |
| RESOURCE_SEMAPHORE | Memory grant issues | Tune queries, add memory |
| ASYNC_NETWORK_IO | Client not consuming results | Fix application |
