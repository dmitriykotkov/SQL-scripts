
SELECT * FROM dba_fga_audit_trail;

SELECT object_schema,object_name,policy_name,policy_column,enabled,sel,ins,upd,del FROM dba_audit_policies;


-- Create policy
EXEC DBMS_FGA.ADD_POLICY(object_schema=>'CIF_TRANSACTION', object_name=>'T_CIF_TRANSACTION_DATAMART', policy_name=>'select_DATAMART', statement_types=>'select');


-- Drop policy
EXEC DBMS_FGA.DROP_POLICY(object_schema=>'CIF_TRANSACTION',object_name=>'employees', policy_name=>'check_salary');

