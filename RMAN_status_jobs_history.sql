-- RMAN backup status

--1 Get RMAN activity history
select session_key, SESSION_RECID, 
  to_char(start_time,'DD-MON-YYYY HH24:MI:SS') starttime,
  to_char(end_time,'DD-MON-YYYY HH24:MI:SS') endtime, status, 
  round(ELAPSED_SECONDS,2) elapsed_seconds
  from V$RMAN_BACKUP_JOB_DETAILS order by start_time desc
 
--2 Get output info based on SESSION_RECID from #1
select output
  from v$rman_output
  where session_recid = 30741
  -- where (select max(session_recid) from v$rman_status)
  order by recid ;
 
-- RMAN execued commands
select * from v$rman_status order by SESSION_RECID desc

--select * from V$FLASH_RECOVERY_AREA_USAGE;
--select * from v$rman_output where output like '%level 0%' order by SESSION_RECID desc

SELECT opname, sid, serial#, context, sofar, totalwork, TIME_REMAINING, round(sofar/totalwork*100,2) "% Complete"
FROM v$session_longops
WHERE opname NOT LIKE '%aggregate%' AND totalwork != 0 AND sofar <> totalwork

