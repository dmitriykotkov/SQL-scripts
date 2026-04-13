clear scre
set serveroutput on
set define on

accept student_id char prompt 'student_id :'

declare
  v_blkcnt_cmp pls_integer;
  v_blkcnt_uncmp pls_integer;
  v_row_cmp pls_integer;
  v_row_uncmp pls_integer;
  v_cmp_ratio number;
  v_comptype_str varchar2(60);

begin

  dbms_compression.get_compression_ratio(
  scratchtbsname => upper('DEMO_DATA'),
  ownname => upper('&student_id'),
  objname => upper('&student_id._SALES'),
  subobjname => NULL,
  comptype => DBMS_COMPRESSION.COMP_QUERY_HIGH,
  subset_numrows=> 1000000,
  blkcnt_cmp => v_blkcnt_cmp,
  blkcnt_uncmp => v_blkcnt_uncmp,
  row_cmp => v_row_cmp,
  row_uncmp => v_row_uncmp,
  cmp_ratio => v_cmp_ratio,
  comptype_str => v_comptype_str );
  dbms_output.put_line('.');
  dbms_output.put_line('OUTPUT: ');
  dbms_output.put_line('Estimated Compression Ratio: '||to_char(v_cmp_ratio));
  dbms_output.put_line('Blocks used by compressed sample: '||to_char(v_blkcnt_cmp));
  dbms_output.put_line('Blocks used by uncompressed sample: '||to_char(v_blkcnt_uncmp));
  dbms_output.put_line('Rows in a block in compressed sample: '||to_char(v_row_cmp));
  dbms_output.put_line('Rows in a block in uncompressed sample: '||to_char(v_row_uncmp));
end;
/
