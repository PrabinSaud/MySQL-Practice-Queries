-- At first we have create a database 

CREATE DATABASE salesDB;  --  Here We create a database name saleDB
USE salesDB;             -- Here We used the created database

-- TABLE: Products

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Quantity INT,
Price DECIMAL(10,2)
);

INSERT INTO Products 
VALUES('ProductId','ProductName','Category','Quantity'),
(1,'Laptop A14','Electronics',50,55000),
(2,'Laptop A15','Electronics',35,62000),
(3,'Keyboard K1','Accessories',120,1200),
(4,'Mouse M2','Accessories',200,900),
(5,'Monitor 24"','Electronics',40,10500),
(6,'Printer P100','Office',25,8500),
(7,'Chair ComfortX','Furniture',60,4500),
(8,'Desk Pro','Furniture',30,7800),
(9,'Router R10','Electronics',80,2400),
(10,'Headphones H1','Accessories',150,1500),
(11,'USB Cable U3','Accessories',300,200),
(12,'SSD 512GB','Electronics',70,4200),
(13,'Tablet T7','Electronics',25,18000),
(14,'Notebook Pack','Stationery',500,120),
(15,'Pen Set','Stationery',600,60),
(16,'Projector P2','Electronics',15,32000),
(17,'Coffee Machine C1','Office',10,8500),
(18,'Water Bottle W1','Accessories',100,300),
(19,'Mousepad M1','Accessories',250,150),
(20,'Webcam W10','Electronics',50,2500);

-- TABLE: Customers

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Country VARCHAR(50),
City VARCHAR(50),
Score INT
);

INSERT INTO Customers 
VALUES('CustomerID', 'FirstName', 'LastName', 'Country','City','Score'),
(1,'Raj','Sharma','India','Delhi',85),
(2,'Aisha','Khan','India','Mumbai',90),
(3,'John','Patel','USA','Chicago',78),
(4,'Emma','Smith','UK','London',82),
(5,'Ravi','Verma','India','Jaipur',88),
(6,'Neha','Yadav','India','Lucknow',92),
(7,'Carlos','Diaz','Spain','Madrid',75),
(8,'Maria','Lopez','Mexico','Cancun',80),
(9,'Tina','Mehta','India','Pune',89),
(10,'Vivek','Rao','India','Hyderabad',91),
(11,'Ahmed','Ali','UAE','Dubai',77),
(12,'Noor','Fatima','Pakistan','Lahore',84),
(13,'David','Wilson','Australia','Sydney',83),
(14,'Sarah','Brown','Canada','Toronto',86),
(15,'Ankit','Gupta','India','Kolkata',87),
(16,'Sonal','Desai','India','Ahmedabad',93),
(17,'Vikram','Nair','India','Kochi',88),
(18,'Priya','Sinha','India','Patna',90),
(19,'Arjun','Reddy','India','Chennai',89),
(20,'Krishna','Bhat','India','Mangalore',92);

-- TABLE: Employees

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);

INSERT INTO Employees 
VALUES('EmployeeID', 'FirstName','LastName','Gender', 'Salary',' Department'),
(1,'Rohit','Kumar','M',45000,'Sales'),
(2,'Sneha','Rao','F',42000,'Sales'),
(3,'David','Miller','M',55000,'IT'),
(4,'Siya','Jain','F',47000,'HR'),
(5,'Anand','Gupta','M',48000,'Sales'),
(6,'Riya','Shah','F',46000,'Finance'),
(7,'Karan','Patel','M',52000,'IT'),
(8,'Emily','Jones','F',58000,'IT'),
(9,'Priya','Kapoor','F',43000,'HR'),
(10,'Arjun','Singh','M',51000,'Sales'),
(11,'Vivek','Das','M',49000,'Logistics'),
(12,'Nisha','Thomas','F',47000,'Logistics'),
(13,'Mohit','Suri','M',60000,'IT'),
(14,'Rachna','Iyer','F',44000,'Sales'),
(15,'Manish','Tiwari','M',45000,'Finance'),
(16,'Leena','Banerjee','F',53000,'HR'),
(17,'Pooja','Rathi','F',41000,'Support'),
(18,'Samir','Khan','M',47000,'Support'),
(19,'Aman','Joshi','M',54000,'Sales'),
(20,'Kavya','Pillai','F',49500,'Logistics');


-- TABLE: Orders

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipDate DATE,
    ShipAddress VARCHAR(100),
    BillAddress VARCHAR(100),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Orders 
