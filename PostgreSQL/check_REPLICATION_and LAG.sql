-- Check replication status (on primary)
SELECT client_addr, state, 
       sent_lsn, write_lsn, 
       flush_lsn, replay_lsn,
       replay_lag
FROM   pg_stat_replication;

-- Check replication lag (on standby)
SELECT now() - pg_last_xact_replay_timestamp() AS replication_lag;