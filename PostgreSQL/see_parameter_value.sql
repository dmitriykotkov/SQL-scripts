
SELECT name as "Parameter name", setting as value, short_desc FROM pg_settings WHERE name LIKE '%ssl%';

SELECT name, setting, short_desc FROM pg_settings 	WHERE name like '%force%'

SELECT name,setting FROM pg_settings WHERE name IN ('wal_level','rds.logical_replication');
