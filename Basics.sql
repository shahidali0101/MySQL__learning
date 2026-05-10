

use Employees

select * from Employees

insert into Employees (EmployeeID,FirstName,Lastname) values (6,'Rohit','Mehra')
insert into Employees values (7,'Rohan','sing','',90000,'2022-03-21')
insert into Employees values (8,'Ankur','Pal','',78000,'2022-04-22')
EXEC sp_help 'Employees' 

-- find out records where department is null.

select * from Employees where Department is not null

select * from Employees where Department is  null


-- creating temporary table 
-- * copies all data from emp
-- * Must start with #
-- * it is for a session 


select * into #temp from Employees



select * from #temp

-- Updating

update  #temp set Department='HR' where Department is null

update #temp set Salary=65000,HireDate='2022-04-21' where EmployeeID=7

update #temp set Salary=66000,HireDate='2022-05-20' where EmployeeID=6


-- Top 3 highest salary 

select * from (select *, rank() over (order by salary desc ) as rank1
from #temp) t where rank1 in(1,2,3)

select * from #temp



--  -------------------------TOP-----------------------------------------------

select top 2 * from #temp 

select top 4 employeeId,salary,department from #temp

--   ______________________________________________________________

-- Creating a table with more columns, including a varchar column
CREATE TABLE dbo.Sales (
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    CustomerID INT,
    StoreID INT,
    SalespersonID INT,
    PaymentMethod VARCHAR(50));

    -- New varchar column for payment method

-- Inserting more sample data (10 records), including NULL values
INSERT INTO dbo.Sales (ProductID, SaleDate, Quantity, TotalAmount, CustomerID, StoreID, SalespersonID, PaymentMethod)
VALUES 
(1, '2023-08-01', 10, 200.00, 101, 1, 201, 'Credit Card'),
(2, '2023-08-01', 5, 150.00, 102, 1, 202, 'Cash'),
(1, '2023-08-02', 8, 160.00, 103, 2, 203, 'Credit Card'),
(2, '2023-08-02', 7, 210.00, 104, 2, 204, 'Cash'),
(1, '2023-08-03', 6, 120.00, 105, 1, 201, NULL),              -- NULL value in PaymentMethod
(3, '2023-08-04', 12, 300.00, 106, 3, 205, 'Credit Card'),
(1, '2023-08-04', 5, 100.00, 107, 3, 206, 'Debit Card'),
(2, '2023-08-05', 9, 270.00, 108, 1, 202, NULL),              -- NULL value in PaymentMethod
(3, '2023-08-05', 15, 375.00, 109, 3, 207, 'Cash'),
(1, '2023-08-06', 7, 140.00, 110, 2, 203, 'Credit Card');



select * from Sales


select max(totalamount)  [total] from Sales

select max(Quantity) as  max_qauantatity from Sales


-- ------------------------------- UNION / UNION All-----------------------------------------

create table append1 (C1 int,C2 nvarchar(255),C3 int)
insert into append1 values (1,'A',7),
(2,'B',8),
(3,'C',9)



-- * Numbers of columns in select list have to be same
-- * Data types of the columns have to be same
-- * Oreder in which columns are written has to be same



create table append2 (C1 int,C2 nvarchar(255),C3 int)
insert into append2 values (11,'AA',17),
(2,'B',8),
(33,'C1',91)


select * from append1
union all
select * from append2


select * from append1
union
select * from append2

-- _______________________________________________________________________

-- Create Employees_us table
CREATE TABLE Employees_US (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert sample data into Employees table
INSERT INTO Employees_us (EmployeeID, FirstName, LastName, Department) VALUES
(1, 'Alice', 'Smith', 'Finance'),
(2, 'Bob', 'Johnson', 'Engineering'),
(3, 'Charlie', 'Williams', 'Marketing'),
(4, 'Diana', 'Brown', 'Finance'),
(5, 'Edward', 'Jones', 'Engineering'),
(6, 'Fiona', 'Garcia', 'Marketing'),
(7, 'George', 'Miller', 'Finance'),
(8, 'Hannah', 'Wilson', 'Engineering');



select * from Employees_US;





--1) Find Employees whose Last Name starts with 'S'.
select * from employees_us where lastname like 's%'

--2) Find Employees whose First Name ends with 'a'.
select * from employees_us where firstname like '%a'

--3) Find Employees whose Department contains 'Eng'.
select * from employees_us where department like '%eng%'

--4) Find Employees whose Last Name is exactly 5 characters long.
select * from employees_us where lastname like '_____'

--5) Find Employees whose First Name starts with 'C' or 'D'.
select * from employees_us where firstname like '[CD]%' 

--6) Find Employees whose Last Name contains 'son'.
select * from employees_us where lastname like '%son%'

--7) Find Employees whose First Name contains the letter 'i' as the second character.
select * from employees_us where firstname like '_i%'

--8) Find Employees whose Last Name starts with any letter between 'A' and 'L'.
select * from employees_us where lastname like '[a-l]%'

