-- =====================================================
-- NOVOTECH SALES BUSINESS ANALYSIS
-- =====================================================
-- Project:
-- NovoTech Sales Analytics
--
-- Database:
-- novotech_sales
--
-- Description:
-- This SQL script answers the main business questions
-- required to understand NovoTech's sales performance,
-- customer behavior, product performance and operational efficiency.
-- =====================================================

-- =====================================================
-- EXECUTIVE OVERVIEW
-- =====================================================

-- -----------------------------------------------------
-- Business Question:
-- What are the main business KPIs?
--
-- Business Value:
-- Provide an executive overview of NovoTech's overall
-- sales performance.
-- -----------------------------------------------------

SELECT
    ROUND(SUM(total_price + add_on_total), 2) AS total_revenue,
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(total_price + add_on_total), 2) AS average_order_value,
    ROUND(SUM(add_on_total), 2) AS total_addon_revenue,
    ROUND(
        (SUM(add_on_total) / SUM(total_price + add_on_total)) * 100,
        2
    ) AS addon_revenue_percentage
FROM orders;

-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================

-- -----------------------------------------------------
-- Business Question:
-- Does the loyalty program increase customer spending?
--
-- Business Value:
-- Evaluate whether loyalty members generate higher
-- revenue and justify continued investment in the
-- loyalty program.
-- -----------------------------------------------------

SELECT
    customers.loyalty_member,
    COUNT(orders.order_id) AS total_orders,
    ROUND(SUM(orders.total_price), 2) AS total_product_revenue,
    ROUND(SUM(orders.add_on_total), 2) AS total_addon_revenue,
    ROUND(SUM(orders.total_price + orders.add_on_total), 2) AS total_company_revenue,
    ROUND(AVG(orders.total_price + orders.add_on_total), 2) AS average_order_value
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.loyalty_member
ORDER BY total_company_revenue DESC;

-- Key Insight:
-- Loyalty program members do not spend more than non-members.
-- Although loyalty members generated €8.08M in revenue, their
-- Average Order Value (€3,163.30) is lower than that of
-- non-members (€3,253.95).
--
-- Business Recommendation:
-- Review the effectiveness of the loyalty program to determine
-- whether it is encouraging higher customer spending or if the
-- benefits offered should be redesigned.

-- =====================================================
-- PRODUCT PERFORMANCE
-- =====================================================

-- -----------------------------------------------------
-- Business Question:
-- Which product categories generate the highest revenue?
--
-- Business Value:
-- Identify the product categories that contribute
-- the most to company revenue to support inventory,
-- pricing and marketing decisions.
-- -----------------------------------------------------

SELECT
    products.product_type,
    COUNT(orders.order_id) AS total_orders,
    ROUND(SUM(orders.total_price), 2) AS total_product_revenue,
    ROUND(SUM(orders.add_on_total), 2) AS total_addon_revenue,
    ROUND(SUM(orders.total_price + orders.add_on_total), 2) AS total_company_revenue,
    ROUND(AVG(orders.total_price + orders.add_on_total), 2) AS average_order_value
FROM products
INNER JOIN orders
    ON products.product_id = orders.product_id
GROUP BY products.product_type
ORDER BY total_company_revenue DESC;

-- Key Insight:
-- Smartphones are NovoTech's strongest product category,
-- generating the highest revenue (€13.43M) and the highest
-- Average Order Value (€3,654.33). Smartwatches also show
-- strong commercial performance, while Headphones contribute
-- the lowest revenue and average order value.
--
-- Business Recommendation:
-- Prioritize investment in Smartphone and Smartwatch
-- categories through inventory planning, marketing campaigns
-- and promotional strategies. Review the commercial strategy
-- for Headphones to identify opportunities for improving sales
-- performance.

-- -----------------------------------------------------
-- Business Question:
-- Which individual products generate the highest revenue?
--
-- Business Value:
-- Identify the best-performing products to support
-- inventory planning, pricing strategies and marketing
-- investment.
-- -----------------------------------------------------

SELECT
    p.sku,
    p.product_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_price), 2) AS total_product_revenue,
    ROUND(SUM(o.add_on_total), 2) AS total_addon_revenue,
    ROUND(SUM(o.total_price + o.add_on_total), 2) AS total_company_revenue,
    ROUND(AVG(o.total_price + o.add_on_total), 2) AS average_order_value
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.sku, p.product_type
ORDER BY total_company_revenue DESC;

-- Key Insight:
-- Revenue is highly concentrated in a small number of SKUs.
-- SMP234 (Smartphone) is the best-performing product,
-- generating €7.70M in revenue, while SKU1001 (Smartphone)
-- contributes only €183K despite belonging to the same
-- product category.
--
-- Business Recommendation:
-- Investigate the factors driving the success of SMP234 and
-- evaluate why SKU1001 significantly underperforms. The
-- findings could support inventory optimization, pricing
-- decisions and product portfolio management.

-- -----------------------------------------------------
-- Business Question:
-- Which products generate the highest add-on revenue?
--
-- Business Value:
-- Identify the products that generate the highest
-- cross-selling revenue through add-ons.
-- -----------------------------------------------------

