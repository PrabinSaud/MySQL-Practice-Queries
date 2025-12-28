use practicsql;

/* =========================================================
   PRACTICE QUESTIONS: CTE, VIEW, CTAS
   ========================================================= */

/* -------------------- CTE -------------------- */

/* 1. Write a CTE to calculate total sales per customer
      and show only customers whose total sales are above 100 */
      
with ctecustomers as
(
select
CustomerID,
(Sales * Quantity) as Totalsales
from orders
)
select * from ctecustomers
where Totalsales > 100;

/* 2. Using a recursive CTE, generate dates from 2024-01-01 to 2024-01-31 */

with recursive dates as (
select 
date('2024-01-01') as FullDate
union all
select date_add(FullDate, interval 1 day)
from dates
where FullDate < '2024-01-31'
)
select *
from dates;

/*3. Write a recursive CTE to generate natural numbers from 1 to 10 */

with recursive dates as (
select 
1 as n
union all
select
n + 1 as n
from dates
where n < 10
)
select * from dates;


/* 4. Use a CTE to find customers who placed more orders than the average order count */
with ctecustomers as
(
select
CustomerID,
count(OrderID) as Countorder
from orders
group by CustomerID
),
avgorders as
(
select 
avg(Countorder) as Avgcount
from ctecustomers
)
select
c.CustomerID,
c.Countorder
from ctecustomers as c
join avgorders as a
where c.Countorder > a.Avgcount;


/* 5. Write a CTE to get the latest order for each customer */
with ctecustomers as
(
select
CustomerID,
max(OrderDate) as Lastorders
from orders
group by CustomerID
)
select * from ctecustomers;

/* 6. Using a recursive CTE, display the employee hierarchy
      with employee name, manager name, and level */
      
      /* Display employee hierarchy with level */

with recursive emp_hierarchy as (
-- anchor: top-level employees (no manager)
select
employeeid,
firstname,
managerid,
1 as level
from employees
where managerid is null

union all

-- recursive: employees reporting to previous level
select
e.employeeid,
e.firstname,
e.managerid,
h.level + 1 as level
from employees e
join emp_hierarchy h
on e.managerid = h.employeeid
)

select *
from emp_hierarchy
order by level, employeeid;


/* 6. Use multiple CTEs to:
      - calculate total sales per product
      - rank products based on total sales */

/* -------------------- VIEW -------------------- */

/* 7. Create a view that shows order id, customer name,
      product name, quantity, price, and total order amount */

/* 8. Query the view to find the top 5 customers by total purchase amount */

/* 9. Query a view to find monthly total sales */

/* 10. Update data using a view and identify when it is NOT allowed */

/* 11. Drop and recreate a view by adding an extra calculated column */

/* -------------------- CTAS -------------------- */

/* 12. Create a table using CTAS that stores only completed orders */

/* 13. Use CTAS to create a backup table of the customers table */

/* 14. Create a reporting table using CTAS that stores
       customer-wise total sales */

/* 15. After using CTAS, add a primary key to the new table */


