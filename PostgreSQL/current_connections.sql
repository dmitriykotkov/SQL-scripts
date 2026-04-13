
SELECT datname, usename, ssl, client_addr F
	FROM pg_stat_ssl INNER JOIN pg_stat_activity ON pg_stat_ssl.pid = pg_stat_activity.pid;

-- Check current connections
SELECT count(*), state, wait_event_type
FROM   pg_stat_activity
GROUP  BY state, wait_event_type;
