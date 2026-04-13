
Create database:
CREATE DATABASE MDMSTG
    MAXLOGFILES 192
    MAXLOGMEMBERS 3
    MAXDATAFILES 1024
    MAXINSTANCES 32
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 '+REDO/mdmstg/onlinelog/redo01.log'  SIZE 2048M BLOCKSIZE 512,
  GROUP 2 '+REDO/mdmstg/onlinelog/redo02.log'  SIZE 2048M BLOCKSIZE 512,
  GROUP 3 '+REDO/mdmstg/onlinelog/redo03.log'  SIZE 2048M BLOCKSIZE 512,
  GROUP 4 '+REDO/mdmstg/onlinelog/redo04.log'  SIZE 2048M BLOCKSIZE 512
DATAFILE '+DATA/mdmstg/datafile/system01.dbf' size 1000M extent management local
sysaux datafile  '+DATA/mdmstg/datafile/sysaux01.dbf' size 1000M
undo tablespace undotbs1 datafile '+DATA/mdmstg/datafile/undotbs1_01.dbf' size 1000M
default temporary tablespace temp tempfile '+DATA/mdmstg/tempfile/temp01.dbf' size 500m
CHARACTER SET AL32UTF8;


connect /as sysdba
spool dictionary.out 
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catblock.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/catoctk.sql
@?/rdbms/admin/owminst.plb
@?/javavm/install/initjvm.sql
@?/xdk/admin/initxml.sql
@?/xdk/admin/xmlja.sql
@?/rdbms/admin/catjava.sql
@?/rdbms/admin/catexf.sql
@?/rdbms/admin/catclust.sql
spool off;

connect SYSTEM/manager1
spool sqlplus.log
@?/sqlplus/admin/pupbld.sql
@?/sqlplus/admin/help/hlpbld.sql helpus.sql
spool off;

