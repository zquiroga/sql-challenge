--create titles table
DROP TABLE IF EXISTS titles CASCADE;
CREATE TABLE titles(
	title_id VARCHAR(5)  NOT NULL,
	title VARCHAR(100) NOT NULL,
	PRIMARY KEY (title_id)
);

-- create employees table
DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR (5)NOT NULL,
    birth_date VARCHAR (50) NOT NULL,
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50)NOT NULL,
    sex VARCHAR (1)NOT NULL,
    hire_date VARCHAR (50) NOT NULL,
    	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    	PRIMARY KEY (emp_no)
);

ALTER TABLE employees ALTER COLUMN birth_date TYPE DATE
USING to_date ( birth_date, 'MM-DD-YYY');

ALTER TABLE employees ALTER COLUMN hire_date TYPE DATE
USING to_date ( hire_date, 'MM-DD-YYY');

-- create departments table
DROP TABLE IF EXISTS departments CASCADE;
CREATE TABLE departments(
	dept_no VARCHAR (10) NOT NULL,
	dept_name VARCHAR (100)NOT NULL,
		PRIMARY KEY (dept_no)

);

-- create department manager table
DROP TABLE IF EXISTS dept_manager CASCADE;
CREATE TABLE dept_manager(
	dept_no VARCHAR (10) NOT NULL,
	emp_no INT NOT NULL,
		FOREIGN KEY (emp_no)REFERENCES employees(emp_no),
		FOREIGN KEY (dept_no)REFERENCES departments (dept_no),
		PRIMARY KEY (emp_no,dept_no)
);

-- create departments employees table
DROP TABLE IF EXISTS dept_emp CASCADE;
CREATE TABLE dept_emp(
    emp_no INT,
	dept_no VARCHAR (10) NOT NULL,
		FOREIGN KEY (emp_no)REFERENCES employees (emp_no),
		FOREIGN KEY (dept_no)REFERENCES departments (dept_no),
		PRIMARY KEY (emp_no,dept_no)

);


-- create salaries table
DROP TABLE IF EXISTS salaries CASCADE;
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		PRIMARY KEY (emp_no)
);


SELECT * 
FROM departments;
SELECT * 
FROM employees;
SELECT * 
FROM dept_manager;
SELECT * 
FROM departments;



--List the employee number, last name, first name, sex, and salary of each employee
SELECT emp.emp_no as employee_number, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees as emp
LEFT JOIN salaries as sal
ON emp.emp_no = sal.emp_no
ORDER BY emp.emp_no;

-- List the first name, last name, and hire date for the employees 
-- who were hired in 1986
SELECT first_name,last_name,hire_date
FROM employees 
WHERE hire_date BETWEEN '01/01/1986'AND '31/12/1986';

--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name
SELECT dep.dept_no, dep.dept_name, dman.emp_no, emp.last_name, emp.first_name
FROM departments dep 
JOIN dept_manager dman ON (dep.dept_no = dman.dept_no)
JOIN employees emp ON (dman.emp_no = emp.emp_no);

--List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name
SELECT emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
FROM employees emp 
JOIN dept_emp de ON (emp.emp_no = de.emp_no)
JOIN departments dep  ON (de.dept_no = dep.dept_no);

--List first name, last name, and sex of each employee whose 
--first name is Hercules and whose last name begins with the letter B 

SELECT first_name,last_name,sex
FROM employees 
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';


-- List each employee in the Sales department, including their employee number,
--last name, and first name

SELECT emp.emp_no, emp.last_name, emp.first_name
FROM employees emp 
JOIN dept_emp de ON (emp.emp_no = de.emp_no)
JOIN departments dep  ON (de.dept_no = dep.dept_no)
WHERE dep.dept_name = 'Sales';



-- List each employee in the Sales and Development departments, including their employee number,
--last name, first name, and department name 

SELECT emp.emp_no, emp.last_name, emp.first_name,dep.dept_name
FROM employees emp 
JOIN dept_emp de ON (emp.emp_no = de.emp_no)
JOIN departments dep  ON (de.dept_no = dep.dept_no)
WHERE dep.dept_name = 'Sales'
OR dep.dept_name = 'Development';


--List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name)

SELECT count(last_name) as frequency, last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;


