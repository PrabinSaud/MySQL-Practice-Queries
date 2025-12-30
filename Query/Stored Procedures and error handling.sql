use practicsql;
/*===============================
	CREATE A STORED PROCEDURE
=================================*/
DELIMITER $$
create procedure customersummary()
begin
	select
		count(*) as CustomerCount,
		avg(Score) as AvgScore
	from customers
	where country = 'USA';
end $$
DELIMITER ;

call customersummary();		-- Calling a Procedure

/*============================================
	CREATE A STORED PROCEDURE WITH PARAMETER
===============================================*/
DELIMITER $$
create procedure customersummary_country(in p_country varchar(50))
begin
	select
		count(*) as CustomerCount,
		avg(Score) as AvgScore
	from customers
	where country = p_country;
end $$
DELIMITER ;

call customersummary_country('Germany');

/*============================================
	ORDERID PROCEDURE WITH PARAMETER
===============================================*/
DELIMITER $$
create procedure orderidsummary(in p_OrderID int)
begin
	select
	*
	from orders
	where OrderID = p_OrderID;

end $$
DELIMITER ;

call orderidsummary(6);


/*============================================
	order summary with in and out
=============================================*/

delimiter $$

create procedure ordertotalsummary(
	in p_orderid int,
	out p_totalamount decimal(10,2)
)
begin
	select
		(quantity * sales)
	into p_totalamount
	from orders
	where orderid = p_orderid;
end $$

delimiter ;

call ordertotalsummary(6, @total);
select @total as totalamount;


/*============================================
	orderid procedure with parameter and error handling
=============================================*/

delimiter $$

create procedure orderidsummaryerror(in p_orderid int)
begin
	declare v_count int default 0;

	-- check if order exists
	select count(*)
	into v_count
	from orders
	where orderid = p_orderid;

	-- error handling
	if v_count = 0 then
		select 'order not found' as message;
	else
		select
			*
		from orders
		where orderid = p_orderid;
	end if;

end $$

delimiter ;

call orderidsummaryerror(12);
