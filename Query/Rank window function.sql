
/*-------- Window Aggreation Function --------------*/

-- Find the average sales 
select
*,
round(avg(sales) over(),0) as avgerage
from orders;

-- Rank the orders based on their sales from highest to lowest 
select 
OrderID,
ProductID,
Sales,
row_number() over(order by Sales desc) as Ranks_Rows,
rank() over(order by Sales desc) as Ranks,
dense_rank() over(order by Sales desc) as Dense_Ranks
from orders;

-- Find the top highest sales for each product
select
*
from(
	select 
	OrderId,
	ProductId,
	Sales ,
	row_number() over(partition by ProductID order by Sales desc) as Ranks_Rows
	from orders) as t
Where Ranks_Rows = 1;


-- Find the lowest 2 customers based on teir totalsales.
select
*
From(
select 
CustomerID,
sum(sales) as TotalSales,
row_number() over(Order by sum(sales)) as Ranks
from orders
group by CustomerID) as t
where Ranks <= 2;

-- Assign unique IDs to the rows of the 'Order Archive' table
select 
*,
row_number() over(order by OrderID) as UniqueID_PK
from ordersarchive;

-- Identify duplicates rows in the table Ordersarchive
-- and return clean result without duplicates in OrdersID
select
*
from(
	select 
	*,
	row_number() over(partition by OrderID order by CreationTime desc) as ranks
	from ordersarchive
	) as t
where ranks = 1 ;


-- Divide the orders data into two groups
select
* ,
ntile(2) over(order by OrderID) as Ordr_Groups
from orders;


-- Segment all orders into 3 category : high, medium, low
select
*,
case 
	when segment=1 then 'High'
    when segment=2 then 'Medium'
    when segment=3 then 'Low'
end as category
from(
	select 
	OrderID,
	ProductID,
	Sales,
	ntile(3) over(order by OrderID) as segment
	from orders) as t;
    
-- Find the  products that have 50% of prices.
select
*,
concat(percent * 100, '%') as percentage
from(
	select
	product,
	price,
	percent_rank() over(order by price) as percent
	from products)as t
    where percent =0.5 ;



