use practicsql;

-- Create the View

create view ViewsCustomers as
(
select
CustomerID,
MAX(OrderDate) as LastOrderDate
from orders as o
group by CustomerID
);

-- Deleted or Drop the View

drop view ViewsCustomers;

-- How replace View ( First Drop then Create)

drop view ViewsCustomers;

create view ViewsCustomers as
(
select
CustomerID,
MAX(OrderDate) as LastOrderDate
from orders as o
group by CustomerID
);

-- Make a views that contaion details from orders, products,customers and employees
create view orderdetails as
(
select
o.OrderId,
o.OrderDate,
p.Product,
p.Category,
p.Price,
o.Quantity,
concat(coalesce(c.FirstName, ''),' ' ,coalesce(c.LastName, '') )as CustomerName,
concat(coalesce(e.FirstName, ''),' ' ,coalesce(e.LastName, '') )as EmployeeName,
e.Department,
o.OrderStatus
from orders as o
left join products as p
on o.ProductID = p.ProductID
left join customers as c
on o.CustomerID = c.CustomerID
left join employees as e
on o.SalesPersonID = e.EmployeeID
);

select * from orderdetails;

-- Find the Total Sales from ordersetails views
select
OrderID,
Price,
Quantity,
Price * Quantity as TotalSales
from orderdetails;

/* Create a customer spending tier:
       - High (> 40)
       - Medium (20–30)
       - Low (< 20) */
       
select
OrderID,
Price,
(Price * Quantity) as TotalSales,
case
	when (Price * Quantity) > 40 then 'High'
    when (Price * Quantity) between 20 and 30 then 'Medium'
    when (Price * Quantity) between 1 and 20 then 'Low'
    else 'Free'
end as Ranges
from orderdetails;

