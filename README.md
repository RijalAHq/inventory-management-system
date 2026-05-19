# Inventory Management System using SQL

## Project Description
This project is a SQL-based inventory management system built using MySQL. The system is designed to manage products, suppliers, stock quantities, and sales transactions.

## Features
- Product Management
- Inventory Tracking
- Sales Transaction Recording
- Revenue Calculation
- Low Stock Detection
- Transaction History

## Technologies Used
- MySQL
- SQL
- MySQL Workbench

## Database Tables
- Products
- Suppliers
- Inventory
- Transactions

## SQL Concepts Used
- PRIMARY KEY
- FOREIGN KEY
- JOIN
- Aggregate Functions
- CRUD Operations
- ON DELETE CASCADE

## Sample Query
```sql
SELECT
    p.product_name,
    i.quantity
FROM Products p
JOIN Inventory i
ON p.product_id = i.product_id;
