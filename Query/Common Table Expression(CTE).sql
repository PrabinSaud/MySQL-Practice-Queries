use practicsql;
-- Find the total sales per customers and also show customer details ( using CTE)
-- standalone CTE and multiple satandalone CTE

-- Step 1: Total sales per Customers(Standalone CTE)
with Cte_totalsales as
(
select
CustomerID,
sum(Sales) as Totalsales
from orders
group by CustomerID
)
-- Step 2: Average sales per Customers
,AverageSales as
(
select
CustomerID,
avg(Sales) as Avgsales
from orders
group by CustomerID
)
-- Step 3: Find the last order date for each customers
,LastDate as 
(
select
CustomerID,
MAX(OrderDate) as LastOrderDate
from orders as o
group by CustomerID
)
-- Rank Customers based on totalsales per customers (Nested CTE)
, Rank_Customers as
(
select 
CustomerID,
Totalsales,
rank() over(order by Totalsales desc) as Ranks
from Cte_totalsales
)

select
c.CustomerID,
c.FirstName,
c.LastName,
cte.Totalsales,
a.Avgsales,
ld.LastOrderDate,
rc.Ranks
from customers as c
left join Cte_totalsales as cte
on c.CustomerID = cte.CustomerID
left join Averagesales as a
on a.CustomerID = c.CustomerID
left join LastDate as ld
on ld.CustomerID = c.CustomerID
left join Rank_Customers as rc
on rc.CustomerID = c.CustomerID;



