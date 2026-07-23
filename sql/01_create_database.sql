-- ==========================================
-- NOVOTECH SALES ANALYTICS
-- Database Creation Script
-- ==========================================

-- ==========================================
-- Create database
-- ==========================================

DROP DATABASE IF EXISTS novotech_sales;

CREATE DATABASE novotech_sales;

-- ==========================================
-- Select database
-- ==========================================

USE novotech_sales;

-- ==========================================
-- Create customers table
-- ==========================================

CREATE TABLE customers (
    customer_id INT,
    age INT,
    gender VARCHAR(10),
    loyalty_member BOOLEAN,

    PRIMARY KEY (customer_id)
);

-- ==========================================
-- Create products table
-- ==========================================

CREATE TABLE products (
    product_id INT,
    sku VARCHAR(50),
    product_type VARCHAR(100),

    PRIMARY KEY (product_id),
    UNIQUE (sku)
);

-- ==========================================
-- Create orders table
-- ==========================================

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    rating INT,
    order_status VARCHAR(30),
    payment_method VARCHAR(50),
    total_price DECIMAL(10,2),
    unit_price DECIMAL(10,2),
    quantity INT,
    purchase_date DATE,
    shipping_type VARCHAR(30),
    add_ons_purchased TEXT,
    add_on_total DECIMAL(10,2),

    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ==========================================
-- Verify database structure
-- ==========================================

SHOW TABLES;

DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;