select
	lead(OrderID) over(order by orderID) as AnotherValue,
	lag(OrderID) over(order by orderID) as PreviousValue,
	lead(OrderID,1,0) over(order by orderID) as AnotherValue,
	lag(OrderID,1,0) over(order by orderID) as PreviousValue
from orders;


/* Analyze the Month-over-Month performance by finding the percentage 
	change in sales between currrent and previous month */
select
*,
CurrentMonthSales - PreviousMonthsale as MoM_changes,
concat(round(cast((CurrentMonthSales - PreviousMonthsale )as float)/ PreviousMonthsale * 100,2),'%') as MoM_Percentage
from(
	select
	month (OrderDate) as OrderMonth,
	sum(Sales) CurrentMonthSales,
	lag(sum(Sales))  over (order by month (OrderDate)) as PreviousMonthsale
	from orders
	group by month (OrderDate)
	)as t;
    
    
    
-- Rank customer loyalty based on the average days between their orders

select
CustomerID,
avg(DayNextOrder) as AvgDays,
rank() over(order by coalesce(avg(DayNextOrder),9999) ) as Rank_loyality
from(
	select 
	OrderID,
	CustomerID,
	OrderDate as CurrentOrder,
	lead(OrderDate) over(partition by CustomerID order by OrderDate) as NextOrder,
	datediff(lead(OrderDate) over(partition by CustomerID order by OrderDate), OrderDate) DayNextOrder
	from  orders
	order by CustomerID, OrderID
	)as t
group by CustomerID;


-- find the lowest and highest sales from orders using value window function

select
	OrderID,
	ProductID,
	Sales,
	first_value(Sales) over(order by sales) as LowestSales,
	last_value(Sales) over(order by sales rows between current row and unbounded following) as HighestSale
from orders;


use practicsql;
/* ---------------- LEAD / LAG ---------------- */

/* 1. Show each order with the previous order date for the same customer */
select 
OrderId,
CustomerID,
OrderDate,
lag(OrderDate) over(partition by CustomerID order by OrderDate) as previousorderdate
from orders
order by CustomerID, OrderDate;

/* 2. Show each order with the next order date for the same customer */
select 
OrderId,
CustomerID,
OrderDate,
lead(OrderDate) over(partition by CustomerID order by OrderDate) as nextorderdate
from orders
order by CustomerID, OrderDate;


/* 3. Calculate the number of days between the current order and the previous order for each customer */
select 
OrderId,
CustomerID,
OrderDate as Currentorderdate,
lag(OrderDate) over(partition by CustomerID order by OrderDate) as Previousorderdate,
datediff(OrderDate , lag(OrderDate) over(partition by CustomerID order by OrderDate) ) as PreviousOrderdays
from orders
order by CustomerID, OrderDate;

/* 4. Calculate the number of days until the next order for each customer */
select 
OrderId,
CustomerID,
OrderDate as Currentorderdate,
lead(OrderDate) over(partition by CustomerID order by OrderDate) as Nextorderdate,
datediff( lead(OrderDate) over(partition by CustomerID order by OrderDate),OrderDate) as nextorderdays
from orders
order by CustomerID, OrderDate;


/* 5. Show the sales difference between the current order and the previous order per customer */
select
OrderId,
CustomerId,
OrderDate,
Sales as Currentsales,
coalesce( lag(Sales) over(partition by CustomerID order by OrderDate),0) as PreviousSales,
(Sales -coalesce( lag(Sales) over(partition by CustomerID order by OrderDate),0)) as SalesDifference
from orders
Order by CustomerID,OrderDate;

/* ---------------- FIRST_VALUE ---------------- */

/* 6. Show each order with the first order date of that customer */
select
OrderId,
CustomerID,
OrderDate,
first_value(orderDate) over(partition by CustomerID order by OrderDate) as FirstOrderDate
from orders
order by CustomerID,OrderDate;

/* 7. Show each order with the first order sales amount of that customer */
select
OrderId,
CustomerID,
OrderDate,
Sales,
first_value(Sales) over(partition by CustomerID order by OrderDate) as FirstOrderSales
from orders
order by CustomerID,OrderDate;

