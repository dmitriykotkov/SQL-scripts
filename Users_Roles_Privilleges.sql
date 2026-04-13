

DBA_SYS_PRIVS   - System privs
DBA_ROLE_PRIVS  - Roles granted to users and roles
ROLE_ROLE_PRIVS - Roles which are granted to roles
ROLE_SYS_PRIVS  - System privileges granted to roles
ROLE_TAB_PRIVS  - Table privileges granted to roles

select grantee, size_mb, t "Type", nvl(ob,' ') "Object", granted_role from (
  select grantee, 'ROLE' t, null ob, granted_role from dba_role_privs where grantee in (select schema_name from SCHEMAS_TO_MONITOR) --order by 1
  union all
  select grantee, 'ROLE', null, privilege from dba_sys_privs where grantee in (select schema_name from SCHEMAS_TO_MONITOR) --order by 1
  union all
  select grantee, 'TABLE', owner||'.'||table_name, privilege from dba_tab_privs where grantee in (select schema_name from SCHEMAS_TO_MONITOR) --order by 1
)
left outer join (select m.schema_name, u.SIZE_MB from SCHEMAS_TO_MONITOR m, SCHEMA_SPACE_USAGE u where m.id=u.schema_id and u.EXECUTION_ID='20150929164157') 
                 on schema_name=grantee
order by 1