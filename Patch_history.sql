Check Patch Registry
sql-- View all patches applied at SQL level
SELECT patch_id,
       patch_uid,
       version,
       action,         -- APPLY or ROLLBACK
       status,         -- SUCCESS or WITH ERRORS
       description,
       action_time
FROM   dba_registry_sqlpatch
ORDER  BY action_time DESC;

Check for Errors
sql-- Look for any failed patches
SELECT patch_id, status, description
FROM   dba_registry_sqlpatch
WHERE  status != 'SUCCESS';
