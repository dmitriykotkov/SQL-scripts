clear scre
set timing off
set echo on

-- Disable Column Projection and Predicate Filtering
alter session set cell_offload_processing=false
/

-- Disable Storage Indexes
alter session set "_kcfis_storageidx_disabled"=true
/

set echo off
set timing on
