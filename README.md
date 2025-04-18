# "The Office" Dunder Mifflin HR Analytics – SQL Query Collection

Welcome to the **Dunder Mifflin HR Analytics** SQL project!  
This repository contains a series of structured and well-documented SQL queries designed to analyze a fictional database inspired by characters from *The Office*.

## Project Goals

The purpose of this project is to simulate how an HR or Business Analyst might explore and analyze employee data using SQL and data visualization tools.

To bring this idea to life, I designed a fictional company structure inspired by the Dunder Mifflin Paper Company from "The Office". The dataset includes realistic tables such as employee demographics, salaries, job titles, performance reviews, attendance records, and more.

The main goals of the project include:

- Creating a relational database schema that reflects core HR processes
- Writing and optimizing SQL queries to answer practical business questions
- Practicing advanced SQL techniques like joins, window functions, subqueries, aggregations, and conditional logic
- Identifying trends related to performance, compensation, turnover, and department structure
- Cleaning and preparing data for analysis using best practices
- Visualizing insights using **Power BI** dashboards to simulate reports for HR or executive teams
- Structuring the project in a clean, reproducible, and scalable format for future extensions

This project serves as a playful yet professional way to strengthen data analysis skills while working with a fun and familiar fictional dataset.

## HR Data Structure for Dunder Mifflin

This fictional company structure is based on Dunder Mifflin Paper Company from "The Office". Known for its quirky employees and complex office dynamics, Dunder Mifflin is a prime example of how a workplace can be filled with humor, drama, and unexpected moments — all while still managing to get the job done despite its eccentricities.

<table>
  <tr>
    <td style="width: 70%; vertical-align: top; padding-right: 30px;">
      <img src="https://github.com/user-attachments/assets/596cd299-6c54-41d6-bc54-8981dabf5abc" alt="DMPC scheme" style="max-width: 100%; height: auto; min-width: 600px;">
    </td>
    <td style="width: 30%; vertical-align: top; padding-left: 20px; font-size: 13px; line-height: 1.4;">
      <p>
        The company structure reflects realistic HR operations, including:
      </p>
      <ul>
        <li><code>employee_demographics</code> – basic personal and job information</li>
        <li><code>employee_salary</code> – salary data across departments and roles</li>
        <li><code>job_titles</code> – job hierarchy and title mapping</li>
        <li><code>performance_reviews</code> – employee evaluation history</li>
         <li><code>attendance_records</code> – attendance tracking and absences</li>
      </ul>
    </td>
  </tr>
</table>

You can find the full SQL script used to set up the Dunder Mifflin HR database, including CREATE TABLE, INSERT, and UPDATE statements, in the following file: [dunder_mifflin_db_structure.sql](https://github.com/your-username/your-repo/blob/main/dunder_mifflin_db_structure.sql)

 
I tried to imagine how the HR department at Dunder Mifflin might structure and manage their internal data, using what we know from the show as a creative base. This fictional-but-grounded setup offers a more engaging way to practice SQL, while applying techniques that would be valuable in any real-world HR analytics project.


## SQL Queries

Here, I demonstrate how different SQL commands can be used to find key company metrics. To achieve this, I’ll be utilizing the following commands:

- `JOIN`
- `WINDOW FUNCTIONS`
- `CASE`
- `GROUP BY`
- `HAVING`
- `UNION`
- `Data Cleaning (AND)`

Using SQL queries, you can explore and analyze essential business data such as:

- Retrieve and clean employee data  
- Generate insights from salary, position, and performance metrics  
- Support HR operations like employee role distribution, salary analysis, and attendance tracking.

### 1. Join employee demographics with salary

```sql
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

```
![Join employee demographics with salary](https://github.com/user-attachments/assets/d03e96e6-f827-4ecb-aa02-9c7832082484)

### 2. Classify salary levels using CASE
```sql
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
```
![Classify salary levels using CASE](https://github.com/user-attachments/assets/63cad3a7-7406-41db-9245-b1ffeabbac93)

### 3. Rank employees by salary using a window function
```sql
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
```
![Rank employees by salary using a window function](https://github.com/user-attachments/assets/0eb5db22-49ef-4eef-a216-c4b76ecba6d6)

### 4. Average salary per job title
```sql
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
```
![Average salary per job title](https://github.com/user-attachments/assets/9e043255-62ed-4475-b744-237c6cb4cf38)

### 5. Filter job titles with high average salary
```sql
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
```
![Filter job titles with high average salary](https://github.com/user-attachments/assets/f69a781e-3644-4c8d-a6dc-3e5714c763ff)

### 6. Use aliases for cleaner column names
```sql
SELECT
    firstname AS "First Name",
    lastname AS "Last Name",
    age AS "Age"
FROM
    employee_demographics;
-- Improves readability of the output by using aliases.
```
![Use aliases for cleaner column names](https://github.com/user-attachments/assets/1fa97926-fcb5-4b85-9d53-8a448f821483)

### 7. Combine result sets with UNION
```sql
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
```
![Combine result sets with UNION](https://github.com/user-attachments/assets/8b97cb11-a8d7-41a2-b937-aa9920a69c72)

### 8. Employees with upcoming work anniversaries
```sql
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
```
![Employees with upcoming work anniversaries](https://github.com/user-attachments/assets/b648c31d-2cc7-47b9-9447-e12f9fabb576)

### 9. Headcount by department
```sql
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
```
![Headcount by department](https://github.com/user-attachments/assets/e29e1396-e9a6-4a4a-9102-51794e3c84e7)

### 10. Track Employees with Low Attendance
```sql
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
```
![Track Employees with Low Attendance](https://github.com/user-attachments/assets/2104d631-418c-4a8b-ae28-02ac8806cd28)

### 11.Retrieve employees with salary around 50,000 in the Human Resources department
```sql
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
```
![Retrieve employees with salary around 50,000 in the Human Resources department](https://github.com/user-attachments/assets/551f49e5-c605-4ee3-b176-349c56c8e00b)

You can find the full SQL script containing all analytical queries used for exploring the Dunder Mifflin HR database—ranging from salary breakdowns and employee classifications to department headcounts and attendance tracking—in the following file: [dunder_mifflin_sql_queries.sql](./dunder_mifflin_sql_queries.sql)


## Conclusion
This project offers a foundational SQL toolkit for HR and business analysis. From salary analysis and employee classification to department headcount and attrition tracking, the queries reflect real-world scenarios an analyst may face in an HR environment.

Whether you're building your portfolio, studying for an interview, or learning SQL through storytelling, this Dunder Mifflin database provides a fun and practical learning opportunity.

![A Picture of Holly and Michael](https://github.com/user-attachments/assets/f894e053-644d-449a-a5ed-c5bdf6fdee33)
