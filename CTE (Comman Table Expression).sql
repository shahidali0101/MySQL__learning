/*
A comman table Expression ( CTE ) in SQL ia a temporary resut set that you can reference within a 
select, Insert, Update or Delete statement. cte is defined using "WITH" keyword
they can make complex queries easier to write, and breaking them into simpler parts.
*/

select * from Employees

select * into #temp1 from Employees -- creating a temporary Table

select * from #temp1


-- Example : Cte 

with cte as (
select * from #temp1)

select * from cte

-- Example ... -- insert in new table

with [common table expression] as 
(select * from #temp1 where EmployeeID in (1,2,3)
)
select * into #temp2 from [common table expression]

select * from #temp2

-- Example .... update

with cte1 as (
select * from #temp1 where EmployeeID in (2,4,6)
)
update #temp1 set employeeid=101 where employeeid 
in (select distinct employeeid from cte1)

select * from #temp1


-- Example ... Delete

with cte2 as (
select * from #temp1 where EmployeeID=1
)
delete from #temp1 where EmployeeID in 
  (select distinct EmployeeID from cte2)

select * from #temp1