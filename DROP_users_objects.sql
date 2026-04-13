set serveroutput on;

DECLARE
  i number;
BEGIN
  i:=0;
  DBMS_OUTPUT.ENABLE(1000000); 
  for rec in (select 'drop ' || o.object_type || ' ' 
                 || o.owner || '.' || o.object_name || decode(o.object_type,
                 'CLUSTER', ' including tables cascade constraints;',
                 'TABLE', ' cascade constraints;',
                 ';') drop_line
               from dba_objects o
               where owner in ('GPIMS') 
               and o.object_name not like 'BIN$%' 
               and object_type in ('CLUSTER','TABLE','VIEW','SEQUENCE','SYNONYM','TYPE',
                                   'FUNCTION','PROCEDURE','PACKAGE')) LOOP                                   
    i:=i+1;
    DBMS_OUTPUT.PUT_LINE(rec.drop_line);     
  END LOOP;
  dbms_output.put_line('--= Total: ' || i || ' objects =--');
END;
/
