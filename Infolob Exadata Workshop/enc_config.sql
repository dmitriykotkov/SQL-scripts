clear scre
set echo off

col    owner           for a10
col    table_name      for a20
col    tablespace_name for a20
col    encrypted       for a10

select owner
      ,table_name
      ,tablespace_name
from   dba_tables
where  owner='DEMO'
and    table_name in ('SALES','SALES_ENC')
/

select tablespace_name
      ,encrypted
from   dba_tablespaces
where tablespace_name in ('DEMO_ENC','DEMO_DATA')
/

select status as "wallet status"
from   v$encryption_wallet
/

set echo off

