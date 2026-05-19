-- =====================================================
-- INVENTORY MANAGEMENT SYSTEM
-- =====================================================

-- Create database
CREATE DATABASE InventoryDB;
USE InventoryDB;

-- Products table: store product information
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_status VARCHAR(20) NOT NULL
);

-- Suppliers table: store supplier information
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);

-- Inventory table: manage product stock
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    quantity INT NOT NULL,
    last_update DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE
);

-- Transactions table: record sales and purchases
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    transaction_type ENUM('sale','purchase') NOT NULL,
    quantity INT NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Insert sample product data
INSERT INTO Products(product_name, category, price, stock_status)
VALUES
('Gaming Mouse','Electronics',250000,'Available'),
('Office Chair','Furniture',850000,'Available'),
('Printer Ink','Stationery',120000,'Low Stock');

-- Insert sample supplier data
INSERT INTO Suppliers(supplier_name, city, phone_number)
VALUES
('Digital Tech','Jakarta','08123456789'),
('Office Mart','Bandung','08234567891');

-- Insert initial inventory stock
INSERT INTO Inventory(product_id, supplier_id, quantity, last_update)
VALUES
(1,1,15,'2026-05-19'),
(2,2,10,'2026-05-19'),
(3,1,4,'2026-05-19');

-- Insert purchases transactions
INSERT INTO Transactions(product_id, transaction_type, quantity, transaction_date)
VALUES
(1,'purchase',15,'2026-05-19'),
(2,'purchase',10,'2026-05-19'),
(3,'purchase',4,'2026-05-19');

-- Insert sales transactions
INSERT INTO Transactions(product_id, transaction_type, quantity, transaction_date)
VALUES
(1,'sale',3,'2026-05-19'),
(2,'sale',1,'2026-05-19');

-- Display all products with stock quantity
SELECT 
    p.product_name,
    p.category,
    i.quantity
FROM Products p
JOIN Inventory i
ON p.product_id = i.product_id;

-- Display products with low stock
SELECT 
    p.product_name,
    i.quantity
FROM Products p
JOIN Inventory i
ON p.product_id = i.product_id
WHERE i.quantity < 5;

-- Calculate total inventory value
SELECT 
    p.product_name,
    p.price,
    i.quantity,
    (p.price * i.quantity) AS total_stock_value
FROM Products p
JOIN Inventory i
ON p.product_id = i.product_id;

-- Display best-selling product
SELECT 
    p.product_name,
    SUM(t.quantity) AS total_sold
FROM Transactions t
JOIN Products p
ON t.product_id = p.product_id
WHERE t.transaction_type = 'sale'
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;

-- Record sales transaction
INSERT INTO Transactions
(product_id, transaction_type, quantity, transaction_date)
VALUES
(1, 'sale', 2, CURRENT_DATE);

-- Update stock after a sale
UPDATE Inventory
SET quantity = quantity - 2
WHERE product_id = 1;

-- Display transaction history
SELECT 
    p.product_name,
    t.transaction_type,
    t.quantity,
    t.transaction_date
FROM Transactions t
JOIN Products p
ON t.product_id = p.product_id;

-- Calculate total revenue
SELECT 
    SUM(t.quantity * p.price) AS total_revenue
FROM Transactions t
JOIN Products p
ON t.product_id = p.product_id
WHERE t.transaction_type = 'sale';

-- Display supplier information for products
SELECT
    p.product_name,
    s.supplier_name,
    s.city
FROM Inventory i
JOIN Products p
ON i.product_id = p.product_id
JOIN Suppliers s
ON i.supplier_id = s.supplier_id;

-- Display products from Electronics category
SELECT
    product_name,
    price
FROM Products
WHERE category = 'Electronics';

-- Delete related transaction records
DELETE FROM Products
WHERE product_id = 3;