CREATE DATABASE ecommerce;

USE ecommerce;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    availability VARCHAR(20)
);

INSERT INTO customers
(customer_id, customer_name, email, city)
VALUES
(1, 'Mani', 'mani@gmail.com', 'Chennai'),
(2, 'Arun', 'arun@gmail.com', 'Madurai'),
(3, 'Karthik', 'karthik@gmail.com', 'Coimbatore'),
(4, 'Priya', 'priya@gmail.com', 'Chennai'),
(5, 'Suresh', 'suresh@gmail.com', 'Trichy'),
(6, 'Divya', 'divya@gmail.com', 'Chennai');


INSERT INTO products
(product_id, product_name, category, price, availability)
VALUES
(101, 'Laptop', 'Electronics', 55000.00, 'Available'),
(102, 'Mobile Phone', 'Electronics', 22000.00, 'Available'),
(103, 'Headphones', 'Accessories', 1500.00, 'Available'),
(104, 'Keyboard', 'Accessories', 1200.00, 'Out of Stock'),
(105, 'Office Chair', 'Furniture', 8500.00, 'Available'),
(106, 'Smart Watch', 'Electronics', 4500.00, 'Available'),
(107, 'Mouse', 'Accessories', 800.00, 'Available'),
(108, 'Table Lamp', 'Home Appliances', 1800.00, 'Available'),
(109, 'Printer', 'Electronics', 12500.00, 'Out of Stock'),
(110, 'Study Table', 'Furniture', 6500.00, 'Available');


SELECT *
FROM customers;


SELECT *
FROM products;

SELECT product_name, category, price
FROM products;


SELECT customer_name, city
FROM customers;


SELECT *
FROM products
WHERE price > 5000;


SELECT *
FROM products
WHERE price < 5000;

SELECT *
FROM products
WHERE price = 1500;


SELECT *
FROM products
ORDER BY price ASC;

SELECT *
FROM products
ORDER BY price DESC;


SELECT *
FROM products
ORDER BY product_name ASC;


SELECT DISTINCT category
FROM products;


SELECT DISTINCT city
FROM customers;


SELECT DISTINCT availability
FROM products;

SELECT *
FROM products
WHERE price BETWEEN 1000 AND 10000;

SELECT *
FROM products
WHERE price > 10000;


SELECT *
FROM products
WHERE price < 2000;



SELECT *
FROM products
WHERE category = 'Electronics';


SELECT *
FROM products
WHERE category = 'Accessories';

SELECT *
FROM products
WHERE category = 'Furniture';


SELECT *
FROM products
WHERE availability = 'Available';


SELECT *
FROM products
WHERE availability = 'Out of Stock';


SELECT *
FROM customers;


SELECT *
FROM customers
WHERE city = 'Chennai';


SELECT *
FROM customers
WHERE city = 'Madurai';


SELECT customer_name, email
FROM customers;


SELECT product_name, category, price
FROM products;


SELECT product_name, availability
FROM products;


SELECT *
FROM products
WHERE category = 'Electronics'
AND availability = 'Available';


SELECT *
FROM products
WHERE category = 'Electronics'
AND price > 10000;


SELECT *
FROM products
WHERE category = 'Electronics'
OR category = 'Accessories';


SELECT *
FROM products
WHERE price < 2000
OR price > 20000;




SELECT *
FROM products
WHERE NOT category = 'Electronics';

SELECT *
FROM products
WHERE NOT availability = 'Available';

SELECT *
FROM products
WHERE product_name LIKE '%Phone%';


SELECT *
FROM products
WHERE product_name LIKE 'Smart%';


SELECT *
FROM products
WHERE product_name LIKE '%Table';




SELECT *
FROM products
WHERE category IN ('Electronics', 'Furniture');


SELECT *
FROM customers
WHERE city IN ('Chennai', 'Madurai');



SELECT COUNT(*) AS total_products
FROM products;


SELECT COUNT(*) AS total_customers
FROM customers;




SELECT AVG(price) AS average_price
FROM products;




SELECT MAX(price) AS highest_price
FROM products;




SELECT MIN(price) AS lowest_price
FROM products;



SELECT SUM(price) AS total_product_value
FROM products;


SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category;


SELECT
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category;



SELECT
    category,
    MAX(price) AS highest_price
FROM products
GROUP BY category;



SELECT
    category,
    MIN(price) AS lowest_price
FROM products
GROUP BY category;


SELECT
    availability,
    COUNT(*) AS product_count
FROM products
GROUP BY availability;


SELECT
    category,
    COUNT(*) AS available_products
FROM products
WHERE availability = 'Available'
GROUP BY category;



SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city;


SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category
HAVING COUNT(*) > 2;


SELECT
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category
HAVING AVG(price) > 5000;



SELECT
    category,
    COUNT(*) AS total_products,
    AVG(price) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM products
GROUP BY category
ORDER BY average_price DESC;



SELECT
    product_id,
    product_name,
    category,
    price,
    availability
FROM products
WHERE availability = 'Available'
ORDER BY price DESC;


SELECT
    p.product_id AS Product_ID,
    p.product_name AS Product_Name,
    p.category AS Category,
    p.price AS Price,
    p.availability AS Availability,
    c.customer_id AS Customer_ID,
    c.customer_name AS Customer_Name,
    c.email AS Email,
    c.city AS City
FROM products p
CROSS JOIN customers c
WHERE p.price >= 1000
  AND p.availability = 'Available'
  AND p.category IN ('Electronics', 'Accessories', 'Furniture')
ORDER BY p.price DESC;

