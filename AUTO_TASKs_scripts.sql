
-- CHECK if locked
select owner, table_name, stattype_locked from dba_tab_statistics where stattype_locked is not null;


-- Check AUTO tasks
SELECT CLIENT_NAME,STATUS FROM DBA_AUTOTASK_CLIENT;

-- Check auto tasks windows
select window_name, autotask_status, optimizer_stats from dba_autotask_window_clients;

-- Auto task schedule
select * from DBA_AUTOTASK_SCHEDULE order by start_time;


-- Disable auto stats
BEGIN
   DBMS_AUTO_TASK_ADMIN.DISABLE(
   client_name => 'auto optimizer stats collection',
   operation => NULL,
   window_name => NULL);
END;
/

-- Enable auto stats
BEGIN
   DBMS_AUTO_TASK_ADMIN.ENABLE(
   client_name => 'auto optimizer stats collection',
   operation => NULL,
   window_name => NULL);
END;
/


-- All auto tasks
EXEC DBMS_AUTO_TASK_ADMIN.disable;
EXEC DBMS_AUTO_TASK_ADMIN.enable;

-- All views
DBA_AUTOTASK_CLIENT
DBA_AUTOTASK_CLIENT_HISTORY
DBA_AUTOTASK_CLIENT_JOB
DBA_AUTOTASK_JOB_HISTORY
select * from DBA_AUTOTASK_OPERATION
select * from DBA_AUTOTASK_SCHEDULE 
DBA_AUTOTASK_TASK
DBA_AUTOTASK_WINDOW_CLIENTS
DBA_AUTOTASK_WINDOW_HISTORY