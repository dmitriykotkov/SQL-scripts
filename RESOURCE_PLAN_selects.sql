

select name, value from v$parameter order by name

select * from v$rsrc_plan

select * from v$instance

select * from dba_rsrc_plan_directives where plan='DEFAULT_PLAN'

select * from v$rsrc_consumer_group

select * from dba_users where username like 'CIF%'
