-- Check databases at risk of wraparound
SELECT datname,
       age(datfrozenxid) AS xid_age,
       2000000000 - age(datfrozenxid) AS xids_remaining
FROM   pg_database
ORDER  BY xid_age DESC;

-- Check tables at risk
SELECT schemaname, tablename,
       age(relfrozenxid) AS table_age
FROM   pg_class c
JOIN   pg_namespace n ON n.oid = c.relnamespace
WHERE  c.relkind = 'r'
ORDER  BY table_age DESC
LIMIT  20;