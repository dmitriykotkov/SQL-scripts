
select * from v$database

select * from DBA_HIST_SNAPSHOT order by 1 desc

SELECT output FROM TABLE (dbms_workload_repository.awr_report_html (1002151497,1,5239,5240 ));