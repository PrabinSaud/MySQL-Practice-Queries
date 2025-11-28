use practicsql;
/*	==============================================================
		DATE AND TIME FORAMTTING USING DATE_FORMAT FUNCTION
	==============================================================*/
select 
OrderId,
CreationTime,
date_format(CreationTime,'%d') as Day,
date_format(CreationTime,'%a') as Week,
date_format(CreationTime,'%W') as Full_week,
date_format(CreationTime,'%m') as Month,
date_format(CreationTime,'%M') as Full_Month,
date_format(CreationTime,'%y') as Year,
date_format(CreationTime,'%Y') as Full_Year,
date_format(CreationTime,'%Y/%m/%d') as Full_Date,
date_format(CreationTime,'%Y/%M/%a') as Date
from Orders;

/*	==============================================================
		DATE AND TIME FORAMTTING USING CAST FUNCTION
	==============================================================*/
select
    cast('123'as unsigned) as number,
	cast( 123 as signed) as number;
    
    
    /*	==============================================================
		ADDING DATE USING DATE_ADD FUNCTION
	==============================================================*/
    
    
select 
'2023/02/27' as Date,
date_add('2023/02/27',interval 2 year) as Yearadd,
date_add('2023/02/27',interval 3 month) as Monthadd,
date_add('2023/02/27',interval 7 day) as Daysadd;
    
    
	/*	==============================================================
				SUBTRACTING DATE USING DATE_SUB FUNCTION
		==============================================================*/
select 
'2023/02/27' as Date,
date_add('2023/02/27',interval -2 year) as Yearsubtract,
date_add('2023/02/27',interval -3 month) as Monthsubtract,
date_add('2023/02/27',interval -7 day) as Daysubtract

union all   
 
select 
'2023/02/27' as Date,
date_sub('2023/02/27',interval 2 year) as Yearsub,
date_sub('2023/02/27',interval 3 month) as Monthsub,
date_sub('2023/02/27',interval 7 day) as Dayssub;


/*	==============================================================
				SUBTRACTING DATE USING DATE_DIFF FUNCTION
		==============================================================*/
        
select
OrderDate,
ShipDate,
datediff(ShipDate, OrderDate) as Days
from orders;

select
datediff('25/06/05', '23/04,07') as Days;


select
timestampdiff(year,  '2023-04-07', '2025-06-05') as Years,
timestampdiff(month, '2023-04-07', '2025-06-05') as Months,
timestampdiff(day,   '2023-04-07', '2025-06-05') as Days;

