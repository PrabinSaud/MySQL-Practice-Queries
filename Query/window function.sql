use ola;
select * from products;

/* ============================================================
	   TOPIC: Window Function Analysis on Products Table
	   DESCRIPTION: Using SUM() and COUNT() with PARTITION BY 
				to calculate category-wise totals.
   ============================================================ */



-- Find the total sales across all products
-- Find total sale for each category
-- Find the total sale for each combination of category and quantity
-- Additionally provides details such price, quantity

SELECT 
	product_id,
	product_name,
	category,
	price,
	quantity,
SUM(price) OVER() AS totalsale,
SUM(price) OVER(PARTITION BY category ) AS saleby_category,
SUM(price) OVER(PARTITION BY category, quantity ) AS saleby_category_quantity
FROM products;

-- Find the sum and number of quantities for each category  from products table.
SELECT 
	product_id,
	product_name,
	category,
	quantity,
SUM(quantity) OVER(PARTITION BY category) AS Total_category_quantity,
COUNT(quantity) OVER(PARTITION BY category) AS  TotalCount_category_quantity
FROM products;

-- Ranking the products by price Most Expensive to Chepest.
SELECT 
    product_id,
    product_name,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;

-- Find the sum of sales for each category  from products table using Window function.

SELECT 
	product_id,
	product_name,
	category,
	quantity,
SUM(quantity) OVER(PARTITION BY category ORDER BY product_id
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS Total_category_quantity,
SUM(quantity) OVER(PARTITION BY category ORDER BY product_id
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Total_category_quantity
FROM products;
