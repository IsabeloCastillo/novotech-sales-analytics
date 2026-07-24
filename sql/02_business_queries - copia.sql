-- ==========================================
-- NOVOTECH SALES ANALYTICS
-- Business Analysis Queries
-- ==========================================

-- ==========================================
-- Business Question 1
-- How many orders are stored in the database?
-- ==========================================

SELECT COUNT(*) AS total_orders
FROM orders;

-- Result:
-- 12135

-- Interpretation:
-- The database contains 12,135 customer orders available for analysis.

-- ==========================================
-- Business Question 2
-- How many customers are registered?
-- ==========================================

SELECT COUNT(*) AS total_customers
FROM customers;

-- Result:
-- 12136

-- Interpretation:
-- The database contains 12,136 registered customers.

-- ==========================================
-- Business Question 3
-- How many products are available in the catalog?
-- ==========================================

SELECT COUNT(*) AS total_products
FROM products;

-- ==========================================
-- Business Question 3
-- How many products are available in the catalog?
-- ==========================================

SELECT COUNT(*) AS total_products
FROM products;

-- Result:
-- 10

-- Interpretation:
-- The product catalog contains 10 unique products available for sale.

-- ==========================================
-- Business Question 4
-- How is the company's revenue composed?
-- ==========================================

SELECT
    SUM(total_price) AS total_product_revenue,
    SUM(add_on_total) AS total_addon_revenue,
    SUM(total_price + add_on_total) AS total_company_revenue
FROM orders;

-- Result:
-- Product Revenue: 38,498,549.82
-- Add-on Revenue: 756,489.87
-- Total Company Revenue: 39,255,039.69

-- Interpretation:
-- During the analysis period, the company generated a total revenue of
-- 39,255,039.69. Most of the revenue comes from product sales
-- (38,498,549.82), while add-on purchases contributed an additional
-- 756,489.87.

-- ==========================================
-- Business Question 5
-- What is the average order value (AOV)?
-- ==========================================

SELECT
    ROUND(AVG(total_price + add_on_total), 2) AS average_order_value
FROM orders;

-- Result:
-- 3234.86

-- Interpretation:
-- On average, each customer order generated 3,234.86 in total revenue,
-- including both product sales and add-on purchases.


-- ==========================================
-- Business Question 6
-- Which payment methods are preferred by customers?
-- ==========================================

SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- Result:
-- Credit Card    3570
-- PayPal         3553
-- Bank Transfer  2008
-- Cash           1525
-- Debit Card     1479

-- Interpretation:
-- Credit Card and PayPal are the most frequently used payment methods,
-- accounting for the majority of customer orders. Bank Transfer has
-- moderate usage, while Cash and Debit Card are the least preferred
-- payment options.

-- ==========================================
-- Business Question 7
-- Which payment method generates the highest revenue?
-- ==========================================

SELECT
    payment_method,
    SUM(total_price) AS total_price_revenue,
    SUM(add_on_total) AS total_add_revenue,
    SUM(total_price + add_on_total) AS total_company_revenue
FROM orders
GROUP BY payment_method
ORDER BY total_company_revenue DESC;

-- Result:
-- Credit Card    11,522,768.53    228,410.96    11,751,179.49
-- PayPal         11,500,774.55    232,169.54    11,732,944.09
-- Bank Transfer   7,540,155.30    170,735.18     7,710,890.48
-- Debit Card      4,066,209.26     60,393.71     4,126,602.97
-- Cash            3,868,642.18     64,780.48     3,933,422.66

-- Interpretation:
-- Credit Card is the payment method that generates the highest revenue,
-- closely followed by PayPal. Although both methods have a similar number
-- of orders, Credit Card produces slightly higher total revenue.
-- Bank Transfer ranks third, while Debit Card and Cash generate the
-- lowest revenue.

-- ==========================================
-- Business Question 8
-- Do loyalty program members generate more revenue?
-- ==========================================

SELECT
    customers.loyalty_member,
    COUNT(orders.order_id) AS total_orders,
    SUM(orders.total_price) AS total_product_revenue,
    SUM(orders.add_on_total) AS total_addon_revenue,
    SUM(orders.total_price + orders.add_on_total) AS total_company_revenue,
    ROUND(AVG(orders.total_price + orders.add_on_total), 2) AS average_order_value
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.loyalty_member
ORDER BY total_company_revenue DESC;

-- Result:
-- Loyalty Member = 0
-- Total Orders: 9580
-- Product Revenue: 30,578,108.06
-- Add-on Revenue: 594,688.67
-- Total Company Revenue: 31,172,796.73
-- Average Order Value: 3253.95
--
-- Loyalty Member = 1
-- Total Orders: 2555
-- Product Revenue: 7,920,441.76
-- Add-on Revenue: 161,801.20
-- Total Company Revenue: 8,082,242.96
-- Average Order Value: 3163.30

