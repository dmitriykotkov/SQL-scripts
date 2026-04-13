-- Check WAL configuration
SHOW wal_level;
SHOW archive_mode;
SHOW archive_command;

-- Check WAL files
SELECT * FROM pg_ls_waldir() LIMIT 10;