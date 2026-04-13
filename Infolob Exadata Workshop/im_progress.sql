set echo off
col segment_name        for a15
col bytes               for 999,999,999,999
col bytes_not_populated for 999,999,999,999


select segment_name
      ,bytes
      ,bytes_not_populated
from  v$im_segments
/

set echo off

