


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


