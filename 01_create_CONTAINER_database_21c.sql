
Create database:
CREATE DATABASE YourCDBName
    USER SYS IDENTIFIED BY YourSysPassword
    USER SYSTEM IDENTIFIED BY YourSystemPassword
    LOGFILE GROUP 1 ('/path/to/redo01.log') SIZE 50M,
            GROUP 2 ('/path/to/redo02.log') SIZE 50M,
            GROUP 3 ('/path/to/redo03.log') SIZE 50M
    MAXLOGFILES 5
    MAXLOGMEMBERS 5
    MAXLOGHISTORY 1
    MAXDATAFILES 100
    CHARACTER SET AL32UTF8
    NATIONAL CHARACTER SET AL16UTF16
    EXTENT MANAGEMENT LOCAL
    DEFAULT TABLESPACE USERS
        DATAFILE '/path/to/users01.dbf' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
    SYSAUX DATAFILE '/path/to/sysaux01.dbf' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
    UNDO TABLESPACE UNDOTBS1
        DATAFILE '/path/to/undotbs01.dbf' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
    TEMP TABLESPACE TEMP
        TEMPFILE '/path/to/temp01.dbf' SIZE 50M AUTOEXTEND ON NEXT 5M MAXSIZE UNLIMITED
    ENABLE PLUGGABLE DATABASE
    SEED FILE_NAME_CONVERT = ('/path/to/seed_template/', '/path/to/your_cdb_datafiles/');

connect /as sysdba
spool dictionary.out 
@?/rdbms/admin/catcdb.sql



--- OLD scripts-----------
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

