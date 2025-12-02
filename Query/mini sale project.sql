	/*=============================================================================================
				 Mini SQL Project: Retail Sales Analysis (Beginner Level)
				Scenario

				You are working in a small retail company that sells daily-use items.
				 Your task is to analyze sales performance and customer behavior using SQL. 
	=================================================================================================*/
    
    
-- Create these three basic tables customers, products, orders. You can fill 10 sample rows each.
    
-- Table customers
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Rohan Sharma', 'Delhi'),
(2, 'Aisha Verma', 'Mumbai'),
(3, 'Kunal Singh', 'Bangalore'),
(4, 'Priya Mehta', 'Chennai'),
(5, 'Arjun Patel', 'Delhi'),
(6, 'Sneha Nair', 'Kochi'),
(7, 'Vikram Das', 'Kolkata'),
(8, 'Meera Rai', 'Pune'),
(9, 'Rahul Gupta', 'Mumbai'),
(10, 'Divya Kapoor', 'Hyderabad');


-- Table Products
CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
category VARCHAR(50),
price DECIMAL(6,2)
);

INSERT INTO products (product_id, product_name, category, price) VALUES
(101, 'Milk 1Liter', 'Dairy', 55.00),
(102, 'Bread Loaf', 'Bakery', 40.00),
(103, 'Eggs 12pcs', 'Dairy', 70.00),
(104, 'Potato Chips', 'Snack', 25.00),
(105, 'Soap Bar', 'Household', 35.00),
(106, 'Rice 1kg', 'Grocery', 65.00),
(107, 'Juice Bottle', 'Drink', 90.00),
(108, 'Biscuits Pack', 'Snack', 20.00),
(109, 'Shampoo 200ml', 'Household', 120.00),
(110, 'Tea Powder 250g', 'Grocery', 85.00);


-- Table Orders
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
quantity INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(1001, 1, 101, 2, '2025-01-03'),
(1002, 2, 104, 4, '2025-01-05'),
(1003, 3, 106, 1, '2025-01-08'),
(1004, 4, 107, 3, '2025-01-10'),
(1005, 5, 109, 1, '2025-01-15'),
(1006, 6, 108, 5, '2025-01-18'),
(1007, 7, 110, 2, '2025-01-21'),
(1008, 8, 102, 1, '2025-01-25'),
(1009, 9, 103, 2, '2025-01-29'),
(1010, 10, 105, 3, '2025-02-01'),
(1011, 1, 104, 2, '2025-02-05'),
(1012, 2, 107, 1, '2025-02-09'),
(1013, 3, 110, 1, '2025-02-12'),
(1014, 4, 101, 3, '2025-02-15'),
(1015, 5, 108, 4, '2025-02-20');

/* ==============================
   A. BASIC QUERIES
   ============================== */

/* 1. Show all customers, orders and products */
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;


/* 2. Show all orders placed in the month of January */
SELECT
*
FROM orders
WHERE MONTH(order_date) = 1;

/* 3. Show all products that cost more than ₹100 */
SELECT 
*
FROM products
WHERE price > 100;


/* ==============================
   B. FILTERING & SORTING
   ============================== */

/* 4. Show the top 5 most expensive products */
SELECT 
*
FROM products
ORDER BY(price) DESC LIMIT 5;

/* 5. Show all orders sorted by date (latest first) */
SELECT 
* 
FROM orders
ORDER BY(order_date)DESC;


/* ==============================
   C. JOINS
   ============================== */

/* 6. Display order details with customer name and product name */
SELECT 
c.customer_name,
p.product_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN products AS p
ON o.product_id = p.product_id;

/* 7. Show all customers who bought a product from the category 'Snack' */
SELECT 
c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN products AS p
ON o.product_id = p.product_id
WHERE p.category = 'Snack';


/* ==============================
   D. AGGREGATION
   ============================== */

/* 8. Show total number of orders */
SELECT count(*)  AS TotalOrders
FROM orders;


/* 9. Show total quantity sold for each product */
SELECT
product_id,
SUM(quantity) AS Total_quantitysold
FROM orders
GROUP BY (product_id);


/* 10. Show total revenue earned per product (quantity * price) */
SELECT
o.product_id,
SUM(o.quantity * p.price) as TotalRevenue
FROM orders as o
LEFT JOIN products as p
ON o.product_id = p.product_id
GROUP BY o.product_id;



/* ==============================
   E. GROUPING
   ============================== */

/* 11. Show number of customers in each city */
SELECT 
city,
count(customer_id) as No_Customers
FROM customers
GROUP BY (city);


/* 12. Show total revenue by category */
SELECT 
p.category,
SUM(o.quantity * p.price) AS total_revenue
FROM orders AS o
LEFT JOIN products AS p
ON o.product_id = p.product_id
GROUP BY p.category;





/* ==============================
   F. HAVING CLAUSE
   ============================== */

/* 13. Show products that generated more than ₹500 in revenue */
SELECT
o.product_id,
SUM(o.quantity * p.price) as TotalRevenue
FROM orders as o
LEFT JOIN products as p
ON o.product_id = p.product_id
GROUP BY o.product_id
HAVING SUM(o.quantity * p.price) > 500;
    
    
    /* ==============================
   BONUS TASKS
   ============================== */

/* 16. Find the top 3 best-selling products */
SELECT
o.product_id,
SUM(o.quantity * p.price) as TotalRevenue
FROM orders as o
LEFT JOIN products as p
ON o.product_id = p.product_id
GROUP BY o.product_id
ORDER BY Totalrevenue desc limit 3;


/* 17. Find customers who never placed an order */
SELECT 
c.customer_id,
c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN products AS p
ON o.product_id = p.product_id
WHERE o.order_id is null;


/* 18. Find the most popular product category */

SELECT 
category,
count(*) AS PopularCategory
FROM orders AS o
LEFT JOIN products AS p
ON o.product_id = p.product_id
GROUP BY p.category 
Limit 1;