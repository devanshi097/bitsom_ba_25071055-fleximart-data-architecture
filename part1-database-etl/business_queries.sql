-- =========================================================
-- File: business_queries.sql
-- Project: FlexiMart Data Architecture
-- Description:
-- This file contains SQL queries that answer key business
-- questions using the FlexiMart transactional database.
-- Queries use joins, aggregation, filtering, and window
-- functions to generate analytical insights.
--
-- NOTE:
-- The number of rows returned depends on the data available.
-- Queries are written to satisfy business conditions, not
-- to return a fixed number of results.
-- =========================================================

USE fleximart;

-- =====================================================
-- Query 1: Customer Purchase History
-- Business Question:
-- Generate a detailed report showing each customer's name,
-- email, total number of orders placed, and total amount spent.
-- Include only customers who have placed at least 2 orders
-- and spent more than ₹5,000.

-- Tables Used:
-- - customers
-- - orders
-- - order_items
--
-- SQL Concepts Used:
-- - JOINs across multiple tables
-- - GROUP BY for aggregation
-- - HAVING clause for business filtering

-- NOTE:
-- Depending on the data, this query may return one or more rows.
-- =====================================================

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.subtotal) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
HAVING COUNT(DISTINCT o.order_id) >= 2
   AND SUM(oi.subtotal) > 5000
ORDER BY total_spent DESC;


-- =====================================================
-- Query 2: Product Sales Analysis
-- Business Question:
-- For each product category, show category name,
-- number of different products sold, total quantity sold,
-- and total revenue generated.
-- Include only categories with revenue > ₹10,000.

-- Conditions:
-- - Include only categories with total revenue greater than ₹10,000
-- Tables Used:
-- - products
-- - order_items

-- SQL Concepts Used:
-- - COUNT(DISTINCT) for product count
-- - SUM() for quantity and revenue
-- - GROUP BY with HAVING for filtering

-- NOTE:
-- If only one category meets the revenue condition,
-- the result will correctly return a single row.
-- =====================================================

SELECT
    p.category,
    COUNT(DISTINCT p.product_id) AS num_products,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.subtotal) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
HAVING SUM(oi.subtotal) > 10000
ORDER BY total_revenue DESC;


-- =====================================================
-- Query 3: Monthly Sales Trend (2024)
-- Business Question:
-- Show monthly sales trends for the year 2024.
-- Display month name, total number of orders,
-- monthly revenue, and cumulative revenue.

-- Scope:
-- - Based on order_date from the orders table
--
-- Tables Used:
-- - orders
-- - order_items

-- SQL Concepts Used:
-- - DATE functions (MONTHNAME)
-- - Aggregation using COUNT and SUM
-- - Window function for cumulative revenue

-- Purpose:
-- Helps management understand sales growth over time.
-- =====================================================

SELECT
    month_name,
    total_orders,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month_num) AS cumulative_revenue
FROM (
    SELECT
        MONTH(o.order_date) AS month_num,
        MONTHNAME(o.order_date) AS month_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.subtotal) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE YEAR(o.order_date) = 2024
    GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date)
) monthly_data
ORDER BY month_num;

