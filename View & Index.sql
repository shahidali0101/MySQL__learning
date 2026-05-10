
/*               *- VIEW -*     

A view is a virtual table created bt select Query . 
it does not store data itself.
* Does not store data  (store Only Query)
* Permanent save untill you drop.
* used for security and simplification.
* A view is a saved Query that act like a virtual table..
* A normal SQL view does not physically store table data and 
       therefore does not take meaningful database space.

*/


select * from Employees


create view emp_view as
  (select firstname,DepartmentID,salary from Employees where Salary>75000)


select * from emp_view

drop view emp_view  -- drop view




-- _________________________________________________________________________________________


/*                    *-   INDEX  -*

Index are Database object , Index improve Query Performance bt allowing
 tha databse  to quickly locate Rows insted of scanning the entire Table

*/

select * from Employees

create index index_1 on employees (salary desc)

create index Index_2 on employees (firstname,lastname)


-- Drop indexes 

drop index employees.index_1

drop index employees.index_2

