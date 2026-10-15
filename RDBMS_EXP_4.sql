    ON e.project_id = p.project_id;

-- 5. CORRELATED SUBQUERY: employees earning more than their department average
SELECT e.emp_id, e.emp_name, e.dept_id, e.salary
FROM Employee AS e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employee AS e2
    WHERE e2.dept_id = e.dept_id
);

-- 6. EXISTS: departments that have at least one project
SELECT d.dept_id, d.dept_name
FROM Department AS d
WHERE EXISTS (
    SELECT 1
    FROM Project AS p
    WHERE p.dept_id = d.dept_id
);

-- 7. SIMULATED INTERSECT:
-- Employees in departments that also have projects.
-- DISTINCT avoids duplicate employee rows in the result.
SELECT DISTINCT e.emp_id, e.emp_name
FROM Employee AS e
WHERE EXISTS (
    SELECT 1
    FROM Project AS p
    WHERE p.dept_id = e.dept_id
);

-- 8. SIMULATED EXCEPT:
-- Departments that have no employees
SELECT d.dept_id, d.dept_name
FROM Department AS d
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee AS e
    WHERE e.dept_id = d.dept_id
);

-- 9. EXPLAIN: inspect the plan for an INNER JOIN
EXPLAIN
SELECT e.emp_name, d.dept_name
FROM Employee AS e
INNER JOIN Department AS d
    ON e.dept_id = d.dept_id;

-- 10. EXPLAIN: inspect the plan for a correlated subquery
EXPLAIN
SELECT e.emp_id, e.emp_name, e.salary
FROM Employee AS e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employee AS e2
    WHERE e2.dept_id = e.dept_id
);

-- 11. Optional: compare with EXPLAIN ANALYZE (MySQL 8.0.18+)
-- EXPLAIN ANALYZE
-- SELECT e.emp_name, d.dept_name
-- FROM Employee AS e
-- INNER JOIN Department AS d ON e.dept_id = d.dept_id;
