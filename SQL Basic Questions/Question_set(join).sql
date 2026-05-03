

create database [SQL Questions]



-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Country VARCHAR(50)
);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES 
(1, 'Alice', 'USA'),
(2, 'Bob', 'UK'),
(3, 'Charlie', 'Canada'),
(4, 'David', 'USA'),
(5, 'Eve', 'Australia');

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductID)
VALUES 
(101, 1, '2024-08-01', 1001),
(102, 1, '2024-08-03', 1002),
(103, 2, '2024-08-04', 1001),
(104, 3, '2024-08-05', 1003),
(105, 5, '2024-08-06', 1004);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1001, 'Laptop', 1000),
(1002, 'Smartphone', 700),
(1003, 'Tablet', 500),
(1004, 'Headphones', 200),
(1005, 'Smartwatch', 300);

select * from Customers
select * from Orders
select * from Products


--1) Write an SQL query to find the names of customers who have placed an order.



select c.customername from Customers c join 
                           Orders o on c.CustomerID=o.CustomerID

--2) Find the list of customers who have not placed any orders.

select c.customername from Customers c left join Orders o on c.CustomerID=o.CustomerID
where OrderDate is null


--3) List all orders along with the product name and price.
select o.orderid,p.ProductName,p.price from Orders o join Products p 
                      on o.ProductID=p.ProductID 


--4) Find the names of customers and their orders, including customers who haven't placed any orders.

select distinct c.customername,o.orderid from Customers c left join Orders o 
on o.CustomerID=o.CustomerID


--5) Retrieve a list of products that have never been ordered.


select p.productname,p.ProductID from Products p left join Orders o on
                   p.ProductID=o.ProductID
                   where o.OrderDate is null

--6) Find the total number of orders placed by each customer.

select c.customername ,count(o.orderid)[No of Orders] from Customers c join 
                           Orders o on c.CustomerID=o.CustomerID group by c.CustomerName


-- or 

select c.customername ,count(o.orderid) [No of Orders]  from Customers c left join 
                           Orders o on c.CustomerID=o.CustomerID 
                     group by c.CustomerName

--7) Display the customers, the products they've ordered, 
-- and the order date. Include customers who haven't placed any orders.

select c.customername,p.productname,o.OrderDate from Customers c left join 
                           Orders o on c.CustomerID=o.CustomerID 
                     left join Products p on
                   p.ProductID=o.ProductID
                  

