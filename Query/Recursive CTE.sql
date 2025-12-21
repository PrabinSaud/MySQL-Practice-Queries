use practicsql;

-- Show the numbers 1 to 10
with recursive Series as
(
select 
1 as n
union all
select 
n + 1
from Series
where n < 10
)
select * from Series;

 
-- show the employees hierarchy by displaying each employee's level
with recursive emp_hierarchy as(
    -- anchor query: top-level employees
select
	employeeid,
	firstname,
	managerid,
	1 as level
from employees
where managerid is null
   or managerid not in (select employeeid from employees)

union all

-- recursive query: employees reporting to previous level
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