SELECT
    p.sku,
    p.product_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.add_on_total), 2) AS total_addon_revenue,
    ROUND(AVG(o.add_on_total), 2) AS average_addon_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.sku, p.product_type
ORDER BY total_addon_revenue DESC;

-- Key Insight:
-- Add-on revenue varies significantly across products.
-- TBL345 (Tablet) generates the highest add-on revenue,
-- while several products generate nearly half the average
-- add-on revenue per order, indicating different
-- cross-selling opportunities.
--
-- Business Recommendation:
-- Analyze which add-ons are most frequently purchased with
-- the best-performing products and replicate those
-- cross-selling strategies across the rest of the product
-- portfolio.

-- -----------------------------------------------------
-- Business Question:
-- Which payment methods generate the highest revenue?
--
-- Business Value:
-- Evaluate the financial performance of each payment
-- method to understand customer preferences and support
-- commercial decisions.
-- -----------------------------------------------------

SELECT
    payment_method,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_price), 2) AS total_product_revenue,
    ROUND(SUM(add_on_total), 2) AS total_addon_revenue,
    ROUND(SUM(total_price + add_on_total), 2) AS total_company_revenue,
    ROUND(AVG(total_price + add_on_total), 2) AS average_order_value
FROM orders
GROUP BY payment_method
ORDER BY total_company_revenue DESC;

-- Key Insight:
-- Credit Card and PayPal generate the highest total revenue,
-- while Bank Transfer records the highest Average Order Value,
-- suggesting that higher-value purchases are more frequently
-- completed using this payment method.
--
-- Business Recommendation:
-- Analyze the customer profile and purchasing behavior
-- associated with Bank Transfer to determine whether
-- targeted payment incentives could increase high-value sales.

-- -----------------------------------------------------
-- Business Question:
-- Which shipping methods generate the highest revenue?
--
-- Business Value:
-- Evaluate the financial performance of each shipping
-- method to support logistics and delivery strategies.
-- -----------------------------------------------------

SELECT
    shipping_type,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_price), 2) AS total_product_revenue,
    ROUND(SUM(add_on_total), 2) AS total_addon_revenue,
    ROUND(SUM(total_price + add_on_total), 2) AS total_company_revenue,
    ROUND(AVG(total_price + add_on_total), 2) AS average_order_value
FROM orders
GROUP BY shipping_type
ORDER BY total_company_revenue DESC;

-- Key Insight:
-- Standard shipping generates the highest total revenue
-- due to its high order volume, while Expedited and
-- Same Day shipping achieve the highest Average Order
-- Value, suggesting that customers placing higher-value
-- orders tend to choose faster delivery options.
--
-- Business Recommendation:
-- Promote premium shipping options for high-value
-- purchases and maintain Standard shipping as the
-- primary fulfillment method for the majority of orders.

-- -----------------------------------------------------
-- Business Question:
-- What is the distribution of order status?
--
-- Business Value:
-- Evaluate operational performance by analyzing the
-- distribution of order statuses and identifying
-- potential fulfillment issues.
-- -----------------------------------------------------

SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(
        COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Key Insight:
-- Approximately one-third of all orders are cancelled,
-- indicating a potentially significant operational issue
-- that may be affecting both revenue and customer
-- satisfaction.
--
-- Business Recommendation:
-- Investigate the root causes of order cancellations and
-- implement corrective actions to improve order
-- fulfillment and reduce lost sales.


-- =====================================================
-- CUSTOMER EXPERIENCE
-- =====================================================

-- -----------------------------------------------------
-- Business Question:
-- Which products are associated with the highest customer satisfaction?
--
-- Business Value:
-- Identify the products associated with higher customer
-- satisfaction to support product portfolio and customer
-- experience decisions.
-- -----------------------------------------------------


SELECT
    p.sku,
    p.product_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.rating), 2) AS average_rating
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.sku, p.product_type
ORDER BY average_rating DESC;

-- Key Insight:
-- Customer satisfaction varies across products. Orders
-- associated with SKU1001 achieve the highest average
-- rating (5.00), while orders associated with SKU1004
-- record the lowest average rating (2.00), suggesting
-- meaningful differences in the overall customer
-- experience.

-- Business Recommendation:
-- Investigate the factors associated with the highest-
-- and lowest-rated products, including pricing,
-- fulfillment and the overall purchase experience, to
-- identify opportunities for improving customer
-- satisfaction.

-- =====================================================
-- BUSINESS CONCLUSIONS
-- =====================================================

-- Main Findings:
--
-- • Smartphones are the primary revenue driver.
-- • Revenue is concentrated in a small number of SKUs.
-- • The loyalty program does not increase customer spending.
-- • Premium shipping methods are associated with higher-value orders.
-- • One-third of all orders are cancelled, representing the main operational risk.
--
-- Strategic Recommendations:
--
-- • Review the loyalty program.
-- • Prioritize inventory and marketing investment in top-performing products.
-- • Strengthen cross-selling strategies.
-- • Investigate the causes of order cancellations.



