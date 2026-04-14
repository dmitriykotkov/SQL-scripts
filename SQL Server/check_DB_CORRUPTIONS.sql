sql-- Check database integrity (most important DBCC command)
DBCC CHECKDB ('mydb') WITH NO_INFOMSGS, ALL_ERRORMSGS;

-- Check specific table
DBCC CHECKTABLE ('employees');

-- Check allocation structures only (faster)
DBCC CHECKALLOC ('mydb');

-- Check catalog consistency
DBCC CHECKCATALOG ('mydb');

-- Output shows:
-- DBCC results for 'mydb'.
-- Service Broker Msg 9675...
-- CHECKDB found 0 allocation errors and 0 consistency errors in database 'mydb'

-- If corruption found:
-- Step 1: Restore from backup (preferred)
RESTORE DATABASE mydb FROM DISK = 'D:\Backup\mydb_full.bak'
WITH RECOVERY;

-- Step 2: If no backup, attempt repair (data loss possible)
-- Set single user mode
ALTER DATABASE mydb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Repair with data loss (last resort)
DBCC CHECKDB ('mydb', REPAIR_ALLOW_DATA_LOSS);

-- Return to multi user
ALTER DATABASE mydb SET MULTI_USER;