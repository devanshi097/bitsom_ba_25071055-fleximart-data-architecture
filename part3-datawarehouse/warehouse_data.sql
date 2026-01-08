USE fleximart_dw;

-- ===============================
-- Insert data into dim_date
-- January–February 2024
-- ===============================

INSERT INTO dim_date
(date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend)
VALUES
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, TRUE),

(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, TRUE),
(20240125, '2024-01-25', 'Thursday', 25, 1, 'January', 'Q1', 2024, FALSE),
(20240131, '2024-01-31', 'Wednesday', 31, 1, 'January', 'Q1', 2024, FALSE),

(20240201, '2024-02-01', 'Thursday', 1, 2, 'February', 'Q1', 2024, FALSE),
(20240202, '2024-02-02', 'Friday', 2, 2, 'February', 'Q1', 2024, FALSE),
(20240203, '2024-02-03', 'Saturday', 3, 2, 'February', 'Q1', 2024, TRUE),
(20240204, '2024-02-04', 'Sunday', 4, 2, 'February', 'Q1', 2024, TRUE),
(20240210, '2024-02-10', 'Saturday', 10, 2, 'February', 'Q1', 2024, TRUE),
(20240214, '2024-02-14', 'Wednesday', 14, 2, 'February', 'Q1', 2024, FALSE),
(20240220, '2024-02-20', 'Tuesday', 20, 2, 'February', 'Q1', 2024, FALSE),
(20240225, '2024-02-25', 'Sunday', 25, 2, 'February', 'Q1', 2024, TRUE),
(20240228, '2024-02-28', 'Wednesday', 28, 2, 'February', 'Q1', 2024, FALSE);

SELECT COUNT(*) FROM dim_date;
SELECT * FROM dim_date LIMIT 5;

-- ===============================
-- Insert data into dim_product
-- ===============================

INSERT INTO dim_product
(product_id, product_name, category, subcategory, unit_price)
VALUES
('P001', 'Laptop Pro', 'Electronics', 'Laptops', 85000),
('P002', 'Smartphone X', 'Electronics', 'Mobiles', 60000),
('P003', 'Wireless Earbuds', 'Electronics', 'Accessories', 5000),
('P004', 'LED TV 42"', 'Electronics', 'Television', 40000),
('P005', 'Bluetooth Speaker', 'Electronics', 'Audio', 3500),

('P006', 'Office Chair', 'Furniture', 'Chairs', 12000),
('P007', 'Wooden Table', 'Furniture', 'Tables', 25000),
('P008', 'Sofa Set', 'Furniture', 'Living Room', 75000),
('P009', 'Bookshelf', 'Furniture', 'Storage', 8000),
('P010', 'Study Desk', 'Furniture', 'Tables', 15000),

('P011', 'Running Shoes', 'Fashion', 'Footwear', 4000),
('P012', 'Jeans', 'Fashion', 'Clothing', 2500),
('P013', 'Jacket', 'Fashion', 'Clothing', 6000),
('P014', 'Handbag', 'Fashion', 'Accessories', 9000),
('P015', 'Sunglasses', 'Fashion', 'Accessories', 3000);

SELECT COUNT(*) FROM dim_product;
SELECT product_key, product_name, category, unit_price;

-- ===============================
-- Insert data into dim_customer
-- ===============================

INSERT INTO dim_customer
(customer_id, customer_name, city, state, customer_segment)
VALUES
('C001', 'Amit Sharma', 'Mumbai', 'Maharashtra', 'High Value'),
('C002', 'Neha Verma', 'Delhi', 'Delhi', 'Medium Value'),
('C003', 'Rohit Mehta', 'Bangalore', 'Karnataka', 'High Value'),
('C004', 'Priya Singh', 'Pune', 'Maharashtra', 'Medium Value'),
('C005', 'Anjali Kapoor', 'Mumbai', 'Maharashtra', 'Low Value'),
('C006', 'Vikas Jain', 'Delhi', 'Delhi', 'Low Value'),
('C007', 'Sneha Iyer', 'Chennai', 'Tamil Nadu', 'Medium Value'),
('C008', 'Arjun Patel', 'Ahmedabad', 'Gujarat', 'High Value'),
('C009', 'Kunal Shah', 'Mumbai', 'Maharashtra', 'Medium Value'),
('C010', 'Riya Malhotra', 'Delhi', 'Delhi', 'Low Value'),
('C011', 'Manish Gupta', 'Bangalore', 'Karnataka', 'High Value'),
('C012', 'Pooja Nair', 'Chennai', 'Tamil Nadu', 'Medium Value');
SELECT COUNT(*) FROM dim_customer;

USE fleximart_dw;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE fact_sales;
TRUNCATE TABLE dim_customer;
TRUNCATE TABLE dim_product;
TRUNCATE TABLE dim_date;
SET FOREIGN_KEY_CHECKS = 1;

