
select a.inst_id, a.used_ublk, to_char (sysdate, 'hh24:mi:ss')
  from gv$transaction a, gv$session b
 where a.addr = b.taddr and a.inst_id = b.inst_id;
--exit