-- Interpretation:
-- Non-loyalty customers generated the highest total revenue, mainly because
-- they placed significantly more orders than loyalty program members.
-- The Average Order Value (AOV) is also slightly higher for non-loyalty
-- customers (3253.95 vs. 3163.30), indicating that, in this dataset,
-- loyalty program members do not spend more per order than non-members.

-- ==========================================
-- Business Question 9
-- Which shipping type generates the highest revenue?
-- ==========================================

SELECT
    orders.shipping_type,
    COUNT(*) AS total_orders,
    SUM(orders.total_price) AS total_price_revenue,
    SUM(orders.add_on_total) AS total_addon_revenue,
    SUM(orders.total_price + orders.add_on_total) AS total_company_revenue,
    ROUND(
        AVG(orders.total_price + orders.add_on_total),
        2
    ) AS average_order_value
FROM orders
GROUP BY orders.shipping_type
ORDER BY total_company_revenue DESC;

-- Result:
-- Standard
-- Total Orders: 4053
-- Product Revenue: 13,040,845.77
-- Add-on Revenue: 254,553.33
-- Total Company Revenue: 13,295,399.10
-- Average Order Value: 3280.38
--
-- Expedited
-- Total Orders: 1979
-- Product Revenue: 7,502,331.23
-- Add-on Revenue: 164,103.59
-- Total Company Revenue: 7,666,434.82
-- Average Order Value: 3873.89
--
-- Same Day
-- Total Orders: 1986
-- Product Revenue: 7,426,457.90
-- Add-on Revenue: 166,367.30
-- Total Company Revenue: 7,592,825.20
-- Average Order Value: 3823.17
--
-- Express
-- Total Orders: 2113
-- Product Revenue: 5,456,817.85
-- Add-on Revenue: 88,064.53
-- Total Company Revenue: 5,544,882.38
-- Average Order Value: 2624.18
--
-- Overnight
-- Total Orders: 2004
-- Product Revenue: 5,072,097.07
-- Add-on Revenue: 83,401.12
-- Total Company Revenue: 5,155,498.19
-- Average Order Value: 2572.60

-- Interpretation:
-- Standard shipping generates the highest total revenue due to the
-- largest number of customer orders. However, Expedited shipping has
-- the highest Average Order Value (AOV), indicating that customers who
-- choose this shipping option tend to place higher-value orders on
-- average. Same Day shipping also shows a relatively high AOV, while
-- Express and Overnight shipping generate lower average order values.

-- ==========================================
-- Business Question 10
-- Which product categories generate the highest revenue?
-- ==========================================

SELECT
    products.product_type,
    COUNT(orders.order_id) AS total_orders,
    SUM(orders.total_price) AS total_product_revenue,
    SUM(orders.add_on_total) AS total_addon_revenue,
    SUM(orders.total_price + orders.add_on_total) AS total_company_revenue,
    ROUND(
        AVG(orders.total_price + orders.add_on_total),
        2
    ) AS average_order_value
FROM products
INNER JOIN orders
    ON products.product_id = orders.product_id
GROUP BY products.product_type
ORDER BY total_company_revenue DESC;

-- Result:
-- Smartphone
-- Total Orders: 3674
-- Product Revenue: 13,220,659.59
-- Add-on Revenue: 205,357.15
-- Total Company Revenue: 13,426,016.74
-- Average Order Value: 3654.33
--
-- Smartwatch
-- Total Orders: 2432
-- Product Revenue: 8,650,126.55
-- Add-on Revenue: 150,754.64
-- Total Company Revenue: 8,800,881.19
-- Average Order Value: 3618.78
--
-- Laptop
-- Total Orders: 2346
-- Product Revenue: 7,113,496.16
-- Add-on Revenue: 144,976.75
-- Total Company Revenue: 7,258,472.91
-- Average Order Value: 3093.98
--
-- Tablet
-- Total Orders: 2472
-- Product Revenue: 7,088,582.64
-- Add-on Revenue: 154,679.68
-- Total Company Revenue: 7,243,262.32
-- Average Order Value: 2930.12
--
-- Headphones
-- Total Orders: 1211
-- Product Revenue: 2,425,684.88
-- Add-on Revenue: 100,721.65
-- Total Company Revenue: 2,526,406.53
-- Average Order Value: 2086.22

-- Interpretation:
-- Smartphones generate the highest total revenue and account for the
-- largest number of orders. Smartwatches rank second, with a similarly
-- high Average Order Value (AOV). Headphones generate the lowest revenue
-- and have the lowest average order value, while laptops and tablets
-- occupy a middle position in both revenue and average spending.