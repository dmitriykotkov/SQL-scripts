SHOW FULL PROCESSLIST;

SELECT GET_LOCK('foobarbaz', -1);
SELECT IS_USED_LOCK('foobar');

SELECT * FROM performance_schema.metadata_locks WHERE OBJECT_TYPE='USER LEVEL LOCK'

-------------------------------------------------------------------------------------------

mysql> SELECT OWNER_THREAD_ID FROM performance_schema.metadata_locks
    -> WHERE OBJECT_TYPE='USER LEVEL LOCK'
    -> AND OBJECT_NAME='foobarbaz';
+-----------------+
| OWNER_THREAD_ID |
+-----------------+
|              35 |
+-----------------+
1 row in set (0.00 sec)

mysql> SELECT PROCESSLIST_ID FROM performance_schema.threads
    -> WHERE THREAD_ID=35;
+----------------+
| PROCESSLIST_ID |
+----------------+
|             10 |
+----------------+
1 row in set (0.00 sec)

mysql> KILL 10;
Query OK, 0 rows affected (0.00 sec)

----------------------------------------------------------------------------------------

SELECT 
    pl.id
    ,pl.user
    ,pl.state
    ,it.trx_id 
    ,it.trx_mysql_thread_id 
    ,it.trx_query AS query
    ,it.trx_id AS blocking_trx_id
    ,it.trx_mysql_thread_id AS blocking_thread
    ,it.trx_query AS blocking_query
FROM information_schema.processlist AS pl 
INNER JOIN information_schema.innodb_trx AS it
    ON pl.id = it.trx_mysql_thread_id
INNER JOIN information_schema.innodb_lock_waits AS ilw
    ON it.trx_id = ilw.requesting_trx_id 
        AND it.trx_id = ilw.blocking_trx_id

