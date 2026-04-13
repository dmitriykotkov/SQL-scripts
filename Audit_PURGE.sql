
### GOOD PAGE       https://oracle-base.com/articles/11g/auditing-enhancements-11gr2


begin
  dbms_audit_mgmt.init_cleanup (
  audit_trail_type=>dbms_audit_mgmt.audit_trail_aud_std,
  default_cleanup_interval=>2);
  end;
  /

DECLARE
  l_days NUMBER := 45;
begin  
  sys.dbms_audit_mgmt.set_last_archive_timestamp(audit_trail_type=>sys.dbms_audit_mgmt.audit_trail_aud_std, last_archive_time=>trunc(sysdate)-l_days); 
  --sys.DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(DBMS_AUDIT_MGMT.audit_trail_fga_std, TRUNC(SYSTIMESTAMP)-l_days);
  --sys.DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(DBMS_AUDIT_MGMT.audit_trail_os, TRUNC(SYSTIMESTAMP)-l_days);
  --sys.DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(DBMS_AUDIT_MGMT.audit_trail_xml, TRUNC(SYSTIMESTAMP)-l_days);
  -- 12cR1 Onwards
  --sys.DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(DBMS_AUDIT_MGMT.audit_trail_unified, TRUNC(SYSTIMESTAMP)-l_days);
  end;
/


BEGIN
  DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL;
END;
/


begin  dbms_audit_mgmt.clean_audit_trail(audit_trail_type=>dbms_audit_mgmt.audit_trail_aud_std, use_last_arch_timestamp=>true);  end;
/


begin
  dbms_audit_mgmt.create_purge_job(
  audit_trail_type=>dbms_audit_mgmt.audit_trail_aud_std,
  audit_trail_purge_interval=>24,
  audit_trail_purge_name=>'DAILY_AUDIT_PURGE_JOB',
  use_last_arch_timestamp=>true);
  end;
/


BEGIN
  DBMS_SCHEDULER.run_job (job_name => 'DAILY_AUDIT_PURGE_JOB', use_current_session => TRUE);
END;
/

############# DISABLE ########################### !!!!!!WORKS-WORKS!!!!!!#######
SQL> noaudit policy ORA_SECURECONFIG;
SQL> noaudit policy ORA_LOGON_FAILURES;


SQL> shutdown immediate;
...
ORACLE-Instanz heruntergefahren.
SQL> startup upgrade;
...
Datenbank geöffnet.
SQL> truncate table AUDSYS."CLI_SWP$18c7c2a9$1$1";
 
Tabelle mit TRUNCATE geleert.
 
SQL> shutdown immediate;
SQL> startup;
################################################################

select count(9) from sys.aud$;
select * from dba_audit_mgmt_config_params;
select * from dba_audit_mgmt_cleanup_jobs;
select * from dba_scheduler_jobs;
select * from dba_audit_mgmt_last_arch_ts

alter table sys.aud$ enable row movement;
alter table sys.aud$ shrink space cascade;
alter table sys.aud$ disable row movement;

select segment_name, sum(bytes) from dba_segments where tablespace_name='SYSAUX' group by segment_name order by 2 desc
