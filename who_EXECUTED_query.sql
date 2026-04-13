

-- CURRENT
select session_id,username,program, module, client_id,machine, sql_id,to_char(sample_time,'DD-MON-YYYY HH24:MI:SS') sample_time 
  from V$ACTIVE_SESSION_HISTORY h, dba_users u
  where h.user_id=u.user_id and SQL_ID = 'dsk6hgvbj792q' 
  order by sample_time desc

-- HISTORY
select session_id,username,program, module, client_id,machine, sql_id,to_char(sample_time,'DD-MON-YYYY HH24:MI:SS') sample_time 
  from DBA_HIST_ACTIVE_SESS_HISTORY h, dba_users u
  where h.user_id=u.user_id and SQL_ID = 'dsk6hgvbj792q' 
  order by sample_time desc
