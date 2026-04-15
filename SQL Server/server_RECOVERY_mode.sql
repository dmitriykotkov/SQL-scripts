-- Check current recovery model
SELECT name, recovery_model_desc
FROM sys.databases
WHERE name = 'mydb';

-- Change recovery model
ALTER DATABASE mydb SET RECOVERY FULL;
ALTER DATABASE mydb SET RECOVERY BULK_LOGGED;
ALTER DATABASE mydb SET RECOVERY SIMPLE;