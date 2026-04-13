
select 'alter system kill session ''' || sid || ',' || serial# || ''' immediate;',
  status, sid, serial#, username, osuser, machine from v$session  where username in ('DKOTKOV');
 
alter system kill session '37,55809' immediate;
