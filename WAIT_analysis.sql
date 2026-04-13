select name, round(time_secs,2) time_secs,
round(time_secs*100/sum(time_secs) over (),2) pct
from (select e.event name, e.time_waited/100 time_secs, e.total_waits
      
from v$system_event e 
      join v$event_name n on n.name=e.event
      where n.wait_class<>'Idle' and time_waited>0
      
union 
      select 'server CPU', sum (value/1000000) time_secs, null total_waits
      
from v$sys_time_model
      where stat_name in ('background cpu time', 'DB CPU'))
order by time_secs desc