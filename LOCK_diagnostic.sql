select sw.SID, ss.serial#, sw.seconds_in_wait, sw.event, username, program, module, action, client_info
  from v$session_wait sw , v$session ss
  where sw.seconds_in_wait >  15
  and sw.event <> 'SQL*Net message from client'
  and sw.event <> 'SQL*Net more data to client'
  and sw.event <> 'Null event'
  and sw.event <> 'pipe get'
  and sw.event <> 'rdbms ipc message'
  and sw.event <> 'pmon timer'
  and sw.event <> 'smon timer'
  and sw.state = 'WAITING'
  and ss.sid = sw.sid; 

SELECT DECODE(request,0,'Holder: ','Waiter: ') request, ss.sid sid, serial#, id1, id2, lmode, vl.type type
  FROM V$LOCK vl, v$session ss WHERE (id1, id2, vl.type) IN (SELECT id1, id2, type FROM V$LOCK
  WHERE request>0) AND  ss.sid = vl.sid
  ORDER BY id1, request;

select object_name, do.object_id, session_id, serial#, osuser, username, locked_mode , start_time, module
  from   dba_objects do, v$session, v$locked_object lo, v$transaction
  where to_date(start_time,'MM/DD/YY HH24:MI:SS') < (sysdate-(2/1440))
  and  locked_mode in (3,5,6)
  and  session_id = sid
  and  saddr = ses_addr
  and  lo.object_id = do.object_id
  order by osuser;

--select * from gv$session order by sid

select s.sid, s.serial#, oracle_username, os_user_name, o.object_name, vl.ctime, x.start_time
  from dba_objects o, v$session s, v$locked_object vlo, v$lock vl, v$transaction x
  where o.object_id = vlo.object_id
  and o.object_id = vl.id1
  and vlo.session_id = s.sid
  and vlo.locked_mode in (3,5,6)
  and vlo.xidusn  = x.xidusn
  and vlo.xidslot = x.xidslot
  and vlo.xidsqn  = x.xidsqn
  and vl.block    > 0
  and sysdate     > to_date(x.start_time,'MM/DD/RR HH24:MI:SS')+2/1440;

select holding_session , serial#, oracle_username, os_user_name, module, o.object_name, vl.ctime, x.start_time, sql_text
  from dba_waiters, v$session s, v$locked_object vlo, v$lock vl, v$transaction x, v$open_cursor oc, dba_objects o
  where UPPER(mode_held) = 'EXCLUSIVE'
  and o.object_id    = vlo.object_id
  and o.object_id    = vl.id1
  and vlo.session_id = s.sid
  and vlo.xidusn     = x.xidusn
  and vlo.xidslot    = x.xidslot
  and vlo.xidsqn     = x.xidsqn
  and s.sid          = oc.sid
  and holding_session= s.sid; 

--- Locked Objects
SELECT o.object_name, count(*)
  FROM sys.v_$locked_object a, dba_objects o
  where a.object_id=o.object_id
  group by o.object_name


