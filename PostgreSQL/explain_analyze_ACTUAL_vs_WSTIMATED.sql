-- EXPLAIN ANALYZE executes AND shows actual vs estimated rows
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT e.name, d.dept_name
FROM   employees e
JOIN   departments d ON e.dept_id = d.dept_id
WHERE  e.salary > 50000;