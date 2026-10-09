CREATE DATABASE Customer_db;

USE Customer_db;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

INSERT INTO Customer
(customer_name, email, phone, address)
VALUES
('Arun Kumar', 'arun@gmail.com', '9876543210', 'Chennai'),
('Priya', 'priya@gmail.com', '9876501234', 'Madurai'),
('Karthik', 'karthik@gmail.com', '9876512345', 'Coimbatore'),
('Divya', 'divya@gmail.com', '9876523456', 'Salem'),
('Rahul', 'rahul@gmail.com', '9876534567', 'Trichy');

SHOW TABLES;

SELECT * FROM Customer;