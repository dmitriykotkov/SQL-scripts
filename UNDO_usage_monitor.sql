
select file_name, tablespace_name, bytes, user_bytes from dba_data_files;

select tablespace_name, status, sum(blocks) * 8192/1024/1024/1024 GB from dba_undo_extents group by tablespace_name, status;
  
SELECT d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]",  SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
       (TO_NUMBER(e.value) * TO_NUMBER(f.value) * g.undo_block_per_sec) / (1024*1024) "NEEDED UNDO SIZE [MByte]"
  FROM (
       SELECT SUM(a.bytes) undo_size
         FROM v$datafile a, v$tablespace b, dba_tablespaces c
        WHERE c.contents = 'UNDO' AND c.status = 'ONLINE' AND b.name = c.tablespace_name AND a.ts# = b.ts#
       ) d,
      v$parameter e, v$parameter f,
       ( SELECT MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec FROM v$undostat ) g
 WHERE e.name = 'undo_retention' AND f.name = 'db_block_size'

select      tsu.tablespace_name, ceil(tsu.used_mb) "size MB"
,     decode(ceil(tsf.free_mb), NULL,0,ceil(tsf.free_mb)) "free MB"
,     decode(100 - ceil(tsf.free_mb/tsu.used_mb*100), NULL, 100,
               100 - ceil(tsf.free_mb/tsu.used_mb*100)) "% Used"
from  (select tablespace_name, sum(bytes)/1024/1024 used_mb
      from dba_data_files group by tablespace_name union all
      select      tablespace_name || '  **TEMP**'
      ,     sum(bytes)/1024/1024 used_mb
      from dba_temp_files group by tablespace_name) tsu
,     (select tablespace_name, sum(bytes)/1024/1024 free_mb
      from dba_free_space group by tablespace_name) tsf
where tsu.tablespace_name = tsf.tablespace_name (+)
and tsu.tablespace_name = 'UNDOTBS1'
order by 4
  