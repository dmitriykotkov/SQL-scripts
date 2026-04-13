
SELECT opname, sid, serial#, context, sofar, totalwork, TIME_REMAINING, round(sofar/totalwork*100,2) "% Complete"
FROM v$session_longops
WHERE opname NOT LIKE '%aggregate%' AND totalwork != 0 AND sofar <> totalwork

SELECT opname, target, ROUND((sofar/totalwork),4)*100 Percentage_Complete, start_time, 
CEIL(time_remaining/60) Max_Time_Remaining_In_Min, FLOOR(elapsed_seconds/60) Time_Spent_In_Min
FROM v$session_longops
WHERE sofar != totalwork;

SELECT s.sid, s.serial#, s.machine,
       ROUND(sl.elapsed_seconds/60) || ':' || MOD(sl.elapsed_seconds,60) elapsed,
       ROUND(sl.time_remaining/60) || ':' || MOD(sl.time_remaining,60) remaining,
       ROUND(sl.sofar/sl.totalwork*100, 2) progress_pct
FROM   v$session s,  v$session_longops sl
WHERE  s.sid     = sl.sid
AND    s.serial# = sl.serial#;