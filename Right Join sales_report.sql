/* ===================== SQL TABLE Right JOINS Project =======================
Task: Using SalesDB, retrieve a list of all orders, along with the related 
   customer, product, and employee details. 
   For each order, display:
   Order ID, Customer's name, Product name, Sales, Price, Sales person's name 
========================================================================= */



USE practicsql;

select 
    o.OrderID,
    o.ProductID,
    p.Product,
    p.Category,
    o.OrderDate,
    o.OrderStatus,
    e.FirstName AS EmployeeName,
    e.Department AS Department,
    c.FirstName AS CustomerName
from orders as o
right join ordersarchive as a
    on a.OrderID = o.OrderID
right join products as p
    on o.ProductID = p.ProductID
right join employees as e
    on o.SalesPersonID = e.EmployeeID
right join customers as c
    on o.CustomerID = c.CustomerID;
