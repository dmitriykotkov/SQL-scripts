sql-- Check AG status
SELECT ag.name AS ag_name,
       ar.replica_server_name,
       ars.role_desc,
       ars.synchronization_health_desc,
       ars.connected_state_desc
FROM   sys.availability_groups ag
JOIN   sys.availability_replicas ar ON ag.group_id = ar.group_id
JOIN   sys.dm_hadr_availability_replica_states ars 
       ON ar.replica_id = ars.replica_id;

-- Check database synchronization state
SELECT db_name(drs.database_id) AS database_name,
       drs.synchronization_state_desc,
       drs.synchronization_health_desc,
       drs.log_send_queue_size,
       drs.redo_queue_size,
       drs.log_send_rate,
       drs.redo_rate
FROM   sys.dm_hadr_database_replica_states drs;

-- Check AG listener
SELECT ag.name, agl.dns_name, 
       agl.port, aglip.ip_address
FROM   sys.availability_group_listeners agl
JOIN   sys.availability_groups ag ON agl.group_id = ag.group_id
JOIN   sys.availability_group_listener_ip_addresses aglip 
       ON agl.listener_id = aglip.listener_id;