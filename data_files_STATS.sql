select file_name,
  tablespace_name, 
  bytes/1024/1024 bytes_mb,
  round(maxbytes/1024/1024) maxbytes_mb , 
  (bytes/blocks)*increment_by/1024/1024 Incr_mb,
  user_bytes/1024/1024 user_bytes_mb,
  AUTOEXTENSIBLE
  from DBA_DATA_FILES 
  order by 2,1