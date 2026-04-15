sql-- Check log shipping status
SELECT primary_server, primary_database,
       secondary_server, secondary_database,
       last_backup_file, last_backup_date,
       last_copied_file, last_copied_date,
       last_restored_file, last_restored_date
FROM   msdb.dbo.log_shipping_monitor_secondary;

-- Check log shipping alert
SELECT agent_id, time_stamp, 
       restore_threshold,    -- max minutes before alert
       last_restored_date,
       DATEDIFF(MINUTE, last_restored_date, GETDATE()) AS minutes_behind
FROM   msdb.dbo.log_shipping_monitor_secondary;