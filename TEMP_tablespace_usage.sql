
SELECT * FROM dba_temp_free_space;

-- TEMP tablespace usage
SELECT   SUM (u.blocks * blk.block_size) / 1024 / 1024 "Mb. in sort segments",
         (hwm.MAX * blk.block_size) / 1024 / 1024 "Mb. High Water Mark"
    FROM v$sort_usage u,
         (SELECT block_size
            FROM dba_tablespaces
           WHERE CONTENTS = 'TEMPORARY') blk,
         (SELECT segblk# + blocks MAX
            FROM v$sort_usage
           WHERE segblk# = (SELECT MAX (segblk#)
                              FROM v$sort_usage)) hwm
GROUP BY hwm.MAX * blk.block_size / 1024 / 1024;

-- Who uses TEMP tablespace
SELECT   b.TABLESPACE, b.segfile#, b.segblk#,
         ROUND (  (  ( b.blocks * p.VALUE ) / 1024 / 1024 ), 2 ) size_mb,
         a.SID, a.serial#, a.username, a.osuser, a.program, a.status
    FROM v$session a, v$sort_usage b, v$process c, v$parameter p
   WHERE p.NAME = 'db_block_size'
     AND a.saddr = b.session_addr
     AND a.paddr = c.addr
ORDER BY b.TABLESPACE, b.segfile#, b.segblk#, b.blocks;

-- TEMP % Usage
select 100*(u.tot/d.tot) "pct_temp_used" FROM
     (select sum(u.blocks) tot from v$tempseg_usage u) u,
     (select sum(d.blocks) tot from dba_temp_files d) d

-- Listing of temp segments.
SELECT A.tablespace_name tablespace, D.mb_total,
  SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
  D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
  FROM v$sort_segment A,
   (
    SELECT B.name, C.block_size, SUM (C.bytes) / 1024 / 1024 mb_total
    FROM v$tablespace B, v$tempfile C
    WHERE B.ts#=C.ts#
    GROUP BY B.name, C.block_size
) D
WHERE A.tablespace_name = D.name
GROUP by A.tablespace_name, D.mb_total;

-- Temp segment usage per session.
SELECT S.sid || ',' || S.serial# sid_serial, S.username, S.osuser, P.spid, S.module,
  P.program, SUM (T.blocks) * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,
  COUNT(*) statements
FROM v$sort_usage T, v$session S, dba_tablespaces TBS, v$process P
WHERE T.session_addr = S.saddr
  AND S.paddr = P.addr
  AND T.tablespace = TBS.tablespace_name
GROUP BY S.sid,S.serial#,S.username,S.osuser,P.spid,S.module,P.program,TBS.block_size,T.tablespace
ORDER BY statements desc;

