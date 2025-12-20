use practicsql;

-- Find the products that have a price higher than the average of all products
select
*
from(
	select
	ProductID,
	Price,
	avg(Price) over() as Avgprice
	from products
    )as t
where price > Avgprice;

-- Rank Customers based on their total amount of sales
select
CustomerID,
Totalsales,
rank() over(order by Totalsales desc) as Ranks
from
(
	select
	CustomerID,
	sum(Quantity * Sales) as Totalsales
	from orders
    group by CustomerID
)as t
order by Ranks;

-- OR

-- Rank Customers based on their total amount of sales
select
*,
rank() over(order by Totalsales desc) as CustomerRank
from(
	select
	CustomerID,
	Sum(Sales) as Totalsales
	from orders
	group by CustomerID) as t;
    
 -- Show the OrderID, CustomerID, ProductID and total number of products;   
select
OrderID,
CustomerID,
ProductID,
(select count(*) from products) as Totalproducts
from orders;

-- Show all customer details and find the total orders of each customer
select 
* 
from customers as c
left join(
	select 
	CustomerID,
	count(*) as TotalOrders
	from orders
	group by CustomerID) as o
on c.CustomerID = o.CustomerID;

-- Find the products that have a price higher than the average price of all products
select
*
from products
where price > (select avg(price) from products) ;

-- Show the details of orders made by customer from USA

select
*
from orders
where CustomerID in (select 
CustomerID
from customers
where Country = 'Germany') ;

-- Show the details of orders made by customer not from  USA

select
*
from orders
where CustomerID not in (select 
CustomerID
from customers
where Country = 'USA') ;

-- Find the Female employees whose salary are greater than salary of amy Male employees

select 
EmployeeID,
FirstName,
Salary
from employees
where Gender ='F' and Salary > any (select Salary from employees where Gender='M');


			-- CORELATED and NONCORELATERD SUBQUERY

-- Show the details of orders made by customer from USA using corelated subquery
select 
* 
from orders as o
where exists(select 
			*
			from customers as c
			where Country = 'USA' 
            and o.CustomerID = c.CustomerID);

-- Show the details of orders made by customer not from USA using corelated subquery
select 
* 
from orders as o
where not exists(select 
			*
			from customers as c
			where Country = 'USA' 
            and o.CustomerID = c.CustomerID);
            
-- Show all customer details and find the total orders of each customer using non corelated subquery
select 
* ,
(select count(*) from orders as o  where o.CustomerID = c.CustomerID)as Totalorders
from customers as c;
