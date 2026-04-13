clear scre
set echo on

select /* &student_number */ 
       quantity
      ,amount
from   demo.sales
where  sales_key = 700000
/

set echo off
