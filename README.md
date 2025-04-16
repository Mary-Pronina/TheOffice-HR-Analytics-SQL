# "The Office" Dunder Mifflin HR Analytics – SQL Query Collection

Welcome to the **Dunder Mifflin HR Analytics** SQL project!  
This repository contains a series of structured and well-documented SQL queries designed to analyze a fictional database inspired by characters from *The Office*.

## Project Goals

The purpose of this project is to simulate how an HR or Business Analyst might explore and analyze employee data using SQL.

As a foundation, we created a **fictional company data structure** based on *Dunder Mifflin*, which includes tables such as `employee_demographics`, `employee_salary`, `job_titles`, `performance_reviews`, and more. This allows us to work with a realistic and relatable dataset.

![Company Schema](images/company_schema.png)

This project includes essential SQL techniques such as:

- `JOIN`
- `WINDOW FUNCTIONS`
- `CASE`
- `GROUP BY`
- `HAVING`
- `UNION`

These queries aim to:

- Retrieve and clean employee data  
- Generate insights from salary, position, and performance metrics  
- Support HR operations like promotion analysis, turnover tracking, and compensation benchmarking  


---

## SQL Query Examples

### 1. Join employee demographics with salary

```sql
SELECT
    e.first_name,
    e.last_name,
    e.job_title,
    s.salary
FROM
    employee_demographics e
JOIN
    employee_salary s
ON
    e.employee_id = s.employee_id;
Returns employee names, job titles, and corresponding salaries.
```

### 2. Classify salary levels using CASE
```sql
SELECT
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary > 80000 THEN 'High'
        WHEN salary BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM
    employee_salary;
Categorizes employees into salary levels: High, Medium, or Low.
```

### 3. Rank employees by salary using a window function
```sql
SELECT
    first_name,
    last_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM
    employee_salary;
Ranks employees from highest to lowest salary.
```

### 4. Average salary per job title
```sql
SELECT
    job_title,
    AVG(salary) AS average_salary
FROM
    employee_salary
GROUP BY
    job_title;
Displays average salary for each job title.
```

### 5. Filter job titles with high average salary
```sql
SELECT
    job_title,
    AVG(salary) AS average_salary
FROM
    employee_salary
GROUP BY
    job_title
HAVING
    AVG(salary) > 60000;
Shows only job titles where the average salary exceeds $60,000.
```

### 6. Use aliases for cleaner column names
```sql
SELECT
    first_name AS "First Name",
    last_name AS "Last Name",
    job_title AS "Job Title"
FROM
    employee_demographics;
Improves readability of the output by using aliases.
```

### 7. Combine result sets with UNION
```sql
SELECT
    first_name,
    last_name,
    salary
FROM
    employee_salary
WHERE
    salary > 70000
UNION
SELECT
    first_name,
    last_name,
    salary
FROM
    employee_demographics
WHERE
    job_title = 'Manager';
Combines employees who earn over $70,000 or hold a "Manager" title.
```

### 8. Employees with upcoming work anniversaries
```sql
SELECT
    first_name,
    last_name,
    hire_date,
    DATE_PART('year', AGE(CURRENT_DATE, hire_date)) AS years_with_company
FROM
    employee_demographics
WHERE
    EXTRACT(MONTH FROM hire_date) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND EXTRACT(DAY FROM hire_date) >= EXTRACT(DAY FROM CURRENT_DATE)
ORDER BY
    hire_date;
Finds employees whose work anniversaries fall in the current month.
```

### 9. Headcount by department
```sql
SELECT
    department,
    COUNT(*) AS employee_count
FROM
    employee_demographics
GROUP BY
    department
ORDER BY
    employee_count DESC;
Counts how many employees are in each department.
```

### 10. Employee attrition analysis (based on termination date)
```sql
SELECT
    EXTRACT(YEAR FROM termination_date) AS year,
    COUNT(*) AS employees_left
FROM
    employee_exit_log
WHERE
    termination_date IS NOT NULL
GROUP BY
    EXTRACT(YEAR FROM termination_date)
ORDER BY
    year;
Tracks how many employees left the company each year.
```

## Conclusion
This project offers a foundational SQL toolkit for HR and business analysis. From salary analysis and employee classification to department headcount and attrition tracking, the queries reflect real-world scenarios an analyst may face in an HR environment.

Whether you're building your portfolio, studying for an interview, or learning SQL through storytelling, this Dunder Mifflin database provides a fun and practical learning opportunity.