VALUES('OrderID','ProductID','CustomerID','EmployeeID','OrderDate','ShipDate','ShipAdress','BillAddress'),
(1,1,3,2,'2025-01-10','2025-01-12','Chicago','Chicago'),
(2,5,1,4,'2025-01-11','2025-01-13','Delhi','Delhi'),
(3,10,7,1,'2025-01-13','2025-01-15','Madrid','Madrid'),
(4,3,12,5,'2025-01-14','2025-01-16','Lahore','Lahore'),
(5,2,6,3,'2025-01-15','2025-01-17','Lucknow','Lucknow'),
(6,8,10,7,'2025-01-16','2025-01-18','Hyderabad','Hyderabad'),
(7,12,2,8,'2025-01-17','2025-01-19','Mumbai','Mumbai'),
(8,4,4,9,'2025-01-18','2025-01-20','London','London'),
(9,6,5,6,'2025-01-19','2025-01-21','Jaipur','Jaipur'),
(10,14,8,11,'2025-01-20','2025-01-22','Cancun','Cancun'),
(11,16,9,14,'2025-01-22','2025-01-24','Pune','Pune'),
(12,11,15,12,'2025-01-23','2025-01-25','Kolkata','Kolkata'),
(13,13,11,15,'2025-01-24','2025-01-26','Dubai','Dubai'),
(14,19,14,16,'2025-01-25','2025-01-27','Toronto','Toronto'),
(15,20,13,18,'2025-01-26','2025-01-28','Sydney','Sydney'),
(16,9,18,10,'2025-01-27','2025-01-29','Patna','Patna'),
(17,7,20,19,'2025-01-28','2025-01-30','Mangalore','Mangalore'),
(18,15,16,17,'2025-01-29','2025-01-31','Ahmedabad','Ahmedabad'),
(19,18,17,13,'2025-01-30','2025-02-01','Kochi','Kochi'),
(20,17,19,20,'2025-01-31','2025-02-02','Chennai','Chennai');

-- TABLE: OrderArchives

CREATE TABLE OrderArchives (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipDate DATE,
    ShipAddress VARCHAR(100),
    BillAddress VARCHAR(100)
);

INSERT INTO OrderArchives
VALUES('OrderID','ProductID','CustomerID','EmployeeID','OrderDate','ShipDate','ShipAdress','BillAddress'),
(1,3,2,5,'2024-09-10','2024-09-12','Mumbai','Mumbai'),
(2,7,6,3,'2024-09-11','2024-09-13','Lucknow','Lucknow'),
(3,1,9,1,'2024-09-12','2024-09-14','Pune','Pune'),
(4,4,10,8,'2024-09-13','2024-09-15','Hyderabad','Hyderabad'),
(5,5,3,6,'2024-09-14','2024-09-16','Chicago','Chicago'),
(6,8,1,9,'2024-09-15','2024-09-17','Delhi','Delhi'),
(7,12,7,11,'2024-09-16','2024-09-18','Madrid','Madrid'),
(8,10,4,2,'2024-09-17','2024-09-19','London','London'),
(9,16,12,4,'2024-09-18','2024-09-20','Lahore','Lahore'),
(10,6,5,13,'2024-09-19','2024-09-21','Jaipur','Jaipur'),
(11,15,13,7,'2024-09-20','2024-09-22','Sydney','Sydney'),
(12,14,8,10,'2024-09-21','2024-09-23','Cancun','Cancun'),
(13,9,11,12,'2024-09-22','2024-09-24','Dubai','Dubai'),
(14,18,14,14,'2024-09-23','2024-09-25','Toronto','Toronto'),
(15,20,15,15,'2024-09-24','2024-09-26','Kolkata','Kolkata'),
(16,2,16,16,'2024-09-25','2024-09-27','Ahmedabad','Ahmedabad'),
(17,11,17,17,'2024-09-26','2024-09-28','Kochi','Kochi'),
(18,19,18,18,'2024-09-27','2024-09-29','Patna','Patna'),
(19,13,19,19,'2024-09-28','2024-09-30','Chennai','Chennai'),
(20,17,20,20,'2024-09-29','2024-10-01','Mangalore','Mangalore');

SELECT * FROM customers;             -- To show the customers table

SELECT * FROM products;        -- To show the products table


SELECT * FROM orders; -- TO show the orders table


SELECT * FROM orderarchives;                 -- To show the orderarchive table

SELECT * FROM employees;               -- To show the employees table


-- Joins Query

SELECT * FROM customers AS c
JOIN orders AS o
ON c.CustomerID = o.CustomerID;


-- Join two table customers and orders using left join.
SELECT 
c.customerID,
c.FirstName,
c.LastName,
o.OrderID,
o.OrderDate,
o.ShipDate
FROM customers as c
LEFT JOIN orders as o
ON c.CustomerID = o.Customerid; 



-- joining three table using left join where country is india .
-- Finding customer and orders where country is india

SELECT 
c.customerID,
o.OrderID,
p.ProductID,
c.FirstName,
p.ProductName,
c.Country,
o.OrderDate,
o.ShipDate
FROM customers AS c
LEFT JOIN orders AS o
ON c.CustomerID = o.Customerid
LEFT JOIN products AS p
ON o.ProductID = p.ProductID
WHERE Country = 'India';


-- Total Stock sold by category

SELECT 
Category, 
SUM(Quantity) AS TotalStock
FROM products
GROUP BY Category;







