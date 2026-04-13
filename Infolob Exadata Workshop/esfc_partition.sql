clear scre
set echo on

alter session set cell_offload_processing=false
/
select /* &student_id._esfc */
count(*)
from demo.sales_p partition (p1)
/

set echo off

