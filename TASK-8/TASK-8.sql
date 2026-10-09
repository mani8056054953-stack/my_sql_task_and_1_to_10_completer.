CREATE DATABASE Relationship_Analysis_using_Joins;

USE Relationship_Analysis_using_Joins;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50)
);


CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,

    FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID),

    FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(20),

    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);




INSERT INTO Customer VALUES
(1, 'Mani', 'mani@gmail.com', 'Chennai'),
(2, 'Kumar', 'kumar@gmail.com', 'Madurai'),
(3, 'Arun', 'arun@gmail.com', 'Coimbatore'),
(4, 'Priya', 'priya@gmail.com', 'Salem');



INSERT INTO Product VALUES
(101, 'Laptop', 55000.00),
(102, 'Mobile', 20000.00),
(103, 'Headphones', 2500.00),
(104, 'Keyboard', 1500.00);


INSERT INTO Orders VALUES
(1001, 1, 101, '2026-09-01', 1),
(1002, 2, 102, '2026-09-03', 2),
(1003, 1, 103, '2026-09-05', 1),
(1004, 3, 104, '2026-09-07', 1);



INSERT INTO Payment VALUES
(501, 1001, '2026-09-01', 55000.00, 'Paid'),
(502, 1002, '2026-09-03', 40000.00, 'Paid'),
(503, 1003, '2026-09-05', 2500.00, 'Paid'),
(504, 1004, '2026-09-07', 1500.00, 'Pending');




SELECT * FROM Customer;

SELECT * FROM Product;

SELECT * FROM Orders;

SELECT * FROM Payment;



SELECT
    c.CustomerID,
    c.CustomerName,
    c.Email,
    c.City,
    o.OrderID,
    o.OrderDate,
    p.ProductID,
    p.ProductName,
    p.Price,
    o.Quantity,
    pay.PaymentID,
    pay.PaymentDate,
    pay.Amount,
    pay.PaymentStatus
FROM Customer c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN Product p
    ON o.ProductID = p.ProductID
INNER JOIN Payment pay
    ON o.OrderID = pay.OrderID;



SELECT
    c.CustomerID,
    c.CustomerName,
    c.Email,
    c.City,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    p.Price,
    o.Quantity
FROM Customer c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
LEFT JOIN Product p
    ON o.ProductID = p.ProductID;




SELECT
    p.ProductID,
    p.ProductName,
    p.Price,
    o.OrderID,
    o.OrderDate,
    o.Quantity,
    c.CustomerName
FROM Orders o
RIGHT JOIN Product p
    ON o.ProductID = p.ProductID
LEFT JOIN Customer c
    ON o.CustomerID = c.CustomerID;




SELECT
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.Email,
    c.City,
    p.ProductName,
    p.Price,
    o.Quantity,
    (p.Price * o.Quantity) AS TotalPrice,
    pay.PaymentDate,
    pay.Amount,
    pay.PaymentStatus
FROM Orders o
INNER JOIN Customer c
    ON o.CustomerID = c.CustomerID
INNER JOIN Product p
    ON o.ProductID = p.ProductID
INNER JOIN Payment pay
    ON o.OrderID = pay.OrderID;




SELECT
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    p.Price,
    o.Quantity,
    (p.Price * o.Quantity) AS TotalAmount,
    pay.PaymentStatus
FROM Customer c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN Product p
    ON o.ProductID = p.ProductID
INNER JOIN Payment pay
    ON o.OrderID = pay.OrderID
ORDER BY c.CustomerName, o.OrderDate;



SELECT
    c.CustomerName,
    c.City,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(p.Price * o.Quantity) AS TotalPurchase
FROM Customer c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
LEFT JOIN Product p
    ON o.ProductID = p.ProductID
GROUP BY
    c.CustomerID,
    c.CustomerName,
    c.City;



SELECT
    c.CustomerName,
    o.OrderID,
    p.ProductName,
    pay.PaymentDate,
    pay.Amount,
    pay.PaymentStatus
FROM Customer c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN Product p
    ON o.ProductID = p.ProductID
INNER JOIN Payment pay
    ON o.OrderID = pay.OrderID
ORDER BY pay.PaymentDate;



SELECT
    c.CustomerName,
    o.OrderID,
    p.ProductName,
    pay.Amount,
    pay.PaymentStatus
FROM Customer c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN Product p
    ON o.ProductID = p.ProductID
INNER JOIN Payment pay
    ON o.OrderID = pay.OrderID
WHERE pay.PaymentStatus = 'Paid';




SELECT
    SUM(pay.Amount) AS TotalSales
FROM Payment pay
WHERE pay.PaymentStatus = 'Paid';




SELECT
    c.CustomerID,
    c.CustomerName,
    c.City,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    p.Price,
    o.Quantity,
    (p.Price * o.Quantity) AS TotalPrice,
    pay.Amount AS PaidAmount,
    pay.PaymentStatus
FROM Customer c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
LEFT JOIN Product p
    ON o.ProductID = p.ProductID
LEFT JOIN Payment pay
    ON o.OrderID = pay.OrderID
ORDER BY o.OrderID;