clear scre
alter session set cell_offload_processing=false
/
set echo on

select /* &student_id._hcc */
       count(*) 
from demo.sales_qh 
/

set echo off
alter session set cell_offload_processing=true
/