--9) Find Employees whose First Name does not contain 'o'.
select * from employees_us where firstname not like '%o%'

--10) Find Employees whose Last Name ends with 'a' and is exactly 5 characters long.
select * from employees_us where lastname like '____a'

select * from employees_us

--11) Find Employees whose Department starts with 'Mar' and ends with 'ing'.
select * from employees_us where department like 'mar%ing'

--12) Find Employees whose First Name has an 'a' in the third position.
select * from employees_us where firstname like '__a%'

--13) Find Employees whose Last Name starts with 'Br' or 'Bl'.
select * from employees_us where lastname like 'br%' or lastname like 'bl%'

--14) Find Employees whose First Name starts with a vowel.
select * from employees_us where firstname like '[aeiou]%'

--15) Find Employees whose First Name does not start with a consonant.
select * from employees_us where firstname not like '[^aeiou]%'

--16) Find Employees whose First Name starts with a consonant.
select * from employees_us where firstname like '[^aeiou]%'


-- ________________________________________________________________________________________

create database sale

use sale


-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(20),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    Supplier VARCHAR(50),
    Rating DECIMAL(3, 1)
);

-- Insert data into the Products table
INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity, Supplier, Rating) VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99, 150, 'Tech Supplies', 4.5),
(2, 'Office Chair', 'Furniture', 120.00, 85, 'Comfort Co', 4.7),
(3, 'Water Bottle', 'Accessories', 15.00, 250, 'AquaGear', 4.3),
(4, 'Laptop Backpack', 'Accessories', 45.99, 200, 'GearUp', 4.6),
(5, 'Gaming Laptop', 'Electronics', 999.99, 45, 'Tech Supplies', 4.8),
(6, 'Desk Lamp', 'Furniture', 35.00, 120, 'LightHouse', 4.2),
(7, 'Bluetooth Speaker', 'Electronics', 59.99, 95, 'SoundWave', 4.4),
(8, 'Standing Desk', 'Furniture', 250.00, 50, 'Comfort Co', 4.9),
(9, 'Fitness Tracker', 'Electronics', 129.99, 180, 'FitTech', 4.7),
(10, 'Coffee Mug', 'Accessories', 9.99, 300, 'MugMasters', 4.1);


select * from Products

--Example1 : Add a column to categorize each product into categories high, medium & low

select 
*,
case
	when Price > 500 then 'High' 
	when Price<=500 and Price>=200 then 'Medium'
	else 'Low'
end as [Status]
from products




--Example2 : Provide priority to each category & sort the data according to that priority


select * from Products
order by 
case 
	when Category in ('Electronics') then 1
	when Category in ('Furniture') then 2
	else 3
end


select * from Products
--We need to group the data based on columns category & price into different categories i.e affordable & premium
select 
*,
case 
	when Category = 'Electronics' then
		case when Price>=300 then 'Premium Electronics'
		else 'Affordable Electronics'
		end 
	when Category = 'Furniture' then
		case when Price>=250 then 'Premium Furniture'
		else 'Affordable Furniture'
		end 
else 
		case when Price>=25 then 'Premium Accessories'
		else 'Affordable Accessories'
		end
end as [Groups]
from products


-- _______________________________________________________
-- Copying Data one table to other
-- -------------------------------------------------
-- case-1 : The New table simply does'nt exist .
-- case-2 : The New table structure/new Table exists.


use Employees

select * from Sales

select * into sales2 from sales

select * from sales2

drop table sales2
-- --------------------------------
select productID,saledate,PaymentMethod, totalamount into sales2 from Sales

select * from sales2


-- Create Table structure table already exist ;

select top 0 * into sales3 from sales2 where 1=0

select * from sales3

insert into sales3 (ProductID,SaleDate,PaymentMethod,TotalAmount) 
select ProductId,Saledate,PaymentMethod,TotalAmount from sales2

--  __________________________________________________________________

-- ------------------------'SUB Query'____________________________________


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);



CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);



-- Insert data into Customers table
INSERT INTO Customers (customer_id, customer_name, email)
VALUES 
(1, 'Alice Smith', 'alice@example.com'),
(2, 'Bob Johnson', 'bob@example.com'),
(3, 'Charlie Brown', 'charlie@example.com');

-- Insert data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES 
(101, 1, '2024-07-15', 250.00),
(102, 1, '2024-08-05', 300.00),
(103, 2, '2024-08-10', 150.00),
(104, 3, '2024-06-25', 100.00);

select * from Orders
select * from Customers

-- orders in march

select * from customers where customer_id in
(select distinct customer_id from Orders where 
           order_date between '2024-08-01' and '2024-08-31')


-- Fetch the data from employees table where salary > average salary
select * from Employees

select AVG(salary) from employees


select * from Employees where Salary > (
                                select AVG(Salary) from employees )

-- _________________________________CONSTAINT_____________________________



