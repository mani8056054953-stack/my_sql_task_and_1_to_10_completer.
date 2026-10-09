USE ecommerce_db;

CREATE TABLE category(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(225)
);

CREATE TABLE product(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    brand VARCHAR(25),
    FOREIGN KEY(category_id)
    REFERENCES category(category_id)
);

INSERT INTO category(category_name, description)
VALUES
("Electronics", "Electronic Products and Accessories"),
("Mobiles", "Mobile Phones and Tablets"),
("Faashion", "Clothing and Fashion Products"),
("Appliances", "Home and Kitchen Appliances");

INSERT INTO product(product_name, category_id, price, stock, brand)
VALUES
("iPhone 15", 2, 69999.00, 25, "Apple"),
("Galaxy S24", 2, 64999.00, 30, "Samsung"),
("Wireless Headphones", 1, 2999.00, 50, "Sony"),
("Smart TV 43 inch", 1, 32999.00, 15, "LG"),
("Men Casual Shirt", 3, 399.00, 100, "Roadster"),
("Washing Machine", 4, 28999.00, 15, "Whirlpool");

SELECT * FROM product;

UPDATE category
SET category_name = "Fashion"
WHERE category_id = 3;

SELECT * FROM category;

DELETE FROM product
WHERE product_id = 6;

SELECT category_name, COUNT(*) AS total_product
FROM category
JOIN product
ON category.category_id = product.category_id
GROUP BY category_name;

SELECT * FROM product;