SELECT COUNT(*) FROM dim_date;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM dim_customer;
 
 SELECT 
  (SELECT COUNT(*) FROM dim_date) AS dates,
  (SELECT COUNT(*) FROM dim_product) AS products,
  (SELECT COUNT(*) FROM dim_customer) AS customers;
  
  -- ===============================
-- Insert data into fact_sales
-- ===============================

INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240101, 1, 1, 2, 85000, 0, 170000),
(20240102, 2, 2, 1, 60000, 2000, 58000),
(20240103, 3, 3, 3, 5000, 0, 15000),
(20240104, 4, 4, 1, 40000, 3000, 37000),
(20240105, 5, 5, 2, 3500, 0, 7000),

(20240106, 6, 6, 1, 12000, 1000, 11000),
(20240107, 7, 7, 1, 25000, 0, 25000),
(20240115, 8, 8, 2, 75000, 5000, 145000),
(20240120, 9, 9, 1, 8000, 0, 8000),
(20240125, 10, 10, 2, 15000, 2000, 28000),

(20240201, 11, 11, 3, 4000, 0, 12000),
(20240202, 12, 12, 2, 2500, 0, 5000),
(20240203, 13, 1, 1, 6000, 500, 5500),
(20240204, 14, 2, 1, 9000, 0, 9000),
(20240210, 15, 3, 2, 3000, 0, 6000);
SELECT COUNT(*) FROM fact_sales;
SELECT * FROM fact_sales LIMIT 5;


INSERT INTO dim_date
(date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend)
VALUES
(20240205, '2024-02-05', 'Monday', 5, 2, 'February', 'Q1', 2024, FALSE),
(20240206, '2024-02-06', 'Tuesday', 6, 2, 'February', 'Q1', 2024, FALSE),
(20240207, '2024-02-07', 'Wednesday', 7, 2, 'February', 'Q1', 2024, FALSE),
(20240208, '2024-02-08', 'Thursday', 8, 2, 'February', 'Q1', 2024, FALSE),
(20240209, '2024-02-09', 'Friday', 9, 2, 'February', 'Q1', 2024, FALSE),
(20240211, '2024-02-11', 'Sunday', 11, 2, 'February', 'Q1', 2024, TRUE),
(20240212, '2024-02-12', 'Monday', 12, 2, 'February', 'Q1', 2024, FALSE),
(20240213, '2024-02-13', 'Tuesday', 13, 2, 'February', 'Q1', 2024, FALSE),
(20240215, '2024-02-15', 'Thursday', 15, 2, 'February', 'Q1', 2024, FALSE),
(20240218, '2024-02-18', 'Sunday', 18, 2, 'February', 'Q1', 2024, TRUE);
SELECT COUNT(*) FROM dim_date;

INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240205, 1, 2, 1, 85000, 5000, 80000),
(20240206, 2, 3, 2, 60000, 4000, 116000),
(20240207, 3, 4, 4, 5000, 0, 20000),
(20240208, 4, 5, 1, 40000, 2000, 38000),
(20240209, 5, 6, 3, 3500, 0, 10500),

(20240210, 6, 7, 2, 12000, 1000, 23000),
(20240211, 7, 8, 1, 25000, 0, 25000),
(20240212, 8, 9, 1, 75000, 5000, 70000),
(20240213, 9, 10, 2, 8000, 0, 16000),
(20240214, 10, 11, 1, 15000, 1000, 14000),

(20240215, 11, 12, 3, 4000, 0, 12000),
(20240218, 12, 1, 2, 2500, 0, 5000),
(20240220, 13, 2, 1, 6000, 500, 5500),
(20240225, 14, 3, 1, 9000, 0, 9000),
(20240228, 15, 4, 2, 3000, 0, 6000),

(20240102, 1, 5, 1, 85000, 0, 85000),
(20240103, 2, 6, 1, 60000, 2000, 58000),
(20240104, 3, 7, 2, 5000, 0, 10000),
(20240105, 4, 8, 1, 40000, 3000, 37000),
(20240106, 5, 9, 2, 3500, 0, 7000),

(20240107, 6, 10, 1, 12000, 0, 12000),
(20240115, 7, 11, 1, 25000, 0, 25000),
(20240120, 8, 12, 2, 75000, 5000, 145000),
(20240125, 9, 1, 1, 8000, 0, 8000),
(20240131, 10, 2, 1, 15000, 0, 15000);
SELECT COUNT(*) FROM fact_sales;

SELECT
  (SELECT COUNT(*) FROM dim_date) AS dim_date,
  (SELECT COUNT(*) FROM dim_product) AS dim_product,
  (SELECT COUNT(*) FROM dim_customer) AS dim_customer,
  (SELECT COUNT(*) FROM fact_sales) AS fact_sales;











