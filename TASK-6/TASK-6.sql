CREATE DATABASE ProductReview_db;

USE ProductReview_db;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);


CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    review_text VARCHAR(500),
    review_date DATE NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);




CREATE TABLE Rating (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);




INSERT INTO Customer
(customer_name, email)
VALUES
('Arun Kumar', 'arun@gmail.com'),
('Priya', 'priya@gmail.com'),
('Karthik', 'karthik@gmail.com'),
('Divya', 'divya@gmail.com'),
('Rahul', 'rahul@gmail.com');




INSERT INTO Product
(product_name, price)
VALUES
('Laptop', 55000.00),
('Smartphone', 25000.00),
('Headphones', 2000.00),
('Wireless Mouse', 1000.00),
('Bluetooth Speaker', 3500.00);




INSERT INTO Review
(customer_id, product_id, review_text, review_date)
VALUES
(1, 1, 'Excellent laptop with good performance', '2026-08-20'),
(2, 2, 'Very good smartphone and camera', '2026-08-21'),
(3, 3, 'Good sound quality', '2026-08-22'),
(4, 4, 'Smooth and comfortable mouse', '2026-08-23'),
(5, 5, 'Good speaker with clear sound', '2026-08-24');




INSERT INTO Rating
(customer_id, product_id, rating)
VALUES
(1, 1, 5),
(2, 2, 5),
(3, 3, 4),
(4, 4, 4),
(5, 5, 5),
(2, 1, 4),
(3, 2, 5),
(4, 3, 3),
(5, 4, 4),
(1, 5, 5);


SELECT
    r.review_id,
    c.customer_name,
    p.product_name,
    r.review_text,
    r.review_date
FROM Review r
JOIN Customer c
    ON r.customer_id = c.customer_id
JOIN Product p
    ON r.product_id = p.product_id;


SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM Product p
JOIN Rating r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;


SELECT
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM Product p
JOIN Rating r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) >= 4.5
ORDER BY average_rating DESC;


SELECT
    p.product_name,
    c.customer_name,
    r.review_text,
    rt.rating,
    r.review_date
FROM Review r
JOIN Customer c
    ON r.customer_id = c.customer_id
JOIN Product p
    ON r.product_id = p.product_id
JOIN Rating rt
    ON rt.customer_id = r.customer_id
    AND rt.product_id = r.product_id
ORDER BY p.product_id;