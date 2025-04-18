set search_path to test_db;

-- 1. Join employee demographics and salary data to get employee details and salaries
SELECT
    e.firstname,
    e.lastname,
    jt.title_id,
    s.salary
FROM
    employee_demographics e
JOIN
    employee_salary s ON e.employee_id = s.employee_id
JOIN
    job_titles jt ON s.title_id = jt.title_id;
-- Returns employee names, job titles, and corresponding salaries.

--2. Classify salary levels using CASE
SELECT
    s.employee_id,
    e.firstname,
    e.lastname,
    s.salary,
    CASE
        WHEN s.salary > 60000 THEN 'High'
        WHEN s.salary BETWEEN 50000 AND 60000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM
    employee_salary s
JOIN
    employee_demographics e ON s.employee_id = e.employee_id;
-- Categorizes employees into salary levels: High, Medium, or Low.

--3. Rank employees by salary using a window function
SELECT
    s.employee_id,
    e.firstname,
    e.lastname,
    s.salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM
    employee_salary s
JOIN
    employee_demographics e ON s.employee_id = e.employee_id;
-- Ranks employees from highest to lowest salary.

--4. Average salary per job title
SELECT
    jt.title_name,
    AVG(s.salary) AS average_salary
FROM
    employee_salary s
JOIN
    job_titles jt ON s.title_id = jt.title_id
GROUP BY
    jt.title_name;
-- Displays average salary for each job title.

--5. Filter job titles with high average salary
SELECT
    jt.title_name,
    AVG(s.salary) AS average_salary
FROM
    employee_salary s
    JOIN
    job_titles jt ON s.title_id = jt.title_id
GROUP BY
    jt.title_name
HAVING
    AVG(salary) > 60000;
-- Shows only job titles where the average salary exceeds $60,000.

--6. Use aliases for cleaner column names
SELECT
    firstname AS "First Name",
    lastname AS "Last Name",
    age AS "Age"
FROM
    employee_demographics;
-- Improves readability of the output by using aliases.

--7. Combine result sets with UNION
SELECT
    e.firstname,
    e.lastname,
    s.salary
FROM
    employee_salary s
JOIN
    employee_demographics e ON s.employee_id = e.employee_id
WHERE
    s.salary > 60000
UNION
SELECT
    e.firstname,
    e.lastname,
    s.salary
FROM
    employee_demographics e
JOIN
    employee_salary s ON s.employee_id = e.employee_id
JOIN
    job_titles jt ON s.title_id = jt.title_id
WHERE
    jt.title_name = 'Manager';
-- Combines employees who earn over $70,000 or hold a "Manager" title.

--8. Employees with upcoming work anniversaries
    SELECT
    e.firstname,
    e.lastname,
    MIN(a.attendance_date) AS first_attendance,
    DATE_PART('year', AGE(CURRENT_DATE, MIN(a.attendance_date))) AS years_with_company
FROM
    employee_demographics e
JOIN
    attendance_records a ON e.employee_id = a.employee_id
GROUP BY
    e.firstname,
    e.lastname
ORDER BY
    first_attendance;
-- Finds employees whose work anniversaries fall in the current month.

--9. Headcount by department
SELECT
    jt.department,
    COUNT(*) AS employee_count
FROM
    employee_demographics e
JOIN
    employee_salary s ON e.employee_id = s.employee_id
JOIN
    job_titles jt ON s.title_id = jt.title_id
GROUP BY
    jt.department
ORDER BY
    employee_count DESC;
-- Counts how many employees are in each department.

-- 10. Track Employees with Low Attendance
SELECT
    e.employee_id,
    e.firstname,
    e.lastname,
    MAX(a.attendance_date) AS last_present_date,
    CURRENT_DATE - MAX(a.attendance_date) AS days_since_last_present
FROM
    employee_demographics e
JOIN
    attendance_records a ON e.employee_id = a.employee_id
WHERE
    a.status = 'Present'
GROUP BY
    e.employee_id, e.firstname, e.lastname
HAVING
    CURRENT_DATE - MAX(a.attendance_date) > 1
ORDER BY
    days_since_last_present DESC;
--This query calculates how many days have passed since each employee's last attendance.

--11.Retrieve employees with salary around 50,000 in the Human Resources department
SELECT
    e.firstname,
    e.lastname,
    s.salary,
    jt.department
FROM
    employee_salary s
JOIN
    employee_demographics e ON s.employee_id = e.employee_id
JOIN
    job_titles jt ON s.title_id = jt.title_id
WHERE
    s.salary = 50000 AND jt.department = 'Human Resources';
--This query retrieves employees from the Human Resources department with a salary of 50,000 for salary analysis within the department.
