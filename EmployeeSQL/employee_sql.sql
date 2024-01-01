-- Create 6 tables for csv files, then import data

CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE
	);
	
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
	);

CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);


CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no INT,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);


CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);


CREATE TABLE titles (
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR);

ALTER TABLE employees
ADD FOREIGN KEY (emp_title_id) REFERENCES titles(title_id);

--Test table creation
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM titles;
SELECT * FROM departments;

--CSV FILES HAVE ALL BEEN IMPORTED AND TABLES CHECKED--
-- DON'T RUN ANYTHING ABOVE THIS --

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, 
	employees.last_name, 
	employees.first_name, 
	employees.sex,
	salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
-- EVERYTHING ABOVE IS WORKING; for this question wait for next class
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN
	(SELECT emp_no, dept_no
	FROM dept_manager
	WHERE dept_no IN
		(SELECT dept_no, dept_name
		FROM departments));

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.


-- List each employee in the Sales department, including their employee number, last name, and first name.


-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.


-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).