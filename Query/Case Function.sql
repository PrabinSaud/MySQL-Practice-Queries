/* ============================================================
   PROJECT TITLE: SQL CASE Function — Practice & Analysis Tasks
   DESCRIPTION: This set contains SQL questions focused on the 
   CASE expression, helping students learn conditional logic in 
   queries through real-world scenarios.
   ============================================================ */

use ola;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;


/* 1. Classify products as Cheap, Medium, or Expensive using CASE. Greater then 80 Expensive
, 40 to 80 Medium and less then 40 Cheap */

SELECT 
* ,
CASE
	WHEN price > 80 THEN 'Expensive'
	WHEN price between  40 and 80 THEN 'Medium'
	ELSE 'Cheap'
END  as ranges
FROM products
ORDER BY ranges;


/* 2. Label categories:
      Dairy → 'Food Item'
      Household → 'Home Use'
      Others → 'General' */
SELECT 
*,
CASE
	WHEN category = 'Dairy' THEN 'Food Item'
    WHEN category = 'Household' THEN 'Home Use'
    ELSE 'General'
END as label
FROM products
ORDER BY label;
      

/* 3. Create a discount column:
      Price > 80 → 10% discount
      Price between 50 and 80 → 5% discount
      Else → No discount */
SELECT 
*,
CASE
	WHEN price > 80 THEN '10%'
    WHEN price between 50 and 80 THEN '5%'
    ELSE 'No discount'
END as discount
FROM products
ORDER BY discount;

/* 4. Mark products as:
      'Essential' → Grocery, Dairy, Drink
      'Non-Essential' → Others */
SELECT 
*,
CASE
	WHEN category = 'Dairy' THEN 'Essential'
    WHEN category = 'Grocery' THEN 'Essential'
     WHEN category = 'Drink' THEN 'Essential'
    ELSE 'Non-Essential'
END as label
FROM products
ORDER BY label;

-- OR

SELECT 
    *,
    CASE
        WHEN category IN ('Dairy', 'Grocery', 'Drink') THEN 'Essential'
        ELSE 'Non-Essential'
    END AS label
FROM products
ORDER BY label;


/* 5. Show price status:
      Highest price → 'Most Expensive'
      Lowest price → 'Cheapest'
      Else → 'Normal Price' */
SELECT 
*,
CASE
	WHEN price = (SELECT MAX(price) FROM products) THEN 'Most Expensive'
	WHEN price = (SELECT MIN(price) FROM products) THEN 'Cheapest'
	ELSE 'Normal Price'
END AS price_status
FROM products
ORDER BY price DESC;


/* 6. Group categories:
      Food → Dairy, Bakery, Snack
      Home → Household
      Daily Use → Grocery, Drink */
      
      

/* 7. Tag products:
      Snack → 'Kids Favorite'
      Bakery → 'Breakfast Item'
      Others → 'Regular Product' */

/* 8. Create stock alert:
      Price > 100 → 'High Value Item'
      Price ≤ 30 → 'Fast Moving'
      Else → 'Standard' */

/* 9. GST rate:
      Household → 18%
      Drink → 12%
      Others → 5% */

/* 10. Identify measured items:
       Names containing '1Liter' or '1kg' → 'Measured Item'
       Else → 'Pack Item' */
