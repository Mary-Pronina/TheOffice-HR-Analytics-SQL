-- =============================================
-- SQL Project: "The Office" HR & Salary Database
-- Description: Simulated HR schema and data for analysis
-- =============================================

-- ========================
-- 1. Create Base Tables
-- ========================

-- Employee Demographics
CREATE TABLE employee_demographics (
    employee_id INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

-- Employee Salary
CREATE TABLE employee_salary (
    employee_id INT,
    effective_date DATE,
    salary INT,
    bonus INT,
    pay_grade VARCHAR(20),
    title_id INT,
    PRIMARY KEY (employee_id, effective_date),
    FOREIGN KEY (employee_id) REFERENCES employee_demographics(employee_id),
    FOREIGN KEY (title_id) REFERENCES job_titles(title_id)
);

-- Job Titles
CREATE TABLE job_titles (
    title_id SERIAL PRIMARY KEY,
    title_name VARCHAR(255) NOT NULL,
    level VARCHAR(50),
    department VARCHAR(255)
);

-- Performance Reviews
CREATE TABLE performance_reviews (
    review_id SERIAL PRIMARY KEY,
    employee_id INT,
    review_date DATE,
    performance_score INT CHECK (performance_score BETWEEN 1 AND 5),
    manager_comments TEXT,
    FOREIGN KEY (employee_id) REFERENCES employee_demographics(employee_id)
);

-- Attendance Records
CREATE TABLE attendance_records (
    employee_id INT,
    attendance_date DATE,
    status VARCHAR(20) CHECK (status IN ('Present', 'Late', 'Sick', 'Vacation')),
    PRIMARY KEY (employee_id, attendance_date),
    FOREIGN KEY (employee_id) REFERENCES employee_demographics(employee_id)
);

-- =========================
-- 2. Populate Lookup Table
-- =========================

INSERT INTO job_titles (title_name, level, department) VALUES
('Salesman', 'Entry-Level', 'Sales'),
('Accountant', 'Mid-Level', 'Accounting'),
('HR', 'Mid-Level', 'Human Resources'),
('Regional Manager', 'Senior-Level', 'Regional Management'),
('Supplier Relations', 'Entry-Level', 'Operations'),
('Receptionist', 'Entry-Level', 'Administration');

-- ========================
-- 3. Insert Sample Salaries
-- ========================

INSERT INTO employee_salary (employee_id, effective_date, salary, bonus, pay_grade, title_id) VALUES
(1001, '2025-04-01', 60000, 8000, 'Grade B', 1),
(1002, '2025-04-01', 52000, 2000, 'Grade C', 6),
(1003, '2025-04-01', 58000, 8000, 'Grade B', 1),
(1004, '2025-04-01', 54000, 5000, 'Grade B', 2),
(1005, '2025-04-01', 56000, 6000, 'Grade B', 3),
(1006, '2025-04-01', 80000, 12000, 'Grade A', 4),
(1007, '2025-04-01', 51000, 4500, 'Grade C', 5),
(1008, '2025-04-01', 62000, 8000, 'Grade B', 1),
(1009, '2025-04-01', 50000, 5000, 'Grade B', 2),
(1010, '2025-04-01', 41000, 2000, 'Grade C', 6),
(1011, '2025-04-01', 45000, 3000, 'Grade D', NULL),
(1013, '2025-04-01', 47000, 3000, 'Grade D', NULL);

-- ============================
-- 4. Insert Performance Reviews
-- ============================

INSERT INTO performance_reviews (employee_id, review_date, performance_score, manager_comments)
VALUES
(1001, '2025-04-01', 4, 'Strong sales performance, needs improvement in team collaboration.'),
(1002, '2025-04-01', 3, 'Good attendance, but needs to improve communication skills.'),
(1003, '2025-04-01', 5, 'Excellent work in handling customer relations and meeting sales targets.'),
(1004, '2025-04-01', 2, 'Inconsistent work performance, needs to meet deadlines more effectively.'),
(1005, '2025-04-01', 4, 'Great HR management and support, can take on more leadership roles.'),
(1006, '2025-04-01', 5, 'Exemplary leadership skills and regional performance.'),
(1007, '2025-04-01', 3, 'Could improve supplier negotiations and handling of complaints.'),
(1008, '2025-04-01', 4, 'Good performance in sales, but should focus on upselling.'),
(1009, '2025-04-01', 3, 'Solid performance in accounting, needs to work on attention to detail.'),
(1010, '2025-04-01', 5, 'Perfect support for office administration, always on top of things.');

-- ===========================
-- 5. Insert Attendance Record
-- ===========================

INSERT INTO attendance_records (employee_id, attendance_date, status)
VALUES
(1011, '2025-04-01', 'Present'),
(1013, '2025-04-01', 'Present'),
(1001, '2025-04-01', 'Sick'),
(1002, '2025-04-01', 'Present'),
(1003, '2025-04-01', 'Vacation'),
(1004, '2025-04-01', 'Present'),
(1005, '2025-04-01', 'Present'),
(1006, '2025-04-01', 'Vacation'),
(1007, '2025-04-01', 'Sick'),
(1008, '2025-04-01', 'Present'),
(1009, '2025-04-01', 'Present'),
(1010, '2025-04-01', 'Vacation');

-- ===========================
-- 6. Update employee_demographics to fill missing values
-- Purpose: Populate NULL age and gender fields for employees with gaps
--          to ensure data completeness for analysis and reporting.
-- ===========================

-- Fill in age for Darryl Philbin (ID 1013)
UPDATE employee_demographics
SET age = 35
WHERE employee_id = 1013
  AND age IS NULL;

-- Fill in age and gender for Holly Flax (ID 1010)
UPDATE employee_demographics
SET age    = 32,
    gender = 'Female'
WHERE employee_id = 1010
  AND (age IS NULL OR gender IS NULL);
