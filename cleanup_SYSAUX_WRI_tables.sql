
SELECT  occupant_name "Item",
    space_usage_kbytes/1048576 "Space Used (GB)",
    schema_name "Schema",
    move_procedure "Move Procedure"
FROM v$sysaux_occupants
ORDER BY 2 desc


select dbms_stats.get_stats_history_retention from dual;


--Set retention of old stats to 10 days

exec dbms_stats.alter_stats_history_retention(10);

--Purge stats older than 10 days (best to do this in stages if there is a lot of data (sysdate-30,sydate-25 etc)

exec DBMS_STATS.PURGE_STATS(SYSDATE-10);

--Show available stats that have not been purged
  
select dbms_stats.get_stats_history_availability from dual;

--Show how big the tables are and rebuild after stats have been purged

select sum(bytes/1024/1024) Mb, segment_name,segment_type from dba_segments
  where  tablespace_name = 'SYSAUX'
    and segment_name like 'WRI$_OPTSTAT%'
    and segment_type='TABLE'
  group by segment_name,segment_type order by 1 asc

select sum(bytes/1024/1024) Mb, segment_name,segment_type from dba_segments
  where  tablespace_name = 'SYSAUX'
    and segment_name like '%OPT%'
    and segment_type='INDEX'
  group by segment_name,segment_type order by 1 asc

select 'alter table '||segment_name||'  move tablespace SYSAUX;' from dba_segments where tablespace_name = 'SYSAUX'

--Script to generate rebuild statements

select 'alter index '||segment_name||'  rebuild online parallel (degree 14);' from dba_segments where tablespace_name = 'SYSAUX'
  and segment_name like '%OPT%' and segment_type='INDEX'

--Once completed it is best to check that the indexes (indices) are usable

select  di.index_name,di.index_type,di.status  from  dba_indexes di , dba_tables dt
  where  di.tablespace_name = 'SYSAUX'
    and dt.table_name = di.table_name
    and di.table_name like '%OPT%'
  order by 1 asc

select 'alter table '||table_name||' disable row movement;' from dba_tables where table_name like 'WRH$_OPT%' or table_name like 'WRI$_OPTSTAT_%'

select 'alter index sys.'||segment_name||'  rebuild online;',owner from dba_segments where tablespace_name = 'SYSAUX' and segment_name like '%OPT%' and segment_type='INDEX'

select * from dba_objects where status<>'VALID';
