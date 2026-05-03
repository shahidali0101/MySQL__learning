
select * from Customers

select *from Orders

select * from Products


-- 1. Identfy pairs of customers who live in the same country.

select x.CustomerName,y.CustomerName
from Customers x join Customers y on x.Country=y.Country 
                               and x.CustomerID<>y.CustomerID
                             and x.CustomerID>y.CustomerID

-- 2. find the customer who spent the most on their orders.

select customername,[Amount spent] from (
select CustomerName,sum(price) [Amount spent], dense_rank() over 
(order by sum(Price) desc ) [Dr]
from Customers c inner join Orders o 
            on c.CustomerID=o.CustomerID
            inner join Products p on
            o.ProductID=p.ProductID
group by CustomerName ) m where Dr=1;

-- 3. Find customers who have ordered more than type of products

select customerName ,count(productId) from Customers c 
join Orders o on c.CustomerID=o.CustomerID
group by CustomerName having count(ProductID)>1
 

-- 4. List all the products and their correspondig orders,using a RIGHT join ,
-- including products that have never been order.

select OrderDate,p.ProductID,productname from Orders o right join Products p on o.productid=p.ProductID


-- 5. Retrive all orders placed by customers from the USA.


select OrderID from Customers c inner join Orders o on c.CustomerID=o.customerId where Country in ('USA')


-- 6. find the names of customers who have ordered a product above 500.

select distinct CustomerName from Customers c inner join Orders o on o.CustomerID=c.CustomerID inner join Products p
                        on p.ProductID=o.ProductID where price >500

-- 7. Find customers who have ordered the same product more than once .
  
select distinct m.customername from
                  (select customername,Productid ,count(orderid)[count] from 
                             Customers c inner join orders o  on c.customerid= o.customerid
    group by customername ,productid
      having count(orderId)>1 ) m
