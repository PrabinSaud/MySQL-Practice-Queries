/* ============================================================
   TOPIC: SQL CASE FUNCTION PRACTICE QUESTIONS
   DESCRIPTION: This section contains 20 real-world SQL problems 
   designed to help learners master conditional logic using the 
   CASE expression with products, customers, and orders data.
   ============================================================ */


use ola;
SELECT * FROM products;

-- Count how many timess each customer has made an order with saless greater than 50.
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    SUM(CASE 
		WHEN p.price > 50 THEN 1 
		ELSE 0 
    END) AS PriceAbove30,
    COUNT(*) AS TotalProducts
FROM products AS p
GROUP BY p.product_id, p.product_name, p.category
ORDER BY p.product_id;


/* 3. Label products based on price:
      >100 → 'Premium'
      51–100 → 'Standard'
      <=50 → 'Budget'. */
      
SELECT 
* ,
CASE
	WHEN price > 100 THEN 'Premium'
    WHEN price between 51 and 100 THEN 'Standard'
    Else 'Budget'
END as Lable
From products;
	

/* 4. For each order, show:
      quantity >= 50 → 'Bulk Order'
      20–40 → 'Medium Order'
      10 → 'Low Order'. */
ALTER TABLE products
ADD quantity INT;
UPDATE products SET quantity = 50  WHERE product_id = 101;
UPDATE products SET quantity = 35  WHERE product_id = 102;
UPDATE products SET quantity = 60  WHERE product_id = 103;
UPDATE products SET quantity = 25  WHERE product_id = 104;
UPDATE products SET quantity = 40  WHERE product_id = 105;
UPDATE products SET quantity = 80  WHERE product_id = 106;
UPDATE products SET quantity = 30  WHERE product_id = 107;
UPDATE products SET quantity = 90  WHERE product_id = 108;
UPDATE products SET quantity = 20  WHERE product_id = 109;
UPDATE products SET quantity = 55  WHERE product_id = 110;

SELECT *,
CASE 
	WHEN quantity >=50 THEN 'Bulk Order'
    WHEN quantity BETWEEN 30 AND 40 THEN 'Medium Order'
	WHEN quantity > 10 THEN 'Low Order'
    ELSE 'No Order'
END as OrderLabel
FROM products;




/* 5. Show price status of products:
      Highest price → 'Most Expensive'
      Lowest price → 'Cheapest'
      Else → 'Normal Price'. */
      
SELECT 
* ,
CASE 
	WHEN price = (SELECT MAX(price) FROM products) THEN 'Most Expensive'
    WHEN price = (SELECT MIN(price)FROM products )THEN 'Chepest'
    ELSE 'Normal Price'
END as pricetag
FROM products
ORDER BY price DESC;

	
/* 8. Label orders based on revenue (quantity * price):
      >200 → 'High Value'
      50–200 → 'Medium Value'
      <50 → 'Low Value'. */
SELECT 
product_id,
product_name,
category,
quantity,
price,
quantity * price AS revenue,
CASE
	WHEN quantity * price > 5000 THEN 'High Value'
    WHEN quantity * price BETWEEN 3000 AND 5000 THEN 'Medium Value'
    ELSE 'Low value'
END AS Price_Label
FROM products;
      

/* 9. Tag products based on category:
      Dairy, Bakery → 'Food'
      Household → 'Home Product'
      Others → 'Misc'. */

SELECT 
product_id,
product_name,
category,
CASE
	WHEN category IN ('Dairy', 'Bakery') THEN 'Food'
	WHEN category = 'Household' THEN 'Home Product'
	ELSE 'Misc'
END AS tag
FROM products;


/* 10. Mark orders as:
       ordered on weekend → 'Weekend Sale'
       ordered on weekday → 'Weekday Sale'. */

SELECT
order_id,
customer_id,
order_date,
CASE
	WHEN DAYOFWEEK(order_date) IN (1, 7) THEN 'Weekend Sale'
	ELSE 'Weekday Sale'
END AS sale_type
FROM orders;


/* 11. Classify product names:
       containing 'Pack' → 'Pack Item'
       containing 'Bottle' → 'Beverage'
       else → 'General'. */
SELECT
product_id,
product_name,
CASE
	WHEN product_name LIKE '%Pack%' THEN 'Pack Item'
	WHEN product_name LIKE '%Bottle%' THEN 'Beverage'
	ELSE 'General'
END AS name_type
FROM products;

       

/* 12. For each price, label:
       divisible by 5 → 'Rounded Price'
       else → 'Odd Price'. */
       
SELECT
product_id,
product_name,
price,
CASE
	WHEN price % 5 = 0 THEN 'Rounded Price'
	ELSE 'Odd Price'
END AS price_label
FROM products;


/* 13. For each customer:
       name starting with A–M → 'Group 1'
       name N–Z → 'Group 2'. */
       
SELECT 
customer_id,
customer_name,
CASE
	WHEN LEFT(customer_name, 1) BETWEEN 'A' AND 'M' THEN 'Group 1'
	ELSE 'Group 2'
END AS customer_group
FROM customers;


/* 15. Classify categories by average price:
       avg price > 70 → 'High Cost Category'
       40–70 → 'Medium Cost Category'
       < 40 → 'Low Cost Category'. */
       
SELECT
category,
AVG(price) AS avg_price,
CASE
	WHEN AVG(price) > 70 THEN 'High Cost Category'
	WHEN AVG(price) BETWEEN 40 AND 70 THEN 'Medium Cost Category'
	ELSE 'Low Cost Category'
END AS category_type
FROM products
GROUP BY category;


/* 16. For each order:
       if product is Grocery → add label 'Daily Use'
       if product is Snack → 'Snack Item'
       else → 'Other Item'. */

SELECT
o.order_id,
p.product_name,
p.category,
CASE
	WHEN p.category = 'Grocery' THEN 'Daily Use'
	WHEN p.category = 'Snack' THEN 'Snack Item'
	ELSE 'Other Item'
END AS usage_type
FROM orders AS o
LEFT JOIN products AS p
ON o.product_id = p.product_id;


/* 17. Mark quantity as:
       even → 'Even Quantity'
       odd → 'Odd Quantity'. */
       
SELECT
product_id,
product_name,
quantity,
CASE
	WHEN quantity % 2 = 0 THEN 'Even Quantity'
	ELSE 'Odd Quantity'
END AS number_type
FROM products;


/* 20. For each order, show:
       if no matching product → 'Invalid Product'
       else → 'Valid Product'. */
SELECT
    o.order_id,
    o.product_id,
    CASE
        WHEN p.product_id IS NULL THEN 'Invalid Product'
        ELSE 'Valid Product'
    END AS product_status
FROM orders AS o
LEFT JOIN products AS p
ON o.product_id = p.product_id;

