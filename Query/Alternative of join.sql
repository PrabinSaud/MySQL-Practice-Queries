-- Joining Multiple Table(Alternative of Join)
use practicsql;


select *
from Customers c, Orders o, OrdersArchive a
where c.CustomerID = o.CustomerID and c.CustomerID = a.CustomerID;



select 
c.CustomerID,
o.OrderID,
o.ProductID,
c.FirstName,
c.LastName,
o.ShipAddress,
o.BillAddress,
a.ProductID,
a.OrderDate,
a.ShipDate,
a.OrderStatus
from Customers c, Orders o, OrdersArchive a
where c.CustomerID = o.CustomerID and c.CustomerID = a.CustomerID;
