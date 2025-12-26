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
