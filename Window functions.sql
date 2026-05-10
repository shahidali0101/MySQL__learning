
create database windowss

use windowss



CREATE TABLE Students (
    student_name VARCHAR(100),
    subject VARCHAR(100),
    marks INT
);


INSERT INTO Students (student_name, subject, marks)
VALUES 
-- Marks for Alice
('Alice', 'Math', 85),
('Alice', 'Science', 88),
('Alice', 'English', 92),

-- Marks for Bob
('Bob', 'Math', 90),
('Bob', 'Science', 78),
('Bob', 'English', 85),

-- Marks for Charlie
('Charlie', 'Math', 85),
('Charlie', 'Science', 82),
('Charlie', 'English', 80),

-- Marks for David
('David', 'Math', 92),
('David', 'Science', 91),
('David', 'English', 89),

-- Marks for Eve
('Eve', 'Math', 90),
('Eve', 'Science', 85),
('Eve', 'English', 87),

-- Marks for Frank
('Frank', 'Math', 75),
('Frank', 'Science', 72),
('Frank', 'English', 78),

-- Marks for Grace
('Grace', 'Math', 85),
('Grace', 'Science', 89),
('Grace', 'English', 90);


select * from Students

-- Row_number() Assign a unique subsequential number to each row 
-- even if values are same ,number will be Different ..

select * ,ROW_NUMBER() over(order by marks desc) 
                                [Row_number] from Students

-- Rank() -> Give the same rank to tied values ,skip the next rank(s) after a tie.

select * ,Rank() over(order by marks desc) 
                                [Ranking] from Students

-- Dense_rank() - Give the same rank to tied values, but do not skip the rank

select * ,dense_Rank() over(order by marks desc) 
                                [Ranking] from Students

-- ---------------------------------------------------------------------------------------

select * , ROW_NUMBER() over( partition by subject order by marks desc)
   [row number]  from Students

select * , ROW_NUMBER() over( partition by subject order by marks asc)
   [row number]  from Students


select * , ROW_NUMBER() over( partition by student_name order by marks )
   [row number]  from Students


select * , Rank() over( partition by student_name order by marks desc)
   [Ramk]  from Students



-- ________________________LEAD / LAG____________________________________
-- They are especially useful for coparing values accross row  ( previous or next)

-- lEAD() -> (look a head) fatches value from next Row .
-- LAG()  -> (look Back) Fatches the value from previous Row.

-- Create a table to store monthly profit data for different products
CREATE  TABLE ProfitData (
    MonthNumber INT,
    MonthName VARCHAR(3),
    Product VARCHAR(50),
    Profit INT
);

-- Insert data into the ProfitData table
INSERT INTO ProfitData (MonthNumber, MonthName, Product, Profit) VALUES
(1, 'Jan', 'Product A', 1000),
(2, 'Feb', 'Product A', 1500),
(3, 'Mar', 'Product A', 1200),
(4, 'Apr', 'Product A', 1700),
(5, 'May', 'Product A', 1300),
(6, 'Jun', 'Product A', 1600),
(1, 'Jan', 'Product B', 2000),
(2, 'Feb', 'Product B', 2500),
(3, 'Mar', 'Product B', 2200),
(4, 'Apr', 'Product B', 2700),
(5, 'May', 'Product B', 2300),
(6, 'Jun', 'Product B', 2600);


select * from ProfitData

-- to add new column that show next month's profit for each product 

select * ,lead(profit) over (partition by product order by monthnumber ) [Next month profit]
from ProfitData


-- we dont want product column in output but we want each months total ptofit
-- to be show by monthnumber & monthname also a new column should be added to show next months total profit.

select monthnumber ,monthname,sum(profit) [total proft],
      lead(sum(profit)) over (order by monthnumber asc) [Next month's total profit]
from ProfitData group by 
monthnumber,monthname
order by Monthnumber

-- **LAG***

select * ,lag(profit) over (partition by product order by monthnumber ) [last month profit]
from ProfitData


-- we dont want product column in output but we want each months total ptofit
-- to be show by monthnumber & monthname also a new column should be added to show last months total profit.

select monthnumber ,monthname,sum(profit) [total proft],
      lag(sum(profit)) over (order by monthnumber asc) [Next month's total profit]
from ProfitData group by 
monthnumber,monthname
order by Monthnumber

-- _____________________________________________________________________________________________

CREATE TABLE EmployeeSalaries (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Salary INT,
    Department VARCHAR(50)
);


INSERT INTO EmployeeSalaries (EmployeeID, EmployeeName, Salary, Department)
VALUES
(1, 'Alice', 50000, 'HR'),
(2, 'Bob', 60000, 'HR'),
(3, 'Charlie', 55000, 'HR'),
(4, 'David', 75000, 'Finance'),
(5, 'Eve', 80000, 'Finance'),
(6, 'Frank', 72000, 'Finance'),
(7, 'Grace', 90000, 'IT'),
(8, 'Heidi', 95000, 'IT'),
(9, 'Ivan', 87000, 'IT');


select * from EmployeeSalaries

select * ,
 FIRST_VALUE(salary) over (order by salary asc) [Minimum]
  from EmployeeSalaries


select * ,
 FIRST_VALUE(EmployeeName) over (order by salary asc) [Minimum]
  from EmployeeSalaries



select * ,
 FIRST_VALUE(EmployeeName) over (order by salary asc) [Emp Minimum]
 , FIRST_VALUE(Salary) over (order by salary asc) [Minimum salary]
  from EmployeeSalaries

-- Last_value()


-- incorrect Query
select * ,
 lAST_VALUE(EmployeeName) over (order by salary desc) [employee with lowest salary]
  from EmployeeSalaries

-- correct Query

select * ,
 lAST_VALUE(EmployeeName) over (order by salary desc rows between unbounded preceding and unbounded following) 
 [employee with lowest salary]
  from EmployeeSalaries

