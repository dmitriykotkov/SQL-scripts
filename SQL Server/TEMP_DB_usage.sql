sql-- Check TempDB usage
SELECT SUM(unallocated_extent_page_count) * 8 / 1024 AS free_mb,
       SUM(version_store_reserved_page_count) * 8 / 1024 AS version_store_mb,
       SUM(internal_object_reserved_page_count) * 8 / 1024 AS internal_mb,
       SUM(user_object_reserved_page_count) * 8 / 1024 AS user_objects_mb
FROM   sys.dm_db_file_space_usage;

-- Find sessions using most TempDB space
SELECT TOP 10
       s.session_id,
       s.login_name,
       s.host_name,
       (tsu.user_objects_alloc_page_count * 8) / 1024 AS user_obj_mb,
       (tsu.internal_objects_alloc_page_count * 8) / 1024 AS internal_obj_mb
FROM   sys.dm_db_session_space_usage tsu
JOIN   sys.dm_exec_sessions s ON tsu.session_id = s.session_id
ORDER  BY (tsu.user_objects_alloc_page_count + 
           tsu.internal_objects_alloc_page_count) DESC;
-----------------------------

TempDB best practices:
-- Number of TempDB files = number of CPU cores (up to 8)
-- All files should be equal size
-- Pre-grow files to avoid autogrowth during peak
-- Place on fast SSD storage
-- Enable trace flag 1118 (SQL 2014 and earlier)