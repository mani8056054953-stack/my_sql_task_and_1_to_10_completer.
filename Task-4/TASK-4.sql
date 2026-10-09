DROP DATABASE IF EXISTS OrderManagement_db;

CREATE DATABASE OrderManagement_db;

USE OrderManagement_db;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO Customer
(customer_name, email, phone, address)
VALUES
('Arun Kumar', 'arun@gmail.com', '9876543210', 'Chennai'),
('Priya', 'priya@gmail.com', '9876501234', 'Madurai'),
('Karthik', 'karthik@gmail.com', '9876512345', 'Coimbatore');

INSERT INTO Product
(product_name, price)
VALUES
('Laptop', 55000.00),
('Smartphone', 25000.00),
('Headphones', 2000.00),
('Wireless Mouse', 1000.00);

INSERT INTO Orders
(customer_id, order_date, total_amount)
VALUES
(1, '2026-08-20', 57000.00),
(2, '2026-08-21', 25000.00),
(3, '2026-08-22', 3000.00);

INSERT INTO Order_Details
(order_id, product_id, quantity, amount)
VALUES
(1, 1, 1, 55000.00),
(1, 3, 1, 2000.00),
(2, 2, 1, 25000.00),
(3, 3, 1, 2000.00),
(3, 4, 1, 1000.00);

SHOW TABLES;

SELECT * FROM Customer;

SELECT * FROM Product;

SELECT * FROM Orders;

SELECT * FROM Order_Details;

UPDATE Orders
SET total_amount = 27000.00
WHERE order_id = 2;

SELECT * FROM Orders;

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    od.quantity,
    p.price,
    od.amount,
    o.total_amount
FROM Customer c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_Details od
    ON o.order_id = od.order_id
JOIN Product p
    ON od.product_id = p.product_id
ORDER BY c.customer_id, o.order_date;

SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity) AS total_quantity,
    SUM(od.amount) AS total_purchase_amount
FROM Customer c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_Details od
    ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name;

SELECT
    o.order_id,
    c.customer_name,
    c.email,
    o.order_date,
    p.product_name,
    p.price,
    od.quantity,
    od.amount,
    o.total_amount
FROM Orders o
JOIN Customer c
    ON o.customer_id = c.customer_id
JOIN Order_Details od
    ON o.order_id = od.order_id
JOIN Product p
    ON od.product_id = p.product_id
ORDER BY o.order_id;