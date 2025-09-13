-- Active: 1756103911067@@127.0.0.1@3306@vendor_market

CREATE DATABASE vendor_market;
 
SHOW DATABASES

--SubscriptionPlan TABLE

CREATE TABLE SubscriptionPlan (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration INT NOT NULL, -- months
    features TEXT
);

-- Vendor Table
CREATE TABLE Vendor (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    business_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    subscription_plan_id INT,
    FOREIGN KEY (subscription_plan_id) REFERENCES SubscriptionPlan(plan_id)
);

-- ProductStatus Table
CREATE TABLE ProductStatus (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);


--Product Table
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    status_id INT,
    vendor_id INT,
    FOREIGN KEY (status_id) REFERENCES ProductStatus(status_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);

--Category Table
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

--ProductCategory Table
CREATE TABLE ProductCategory (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);


--Customer Table
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255)
);


--Order Table
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);


--OrderItem Table
CREATE TABLE OrderItem (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

--Payment Table
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    method VARCHAR(50), 
    amount DECIMAL(10,2),
    payment_date DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

SHOW TABLES

SELECT * FROM subscriptionplan;
SELECT * FROM vendor;
SELECT * FROM category;
SELECT * FROM customer;
SELECT * FROM `order`;
SELECT * FROM orderitem;
SELECT * FROM payment;
SELECT * FROM product;
SELECT * FROM productstatus;

SELECT * FROM productcategory;


--Insert Subscription Plans
INSERT INTO SubscriptionPlan (plan_name, price, duration, features)
VALUES 
('Basic', 500.00, 1, 'Basic support, Limited features'),
('Enterprise', 5000.00, 12, 'Full support, Unlimited features');


--Insert ProductStatus values
INSERT INTO ProductStatus (status_name) VALUES ('active'), ('inactive');


--Insert Vendor
INSERT INTO Vendor (business_name, contact_person, email, phone, address, subscription_plan_id)
VALUES ('SmartTech Ltd.', 'Rahim Khan', 'rahim@smarttech.com', '017XXXXXXXX', 'Dhaka, Bangladesh', 1);


-- Insert করলে চলবে
INSERT INTO Vendor (business_name, contact_person, email, phone, address, subscription_plan_id)
VALUES ('MegaShop Ltd.', 'Rafiq', 'rafiq@megashop.com', '01711111111', 'Dhaka', 2);


-- Insert Customer Table
INSERT INTO Customer (name, email, phone, address)
VALUES ('Karim Uddin', 'karim@gmail.com', '01712345678', 'Dhaka, Bangladesh');

INSERT INTO Customer (name, email, phone, address)
VALUES ('Rahim Khan', 'rahim@gmail.com', '01787654321', 'Chittagong'),
       ('Sadia Akter', 'sadia@gmail.com', '01711223344', 'Dhaka');

INSERT INTO Customer (name, email, phone, address)
VALUES ('Anika Hossain', 'anika@gmail.com', '01799887766', 'Sylhet, Bangladesh');

--Insert Order table
INSERT INTO `Order` (customer_id, order_date, total_amount, status)
VALUES (1, '2025-09-02 10:00:00', 5000.00, 'Completed');

INSERT INTO `Order` (customer_id, order_date, total_amount, status)
VALUES (2, '2025-09-03 11:30:00', 3500.00, 'Pending'),
       (3, '2025-09-03 14:00:00', 15500.00, 'Completed');

--Insert Payment Table
INSERT INTO Payment (order_id, method, amount, payment_date, status)
VALUES (1, 'Card', 5000.00, '2025-09-02 10:30:00', 'Completed');


--Insert Product + Category 
INSERT INTO Product (name, description, price, stock_quantity, status_id, vendor_id)
VALUES ('Laptop', 'High performance laptop', 75000, 10, 1, 1);

INSERT INTO Product (name, description, price, stock_quantity, status_id, vendor_id)
VALUES 
('Mouse', 'Wireless Mouse', 1500, 50, 1, 1),
('Keyboard', 'Mechanical Keyboard', 3000, 30, 1, 1);


INSERT INTO Product (name, description, price, stock_quantity, status_id, vendor_id)
VALUES ('Headset', 'Gaming Headset', 4000, 20, 1, 1),
       ('Monitor', '27 inch LED Monitor', 20000, 10, 1, 1),
       ('Charger', 'Fast Charger', 1200, 100, 1, 1);


--Insert OrderItem Table
INSERT INTO OrderItem (order_id, product_id, quantity, unit_price, subtotal)
VALUES 
(1, 1, 2, 75000.00, 150000.00),
(1, 2, 1, 1500.00, 1500.00);

INSERT INTO OrderItem (order_id, product_id, quantity, unit_price, subtotal)
VALUES 
(2, 3, 1, 3000.00, 3000.00),      
(2, 6, 1, 1200.00, 1200.00),      
(3, 5, 1, 20000.00, 20000.00),    
(3, 4, 2, 4000.00, 8000.00); 




INSERT INTO Category (name, description) VALUES ('Electronics', 'Electronic gadgets and devices');


INSERT INTO ProductCategory (product_id, category_id) VALUES (1, 1);


--Update Product Stock
UPDATE Product
SET stock_quantity = 15
WHERE name = 'Laptop';

--Delete Customer
DELETE FROM Customer
WHERE email = 'oldcustomer@gmail.com';


--Queries (DQL)
 -- 1.Vendors + Plan

SELECT v.business_name, s.plan_name, s.price
FROM Vendor AS v
JOIN SubscriptionPlan AS s ON v.subscription_plan_id = s.plan_id;


-- Electronics Products
SELECT p.name, p.price, p.stock_quantity
FROM Product AS p
JOIN ProductCategory AS pc ON p.product_id = pc.product_id
JOIN Category AS c ON pc.category_id = c.category_id 
WHERE c.name = 'Electronics';

-- Orders by Karim Uddin
SELECT o.order_id, o.order_date, o.total_amount, o.status
FROM `Order` AS o
JOIN Customer AS c ON o.customer_id = c.customer_id
WHERE c.name = 'Karim Uddin';


-- Payment Details (order_id=1)
SELECT method, amount, status
FROM Payment
WHERE order_id = 1; 

-- Top 5 Best-Selling Products
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM OrderItem AS oi
JOIN Product AS p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_sold DESC
LIMIT 5;


-- Total sales per Vendor
SELECT v.business_name, SUM(oi.subtotal) AS total_sales
FROM OrderItem oi
JOIN Product AS p ON oi.product_id = p.product_id
JOIN Vendor AS v ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_id;

-- Customers with no Orders
SELECT c.name
FROM Customer AS c
LEFT JOIN `Order` o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Total active products
SELECT COUNT(*) AS active_products
FROM Product As p
JOIN ProductStatus ps ON p.status_id = ps.status_id
WHERE ps.status_name = 'active';


-- Vendors in Enterprise Plan
SELECT v.business_name, s.plan_name
FROM Vendor AS v
JOIN SubscriptionPlan AS s ON v.subscription_plan_id = s.plan_id
WHERE s.plan_name = 'Enterprise';


-- Average Order Amount per Customer
SELECT c.name, AVG(o.total_amount) AS avg_order_amount
FROM Customer c
JOIN `Order` o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;


-- Customers who purchased from multiple Vendors
SELECT c.name
FROM Customer c
JOIN `Order` o ON c.customer_id = o.customer_id
JOIN OrderItem oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.vendor_id) > 1;




















