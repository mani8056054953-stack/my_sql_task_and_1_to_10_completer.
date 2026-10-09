CREATE DATABASE Payment_db;

USE Payment_db;

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_mode VARCHAR(50) NOT NULL,
    payment_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);

INSERT INTO Payment
(customer_name, amount, payment_mode, payment_date, status)
VALUES
('Arun Kumar', 55000.00, 'Credit Card', '2026-08-20', 'Successful'),
('Priya', 25000.00, 'UPI', '2026-08-21', 'Successful'),
('Karthik', 2000.00, 'Debit Card', '2026-08-22', 'Failed'),
('Divya', 3500.00, 'UPI', '2026-08-23', 'Successful'),
('Rahul', 1000.00, 'Net Banking', '2026-08-24', 'Failed');

SELECT * FROM Payment;

SELECT *
FROM Payment
WHERE status = 'Successful';

SELECT *
FROM Payment
WHERE status = 'Failed';

SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_mode;

SELECT
    payment_id,
    customer_name,
    amount,
    payment_mode,
    payment_date,
    status
FROM Payment
ORDER BY payment_date;

SELECT
    status,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM Payment
GROUP BY status;

SELECT
    payment_id,
    customer_name,
    amount,
    payment_mode,
    payment_date,
    status
FROM Payment
ORDER BY payment_id;