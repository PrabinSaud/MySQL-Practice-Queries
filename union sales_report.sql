use practicsql;


/* ===========================================================
			 Combining the table orders and ordersarchive
			 without dubilcates values.
 ===========================================================*/
select 
'orders' as Table_Sources,
OrderID,
ProductID,
CustomerID,
SalesPersonID,
OrderDate,
ShipDate,
OrderStatus,
ShipAddress,
BillAddress,
Quantity,
Sales,
CreationTime
from orders

union

select 
'ordersarchive' as Table_Sources,
OrderID,
ProductID,
CustomerID,
SalesPersonID,
OrderDate,
ShipDate,
OrderStatus,
ShipAddress,
BillAddress,
Quantity,
Sales,
CreationTime
from ordersarchive
order by Table_Sources;



/* 1. Show all OrderIDs that appear in both orders and ordersarchive. */
select 
OrderID,
'Orders' as Table_Sources
from orders 
union
select 
OrderID,
'ordersarchive' as Table_Sources
from ordersarchive;


/* 2. Show all orders that exist only in orders but not in ordersarchive. */
select 
o.*
from orders as o
left join ordersarchive as a
on o.OrderID = a.OrderID
where a.OrderID is null;


/* 3. Show all orders where the OrderStatus is NULL in both tables. */
select
*
from 
orders
where OrderStatus is null
union
select
* from 
ordersarchive
where OrderStatus is null;

/* 4. Show ProductIDs that appear more than 5 times across both tables. */

select 
    ProductID,
    count(*) as total_count
from (
    select ProductID from orders
    union all
    select ProductID from ordersarchive
) as all_products
group by ProductID
having count(*) > 5;


/* 5. Combine both tables using union all and show the top 10 newest orders. */
select
* 
from orders
union all
select
* from ordersarchive
order by OrderDate desc limit 10;


