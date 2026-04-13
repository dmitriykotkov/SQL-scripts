Oracle DBA scripts: DBA_ACTIVE _SESSION _HISTORY queries
-- top users, program,modules,machine,sql_id
SELECT * FROM (
 SELECT count(*) AS count,USERNAME program, module, machine, sql_id
 FROM SYS.DBA_HIST_ACTIVE_SESS_HISTORY, DBA_USERS
 WHERE  DBA_HIST_ACTIVE_SESS_HISTORY.USER_ID=DBA_USERS.USER_ID
 AND session_type='FOREGROUND' 
 AND  sample_time > sysdate-60/1440
 AND sample_time < sysdate
 --AND event = 'library cache: mutex X'
 GROUP BY USERNAME, program, module, machine, sql_id
 ORDER BY count(*) DESC
)
WHERE rownum <= 20

-- top temp segments given than a threshold
SELECT * FROM (
  SELECT count(*) AS count,username, program, module, machine, sql_id,sum(temp_space_allocated)
  FROM SYS.DBA_HIST_ACTIVE_SESS_HISTORY,DBA_USERS
  WHERE DBA_HIST_ACTIVE_SESS_HISTORY.USER_ID=DBA_USERS.USER_ID
  AND sample_time > sysdate-60/1440
  AND sample_time < sysdate
  AND temp_space_allocated > 100*1024*1024
  GROUP BY USERNAME, program, module, machine, sql_id
  ORDER BY count(*) DESC
)
WHERE rownum <= 20
/
--temp space usage and pattern as time grow taken by particular query whose sql_id is listed above
SELECT    sql_id, 
       TO_CHAR(sample_time,'DD-MON-YYYY HH24:MI:SS') AS sample_time, 
       temp_space_allocated/1024/1024
FROM SYS.DBA_HIST_ACTIVE_SESS_HISTORY
WHERE sample_time > sysdate-1
AND sample_time < sysdate
AND sql_id = '6x2bkbryfk69s'
ORDER BY sample_time

SELECT * FROM sys.dba_hist_sqltext WHERE sql_id = '&SQL_ID'
SELECT user_id, username FROM sys.dba_users WHERE user_id = '&USER_ID'

--sessions and SQL to which top allocated pga
SELECT * FROM (
  SELECT 
         count(*) AS count,
         user_id, program, module, machine, sql_id
  FROM SYS.DBA_HIST_ACTIVE_SESS_HISTORY
  WHERE sample_time > sysdate-1
  AND sample_time < sysdate
  AND pga_allocated > 10*1024*1024
  GROUP BY user_id, program, module, machine, sql_id
  ORDER BY count(*) DESC
)
WHERE rownum <= 20

SELECT    sql_id, 
       TO_CHAR(sample_time,'DD-MON-YYYY HH24:MI:SS') AS sample_time, 
       pga_allocated
FROM SYS.DBA_HIST_ACTIVE_SESS_HISTORY
WHERE sample_time > sysdate-1
AND sample_time < sysdate
AND sql_id = '&SQL_ID'
ORDER BY sample_time;