/* 8. Calculate the difference between current sales and the customer’s first order sales */
select
OrderId,
CustomerID,
OrderDate,
Sales as CurrentSales,
first_value(Sales) over(partition by CustomerID order by OrderDate) as FirstOrderSales,
(Sales - first_value(Sales) over(partition by CustomerID order by OrderDate)) as SalesDifference
from orders
order by CustomerID,OrderDate;

/* ---------------- LAST_VALUE ---------------- */

/* 9. Show each order with the last order date of that customer */
select
OrderId,
CustomerID,
OrderDate,
last_value(orderDate) over(partition by CustomerID order by OrderDate
rows between current row and unbounded following ) as LastOrderDate
from orders
order by CustomerID,OrderDate;

/* 10. Show each order with the last order sales amount of that customer */
select
OrderId,
CustomerID,
OrderDate,
Sales,
last_value(Sales) over(partition by CustomerID order by OrderDate
rows between current row and unbounded following ) as LastOrderSales
from orders
order by CustomerID,OrderDate;

/* 11. Calculate the difference between current sales and the customer’s last order sales */
select
OrderId,
CustomerID,
OrderDate,
Sales,
last_value(Sales) over(partition by CustomerID order by OrderDate
rows between current row and unbounded following ) as LastOrderSales,
(Sales-last_value(Sales) over(partition by CustomerID order by OrderDate
rows between current row and unbounded following )) as LastSalesDiffe
from orders
order by CustomerID,OrderDate;

/* ---------------- NTH_VALUE ---------------- */

/* 12. Show the second order date for each customer on every row */
select
OrderID,
CustomerID,
OrderDate,
nth_value(OrderDate,2) over(partition by CustomerID order by OrderDate
rows between unbounded preceding and unbounded following) as SecondOrderDate
from orders
order by CustomerID, OrderDate;

/* 13. Show the third order sales value for each customer */
select
OrderID,
CustomerID,
OrderDate,
Sales,
nth_value(Sales,3) over(partition by CustomerID order by OrderDate
rows between unbounded preceding and unbounded following) as ThirdsalesValue
from orders
order by CustomerID, OrderDate;

/* 14. Compare the current order sales with the second order sales of the same customer */
select
OrderID,
CustomerID,
OrderDate,
Sales as Currentsales,
nth_value(Sales,2) over(partition by CustomerID order by OrderDate
rows between unbounded preceding and unbounded following) as SecondsalesValue,
(Sales-nth_value(Sales,2) over(partition by CustomerID order by OrderDate
rows between unbounded preceding and unbounded following)) as SalesDiff
from orders
order by CustomerID, OrderDate;

/* ---------------- MIXED VALUE FUNCTIONS ---------------- */

/* 15. For each order, show:
       - First order date
       - Previous order date
       - Next order date
*/
select
OrderId,
CustomerId,
OrderDate,
first_value(OrderDate) over(partition by CustomerID order by OrderDate) as FirstorderDate,
lag(OrderDate) over(partition by CustomerID Order by OrderDate) as Previousorderdate,
lead(OrderDate) over(partition by CustomerID Order by OrderDate) as Nextorderdate
from orders
Order by CustomerID,OrderDate;

/* 16. Identify customers whose current order sales are higher than their first order sales */
select
*
from(
	select
	OrderId,
	CustomerID,
	OrderDate,
	Sales as CurrentOrdersales,
	first_value(Sales) over(partition by CustomerID order by OrderDate) as FirstOrderSales
	from orders
	order by CustomerID,OrderDate) as t
where CurrentOrdersales > FirstOrderSales;


/* 17. Identify orders where the customer's last order sales are lower than the previous order sales */

select
*
from(
	select
	OrderId,
	CustomerID,
	OrderDate,
	Sales as CurrentOrdersales,
	coalesce( lag(Sales) over(partition by CustomerID order by Orderdate),0) as PreviousOrderSales,
	last_value(Sales) over(partition by CustomerID order by OrderDate
	rows between current row and unbounded following) as LastOrderSales
	from orders
	order by CustomerID,OrderDate) as t
where LastOrderSales < PreviousOrderSales;

