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