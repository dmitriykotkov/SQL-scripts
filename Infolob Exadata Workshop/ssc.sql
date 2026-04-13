/*-----------------------------------------------------------------

Title   : ssc.sql

Desc    : Statement Statistics.  This shows the Exadata Stats for
          an executed statment based on SQL_ID

          Input Value : comment

Author  : TFox

Created : 01/06/2015

-------------------------------------------------------------------*/
clear scre
col child        for 99999
col object_size  for 999,999,999,999
col return_bytes for 999,999,999,999
col smart_scan   for a10
col execs        for 99999
set lines        100

--variable sql_comment varchar2(40);

--accept sql_comment - 
--  prompt 'Enter Comment : '

select /* ssc.sql */ 
       decode(io_cell_offload_eligible_bytes,0,'No','Yes') smart_scan
      ,sql_id
      ,child_number child
      ,executions execs
      ,round((elapsed_time / 1000000),2) elasped
      ,io_cell_offload_eligible_bytes object_size
      ,io_cell_offload_returned_bytes return_bytes
from   v$sql
where  sql_text like '%&sql_comment%'
and    sql_text not like '%ssc.sql%'
order by return_bytes  desc
/

