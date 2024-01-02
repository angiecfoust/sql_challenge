-- Create 6 tables for csv files, then import data

CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(30),
	birth_date DATE,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(1),
	hire_date DATE
	);
	
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR
	);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);


CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);


CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);


CREATE TABLE titles (
	title_id VARCHAR(30) PRIMARY KEY NOT NULL,
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
SELECT employees.emp_no, employees.first_name, employees.last_name,
	dept_manager.dept_no, 
	departments.dept_name
FROM employees
INNER JOIN dept_manager on employees.emp_no = dept_manager.emp_no
INNER JOIN departments on dept_manager.dept_no = departments.dept_no;


-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp on employees.emp_no = dept_emp.emp_no
INNER JOIN departments on dept_emp.dept_no = departments.dept_no; 


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN
	(SELECT emp_no FROM dept_emp
	WHERE dept_no IN
		(SELECT dept_no FROM departments
		WHERE dept_name = 'Sales'));


-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp on employees.emp_no = dept_emp.emp_no
INNER JOIN departments on dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';


-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(employees.last_name) AS "Count"
FROM employees
GROUP BY last_name
ORDER BY "Count" DESC;