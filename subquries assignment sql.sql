create database Employee_dataset;
use employee_dataset;
create table employee (
emp_id varchar(10),
name char(10),
department_id varchar(50),
salary int );

SELECT *FROM employee;

INSERT INTO employee
VALUE (101,'Abhishek','D01',62000),
(102,'Shubham','D01',58000),
(103,'Priya','D02',67000),
(104,'Rohit','D02',64000),
(105,'Neha','D03',72000),
(106,'Aman','D03',55000),
(107,'Ravi','D04',60000),
(108,'Sneha','D04',75000),
(109,'Kiran','D05',70000),
(110,'Tanuja','D05',65000);

create table department (
department_id varchar(50),
department_name char(20),
location char(20) );

INSERT INTO department 
VALUE ('D01','Sales','Mumbai'),
('D02','Marketing','Delhi'),
('D03','Finance','Pune'),
('D04','HR','Bengaluru'),
('D05','IT','Hyderabad');

CREATE TABLE sales (
sale_id int ,
emp_id int,
sale_amount int,
sale_date date);

INSERT INTO sales 
VALUE(201,101,4500,'2025-01-05'),
(202,102,7800,'2025-01-10'),
(203,103,6700,'2025-01-14'),
(204,104,12000,'2025-01-20'),
(205,105,9800,'2025-02-02'),
(206,106,10500,'2025-02-05'),
(207,107,3200,'2025-02-09'),
(208,109,5100,'2025-02-15'),
(209,109,3900,'2025-02-20'),
(210,110,7200,'2025-03-01');

## Q1-Retrieve the names of employees who earn more than the average salary of all employees.
USE employee_dataset;
SELECT name
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);

## Q2-Find the employees who belong to the department with the highest average salary.
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

## Q3-List all employees who have made at least one sale.
SELECT name
FROM Employee
WHERE emp_id IN 
(SELECT distinct emp_id 
FROM sales); 

## Q4-Find the employee with the highest sale amount.
SELECT name
FROM Employee
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount = (
        SELECT MAX(sale_amount)
        FROM Sales
    )
);

##Q5.Retrieve the names of employees whose salaries are higher than Shubham’s salary.
SELECT name
FROM Employee
WHERE salary > (
    SELECT salary
    FROM Employee
    WHERE name = 'Shubham'
);

## Intermediate Level

##Q1.Find employees who work in the same department as Abhishek.
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'Abhishek'
);

##Q2-List departments that have at least one employee earning more than ₹60,000.
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT department_id
    FROM Employee
    WHERE salary > 60000
);

##Q3-Find the department name of the employee who made the highest sale.
SELECT department_name
FROM Department
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE emp_id = (
        SELECT emp_id
        FROM Sales
        WHERE sale_amount = (
            SELECT MAX(sale_amount)
            FROM Sales
        )
    )
);

## Q4-Retrieve employees who have made sales greater than the average sale amount.
SELECT name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount > (
        SELECT AVG(sale_amount)
        FROM Sales
    )
);

## Q5-Find the total sales made by employees who earn more than the average salary.
SELECT SUM(sale_amount) AS total_sales
FROM Sales
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee
    WHERE salary > (
        SELECT AVG(salary)
        FROM Employee
    )
);

## Advanced Level

## Q1-Find employees who have not made any sales.
SELECT name
FROM Employee
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Sales
);

## Q2-List departments where the average salary is above ₹55,000.
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

## Q3-Retrieve department names where the total sales exceed ₹10,000.
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT department_id
    FROM Employee
    WHERE emp_id IN (
        SELECT emp_id
        FROM Sales
        GROUP BY emp_id
        HAVING SUM(sale_amount) > 10000
    )
);

## Q4-Find the employee who has made the second-highest sale.
SELECT name
FROM Employee
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount = (
        SELECT MAX(sale_amount)
        FROM Sales
        WHERE sale_amount < (
            SELECT MAX(sale_amount)
            FROM Sales
        )
    )
);

## Q5-Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
SELECT name
FROM Employee
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM Sales
);