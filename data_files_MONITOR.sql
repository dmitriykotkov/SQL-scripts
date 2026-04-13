with d as (
  select s.tablespace_name, round(sum(bytes/1024/1024),2) USED_MB
  from dba_segments s
  group by tablespace_name
)
select df.tablespace_name, nvl(used_mb,0) used_mb, greatest (sum(bytes/1024/1024) , sum(maxbytes/1024/1024) ) total_MB,
   -  nvl(used_mb,0) + greatest (sum(bytes/1024/1024) , sum(maxbytes/1024/1024) ) available_MB
  from dba_data_files df
  left outer join  d on d.tablespace_name=df.tablespace_name
group by df.tablespace_name, used_mb
order by 1

-- select owner, round(sum(bytes)/1024/1024/1024,2) GB from dba_segments group by owner order by 2 desc

-- select * from dba_recyclebin



