use practicsql;

/*================================ */
-- part 1: revenue analysis
/*================================ */
/* 1. total revenue per month for the last 6 months */

select
	date_format(orderdate, '%Y-%m') as order_month,
	sum(quantity * sales) as total_revenue
from orders
where orderdate >= date_sub(curdate(), interval 6 month)
group by date_format(orderdate, '%Y-%m')
order by order_month desc;


/* 2. month-over-month revenue growth (%) */

with monthly_revenue as (
select
	date_format(orderdate, '%Y-%m') as order_month,
	sum(quantity * sales) as total_revenue
from orders
group by date_format(orderdate, '%Y-%m')
)
select
order_month,
total_revenue,
(total_revenue - lag(total_revenue) over(order by order_month)) 
/ lag(total_revenue) over(order by order_month) * 100 as mom_growth_percent
from monthly_revenue;


/* 3. top 3 months by revenue */

select
	date_format(orderdate, '%Y-%m') as order_month,
	sum(quantity * sales) as total_revenue
from orders
group by date_format(orderdate, '%Y-%m')
order by total_revenue desc
limit 3;

/*==============================
part 2: customer analysis
================================*/
/*1. find top 3 customers by total spend*/
select
	CustomerID,
	sum(Quantity * Sales) as Totalspend
from orders
group by CustomerID
order by sum(Quantity * Sales) desc
limit 3;

/*2. calculate average order value (aov) per customer*/
select
	CustomerID,
	sum(quantity * sales) / count(orderid) as aov
from orders
group by CustomerID;

/*3. identify repeat customers (more than 1 order)*/

select
	CustomerID,
	count(OrderID) as Counts
from orders
group by CustomerID
having count(OrderID) >1;

/*==============================
part 3: product analysis
================================*/

/* 7. find the top 3 products by total revenue */
select
	ProductID,
	sum(Quantity * Sales) as Totalrevenue
from orders
group by ProductID
order by Totalrevenue desc
limit 3 ;

/* 8. rank products within each category by total revenue */
/* 8. rank products within each category by total revenue */

with product_revenue as (
select
p.productid,
p.product,
p.category,
sum(o.quantity * o.sales) as totalrevenue
from products p
join orders o
on p.productid = o.productid
group by p.productid, p.product, p.category
)
select
product,
category,
totalrevenue,
rank() over(partition by category order by totalrevenue desc) as ranks
from product_revenue;


/* 9. find products that were never ordered */
select 
ProductID 
from products
where ProductID not in(select ProductID from orders);


/*==============================
part 4: operational insights
================================*/

/* 10. calculate average delivery time (shippeddate - orderdate) */
select
	round(avg(datediff(shippeddate, orderdate)), 2) as avg_delivery_days
from orders
where shippeddate is not null;


/* 11. identify orders delivered slower than the average delivery time */
with avg_delivery as (
select
	avg(datediff(shippeddate, orderdate)) as avg_days
from orders
where shippeddate is not null
)
select
o.orderid,
o.orderdate,
o.shippeddate,
datediff(o.shippeddate, o.orderdate) as delivery_days
from orders o
cross join avg_delivery a
where datediff(o.shippeddate, o.orderdate) > a.avg_days;


/* 12. compare delivered vs cancelled order percentage */
select
orderstatus,
count(*) as order_count,
round(
	count(*) * 100.0 / sum(count(*)) over (),
	2
) as percentage
from orders
where orderstatus in ('delivered', 'cancelled')
group by orderstatus;


/*==============================
part 5: advanced business insights
================================*/

/* 13. identify customers who have not placed any order in the last 90 days */
select
c.customerid,
c.firstname,
c.lastname
from customers c
where not exists (
select 1
from orders o
where o.customerid = c.customerid
  and o.orderdate >= date_sub(curdate(), interval 90 day)
);

/* 14. find month-over-month order count growth */
with monthly_orders as (
select
	date_format(orderdate, '%y-%m') as order_month,
	count(orderid) as order_count
from orders
group by date_format(orderdate, '%y-%m')
)
select
order_month,
order_count,
order_count - lag(order_count) over(order by order_month) as mom_order_growth
from monthly_orders;


/* 15. identify the top 10% customers by total revenue */
with customer_revenue as (
select
	customerid,
	sum(quantity * sales) as total_revenue
from orders
group by customerid
),
ranked_customers as (
select
	customerid,
	total_revenue,
	percent_rank() over(order by total_revenue desc) as pr
from customer_revenue
)
select
customerid,
total_revenue
from ranked_customers
where pr <= 0.10;

