CREATE DATABASE SalesCustomerAnalytics;

USE SalesCustomerAnalytics;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    DetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

INSERT INTO Customers VALUES
(1, 'Mani', 'Chennai'),
(2, 'Arun', 'Coimbatore'),
(3, 'Kumar', 'Madurai'),
(4, 'Priya', 'Salem'),
(5, 'Divya', 'Trichy');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 50000.00),
(102, 'Mobile', 'Electronics', 20000.00),
(103, 'Headphones', 'Accessories', 2000.00),
(104, 'Keyboard', 'Accessories', 1500.00),
(105, 'Chair', 'Furniture', 5000.00);

INSERT INTO Orders VALUES
(1001, 1, '2026-01-10'),
(1002, 2, '2026-01-12'),
(1003, 3, '2026-01-15'),
(1004, 1, '2026-02-01'),
(1005, 4, '2026-02-05'),
(1006, 5, '2026-02-10');

INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 2),
(4, 1003, 104, 3),
(5, 1004, 101, 1),
(6, 1004, 105, 2),
(7, 1005, 103, 3),
(8, 1006, 102, 1);

SELECT
    COUNT(*) AS TotalProducts,
    SUM(Price) AS TotalProductValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinimumPrice,
    MAX(Price) AS MaximumPrice
FROM Products;

SELECT
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity) AS TotalItemsSold,
    SUM(od.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * p.Price) AS TotalPurchase
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalPurchase DESC;

SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantitySold DESC;

SELECT
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * p.Price) AS TotalSales,
    AVG(p.Price) AS AverageProductPrice
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;

SELECT
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    p.ProductName,
    p.Category,
    od.Quantity,
    p.Price,
    (od.Quantity * p.Price) AS Subtotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderID;

SELECT
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS SalesMonth,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * p.Price) AS MonthlySales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
ORDER BY SalesMonth;

SELECT
    City,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC;

SELECT
    p.ProductID,
    p.ProductName,
    p.Category
FROM Products p
LEFT JOIN OrderDetails od
    ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL;