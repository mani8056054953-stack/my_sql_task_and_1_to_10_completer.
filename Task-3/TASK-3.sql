CREATE DATABASE SellerInventory_db;

USE SellerInventory_db;

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL,

    FOREIGN KEY (seller_id)
        REFERENCES Seller(seller_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO Seller (seller_name, email, phone, address)
VALUES
('Tech World', 'techworld@gmail.com', '9876543210', 'Chennai'),
('Smart Store', 'smartstore@gmail.com', '9876501234', 'Madurai'),
('Digital Hub', 'digitalhub@gmail.com', '9876512345', 'Coimbatore');

INSERT INTO Product (product_name, price)
VALUES
('Gaming Laptop', 75000.00),
('Smartphone', 30000.00),
('Bluetooth Speaker', 3500.00),
('Wireless Mouse', 1200.00);

INSERT INTO Inventory (seller_id, product_id, stock, status)
VALUES
(1, 1, 15, 'Available'),
(1, 2, 0, 'Unavailable'),
(2, 3, 20, 'Available'),
(3, 4, 30, 'Available');

SHOW TABLES;

SELECT * FROM Seller;

SELECT * FROM Product;

SELECT * FROM Inventory;

SELECT
    s.seller_name,
    p.product_name,
    p.price,
    i.stock,
    i.status
FROM Inventory i
JOIN Seller s ON i.seller_id = s.seller_id
JOIN Product p ON i.product_id = p.product_id;

SELECT
    s.seller_name,
    p.product_name,
    i.stock,
    i.status
FROM Inventory i
JOIN Seller s ON i.seller_id = s.seller_id
JOIN Product p ON i.product_id = p.product_id
WHERE i.status = 'Available';

SELECT
    s.seller_name,
    p.product_name,
    i.stock,
    i.status
FROM Inventory i
JOIN Seller s ON i.seller_id = s.seller_id
JOIN Product p ON i.product_id = p.product_id
WHERE i.status = 'Unavailable';

SELECT
    s.seller_name,
    COUNT(i.product_id) AS total_products,
    SUM(i.stock) AS total_stock
FROM Seller s
JOIN Inventory i ON s.seller_id = i.seller_id
GROUP BY s.seller_id, s.seller_name;


SELECT
    i.inventory_id,
    s.seller_id,
    s.seller_name,
    s.email,
    s.phone,
    s.address,
    p.product_id,
    p.product_name,
    p.price,
    i.stock,
    i.status
FROM Inventory i
JOIN Seller s
    ON i.seller_id = s.seller_id
JOIN Product p
    ON i.product_id = p.product_id
ORDER BY i.inventory_id;