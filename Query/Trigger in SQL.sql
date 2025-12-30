use practicsql;
/*============================================
	trigger to set created_at on insert
=============================================*/

alter table customers
add column created_at datetime;


delimiter $$

create trigger before_customer_insert
before insert
on customers
for each row
begin
	set new.created_at = now();
end $$

delimiter ;

insert into customers(customerid,firstname,lastname,country,score)
values(201,'john','doe','usa',85);

insert into customers(customerid,firstname,lastname,country,score)
values(202,'joe','smith','USA',78);

select
*
from customers;

