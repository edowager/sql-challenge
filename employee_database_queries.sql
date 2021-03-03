-- Database: SQL Employee Database

-- DROP DATABASE "SQL Employee Database";

CREATE DATABASE "SQL Employee Database"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
CREATE TABLE departments (
	dept_no VARCHAR(10) PRIMARY KEY,
	dept_name CHAR(20) NOT NULL

);	

CREATE TABLE department_employee (
	emp_no INT,
	dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employee(emp_no)


);	

CREATE TABLE department_manager (
	dept_no VARCHAR(10) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employee(emp_no)


);	

CREATE TABLE employee (
	emp_no INT PRIMARY KEY,
	title_id VARCHAR(20),
	bday DATE,
	first_name CHAR(20),
	last_name CHAR(20),
	sex CHAR,
	hire_date DATE,
	FOREIGN KEY (title_id) REFERENCES titles(title_id)


);	

CREATE TABLE titles (
	title_id VARCHAR(10) PRIMARY KEY,
	title CHAR(20)

);	


CREATE TABLE salaries (
	emp_no INT ,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employee(emp_no)


);	


-- test import

SELECT * FROM department_manager;


-- List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT (employee.emp_no, last_name, first_name, sex, salaries.salary)
FROM employee 
LEFT JOIN salaries 
ON employee.emp_no =
salaries.emp_no

-- List first name, last name, and hire date for employees who were hired in 1986.


SELECT (first_name, last_name, hire_date)
FROM employee 
WHERE hire_date BETWEEN '1/01/1986' AND '12/31/1986'


-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT (department_manager.dept_no, departments.dept_name, department_manager.emp_no, employee.last_name, employee.first_name)
FROM department_manager
JOIN departments ON (departments.dept_no = department_manager.dept_no)
JOIN employee ON (employee.emp_no = department_manager.emp_no)

-- List the department of each employee with the following information: employee number, last name, first name, and department name.


SELECT (employee.emp_no, last_name, first_name, departments.dept_name)
FROM department_employee
JOIN departments ON (departments.dept_no = department_employee.dept_no)
JOIN employee ON (employee.emp_no = department_employee.emp_no)

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT (first_name, last_name, sex)
FROM employee 
WHERE first_name = 'Hercules'
AND last_name 
LIKE 'B%'

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT department_employee.emp_no, employee.last_name, employee.first_name, departments.dept_name
FROM department_employee,
       employee,
       departments
WHERE employee.emp_no = department_employee.emp_no 
AND departments.dept_no = department_employee.dept_no
AND dept_name = 'Sales'

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
--  DOES NOT EXECUTE:

SELECT department_employee.emp_no, employee.last_name, employee.first_name, departments.dept_name
FROM department_employee,
       employee,
       departments
WHERE employee.emp_no = department_employee.emp_no 
AND departments.dept_no = department_employee.dept_no
AND dept_name = 'Sales' 
OR dept_name = 'Development'


-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.


SELECT last_name, COUNT(last_name)
AS Frequency
FROM employee
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC