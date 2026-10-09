CREATE DATABASE AdvancedSQLDB;
USE AdvancedSQLDB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO Customers VALUES
(1,'Arun'),(2,'Bala'),(3,'Kavin');

INSERT INTO Products VALUES
(101,'Laptop',60000),
(102,'Mobile',20000),
(103,'Mouse',1000);

INSERT INTO Orders VALUES
(1,1,101,1),
(2,2,102,2),
(3,1,103,3),
(4,3,102,1);



SELECT * FROM Products
WHERE price > (SELECT AVG(price) FROM Products);



SELECT product_name, price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);



SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC
LIMIT 1;



SELECT c.customer_name, p.product_name,
       o.quantity, p.price,
       p.price * o.quantity AS total
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;



SELECT p.product_name,
       SUM(o.quantity) AS total_quantity,
       SUM(p.price * o.quantity) AS total_sales
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;