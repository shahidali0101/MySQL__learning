
create database [advDatabase]

use [advDatabase]

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary)
VALUES
(1, 'Alice Smith', 70000.00),
(2, 'Bob Johnson', 85000.00),
(3, 'Carol White', 95000.00),
(4, 'David Brown', 60000.00),
(5, 'Eve Davis', 75000.00),
(6, 'Frank Miller', 90000.00),
(7, 'Grace Lee', 80000.00),
(8, 'Hannah Clark', 62000.00),
(9, 'Ivy Harris', 74000.00),
(10, 'Jack Lewis', 98000.00);

select * from Employees


-- 2nd Highest Salary--------------------------------------

select max(salary) as second_Highst from Employees where salary <
               (select max(salary) as second_Highst from Employees)


-- 3rd Highset Salary ----------------------------------------


select max(salary) as Third_Highst from Employees where salary <(
select max(salary)  from Employees where salary <
               (select max(salary) from Employees))


-- With window ----------------------------------------------------------

-- 2nd highest
select salary from (
select * , DENSE_RANK() over (order by salary desc) as rnk
from Employees ) r where rnk=2;


-- with CTE     ---------------------------------------------------------

-- 2nd highest

with cte as (
  select * , DENSE_RANK() over (order by salary desc) as rnk
from Employees )

select salary from cte where rnk = 2;

-- 4th highest 

with cte as (
  select * , DENSE_RANK() over (order by salary desc) as rnk
from Employees )

select salary  [4th Highest] from cte where rnk = 4;


-- 2nd Lowest salary

with cte as (
  select * , DENSE_RANK() over (order by salary asc) as rnk
from Employees )

select salary [2nd lowest] from cte where rnk = 2;



-- 6th Highset salary

with cte as (
  select * , DENSE_RANK() over (order by salary asc) as rnk
from Employees )

select salary [6th highest] from cte where rnk = 6;




-- 2nd Highest by sub_Query

select top 1 salary [2nd HighSalary] from (
        select distinct top 2 salary from Employees
        order by salary desc) n
  order by Salary asc 
                                        


-- _____________________________________________________________________________________

/*  Create a function to find nth highrst salary */

-- it will work in Mysql 

DELIMITER //

CREATE FUNCTION nthHighest(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN (
        SELECT salary
        FROM (
            SELECT salary,
                   DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
            FROM Employees
        ) r
        WHERE rnk = n
        LIMIT 1
    );
END //

DELIMITER ;

