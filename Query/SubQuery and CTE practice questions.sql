use practicsql;

/* ============================================================
				SUBQUERY PRACTICE QUESTIONS
   ============================================================ */

-- 1. Find customers whose CustomerID exists in the Orders table.
select
*
from customers
where CustomerID in(select CustomerID from orders);

-- 2. Find customers who have at least one order using a subquery.
select
CustomerID,
FirstName,
LastName
from customers
where CustomerID in(select CustomerID from orders);

-- 3. Find customers who have no orders using NOT IN or NOT EXISTS.
select
CustomerID,
FirstName,
LastName
from customers
where CustomerID not in(select CustomerID from orders);

-- 4. Find orders where CustomerID exists in the Customers table.
select *
from orders o
where exists (
    select 1
    from customers c
    where c.CustomerID = o.CustomerID
);

-- 5. Find orders whose OrderID is greater than the average OrderID.
select
OrderID
from orders
where OrderID >
	(select
	avg(OrderID) as AVGs
	from orders);


-- 6. Find customers whose CustomerID appears more than once in Orders.
select
 * 
from customers
where CustomerID in(
	select
    CustomerID
	from orders
	group by CustomerID
    having count(*) >1) ;


-- 7. Find customers who placed exactly one order.
select
 * 
from customers
where CustomerID in(
	select
    CustomerID
	from orders
	group by CustomerID
    having count(*) =1) ;


-- 9. Find customers whose orders exist in OrdersArchive.
select *
from orders o
where exists (
    select 1
    from ordersarchive a
    where a.OrderID = o.OrderID
);


-- 10. Find customers who have orders in Orders but not in OrdersArchive.
select *
from orders o
where not exists (
    select 1
    from ordersarchive a
    where a.OrderID = o.OrderID
);

-- 11. Find customers whose total orders are greater than the average order count.
select 
customerid,
count(*) as totalorders
from orders
group by customerid
having count(*) > (
select avg(cnt)
from (
	select count(*) as cnt
	from orders
	group by customerid
) t
);

-- 12. Get customers who placed at least one order.
select
customerid,
firstname,
lastname
from customers
where customerid in (select customerid from orders);

-- 13. Find products that were never ordered.
select
ProductID,
Product
from 
products
where ProductID not in (select ProductID from orders);

-- 14. Retrieve orders whose quantity is greater than the average quantity.
select
OrderID,
Quantity
from orders
where Quantity > (select avg(Quantity) from orders);

-- 15. Find customers who ordered only once.
select
c.CustomerID,
c.FirstName,
c.LastName
from Customers c
where (
    select count(*)
    from orders o
    where o.CustomerID = c.CustomerID
) = 1;



-- 16. Find customers who ordered more than the maximum order count of any other customer.
select
CustomerID,
count(*) as totalorders
from orders
group by CustomerID
having count(*) >(
	select
	max(OrderCount) 
	from(
		select
		CustomerID,
		count(*) as OrderCount
		from orders
		group by CustomerID) t
		);



/* =====================================================
		EASY CTE PRACTICE QUESTIONS (BASIC LEVEL)
   ===================================================== */

-- 1. Create a CTE that selects all rows from Orders.
with CTEorders as
(
select 
* from orders
)
select * from CTEorders;

-- 2. Create a CTE that selects only CustomerID and OrderID from Orders.
with CTEorders as
(
select 
CustomerID,
OrderID
 from orders
)
select * from CTEorders;

-- 3. Create a CTE that counts total orders per customer.
with CTEorders as
(
select 
CustomerID,
Count(*) as TotalCount
 from orders
 group by CustomerID
)
select * from CTEorders;

-- 4. Create a CTE that filters orders with Quantity greater than 2.
with CTEorders as
(
select 
OrderID,
Quantity
from orders
where Quantity > 2
)
select * from CTEorders;

-- 5. Create a CTE that selects customers from a specific country.
with CTEcustomers as
(
select 
CustomerID,
Country
from customers
having Country ='USA'
)
select * from CTEcustomers;

-- 6. Create a CTE that combines Orders and OrdersArchive.
with CTEorders as
(
select * from orders
union all
select * from ordersarchive as a
)
select * from CTEorders;

-- 7. Create a CTE that calculates total Quantity per ProductID.
with CTEorders as
(
select 
ProductID,
count(Quantity) as TotalQuantity
from orders
group by ProductID
)
select * from CTEorders;

-- 8. Create a CTE that finds customers with more than one order.

with cteorders as (
select 
customerid,
count(*) as totalorders
from orders
group by customerid
having count(*) > 1
)
select
c.customerid,
c.firstname,
c.lastname,
cte.totalorders
from customers c
inner join cteorders cte
on c.customerid = cte.customerid;

-- 9. Create a CTE that retrieves all orders placed after a given date and display their OrderID and OrderDate.

with cteorders as (
select 
OrderID,
OrderDate as CurrentDate,
lead(OrderDate) over()as AfterDate
from orders
order by OrderID, OrderDate
)
select 
OrderID,
AfterDate
from cteorders;

-- 10. Create a CTE that selects distinct CustomerIDs from Orders.
with cteorders as (
select distinct
*
from customers
)
select * from cteorders;