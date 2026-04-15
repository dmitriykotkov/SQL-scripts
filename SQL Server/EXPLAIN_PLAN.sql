sql-- Show estimated execution plan (no execution)
SET SHOWPLAN_ALL ON;
SELECT * FROM employees WHERE dept_id = 10;
SET SHOWPLAN_ALL OFF;

-- Show actual execution plan
SET STATISTICS PROFILE ON;
SELECT * FROM employees WHERE dept_id = 10;
SET STATISTICS PROFILE OFF;

-- Include I/O and time statistics
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT e.name, d.dept_name
FROM   employees e
JOIN   departments d ON e.dept_id = d.dept_id
WHERE  e.salary > 50000;
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;