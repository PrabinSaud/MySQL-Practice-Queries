use practicsql;

-- Creat a CTAS with calculated columns

create table order_sales
as
select
OrderID,
CustomerName,
Product,
Quantity,
Price,
Quantity * Price as TotalAmount
from orderdetails;

select * from order_sales;


-- Drop CTAS
drop table order_sales;

-- CTAS with aggregation
create table customer_total_sales
as
select
    CustomerName,
    SUM(Quantity * Price) as TotalSales
from orderdetails
group by CustomerName;

select * from customer_total_sales;

drop table customer_total_sales;


-- Temporary table using SELECT (most common)

create temporary table temp_orderdetails
as
select
OrderID,
CustomerName,
Product,
Quantity,
Price,
Quantity * Price as TotalAmount
from orderdetails;
