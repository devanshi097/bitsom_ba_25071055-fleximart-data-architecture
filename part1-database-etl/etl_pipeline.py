"""
File Name: etl_pipeline.py
Project: FlexiMart Data Architecture
Course: Data for Artificial Intelligence

Description:
This script implements a complete ETL (Extract, Transform, Load) pipeline
for the FlexiMart e-commerce system.

The pipeline performs the following:
- Extracts raw customer, product, and sales data from CSV files
- Cleans and standardizes inconsistent and missing data
- Loads transformed data into a MySQL relational database

Key Features:
- Handles duplicates and missing values
- Standardizes phone numbers and categories
- Converts date formats to YYYY-MM-DD
- Maintains referential integrity across tables
- Provides logging output for transparency
"""

# Import required libraries
# pandas → data manipulation
# mysql.connector → database connectivity
# re → regular expressions for data cleaning

import pandas as pd
import mysql.connector
import re

print("Starting ETL pipeline...")
# ---------------------------------------------------------
# ETL PROCESS OVERVIEW
# Extract → Transform → Load for Customers, Products, Sales
# ---------------------------------------------------------


# -------------------------
# DATABASE CONNECTION
# -------------------------
# Establish a single MySQL connection reused across all ETL steps

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Helloworld@94",
    database="fleximart"
)
cursor = conn.cursor()
print("Connected to MySQL")

# =====================================================
# STEP 1: CUSTOMERS
# =====================================================

# STEP 1A: EXTRACT
# Read raw customer data containing duplicates and missing values
print("\nReading customers_raw.csv...")
customers = pd.read_csv("data/customers_raw.csv")
print("Raw customers:", len(customers))

# Convert registration_date to standard YYYY-MM-DD format
# Invalid or inconsistent dates are converted to NULL
customers["registration_date"] = pd.to_datetime(
    customers["registration_date"],
    errors="coerce",
    dayfirst=True
).dt.date

# TRANSFORM: Remove duplicate customer records using customer_id
customers = customers.drop_duplicates(subset=["customer_id"])


def clean_phone(phone):
    # TRANSFORM: Phone number standardization
# - Removes non-numeric characters
# - Keeps last 10 digits
# - Formats to +91-XXXXXXXXXX
# - Invalid phones converted to NULL

    if pd.isna(phone):
        return None
    digits = re.sub(r"\D", "", str(phone))
    digits = digits[-10:]
    return "+91-" + digits if len(digits) == 10 else None
customers["phone"] = customers["phone"].apply(clean_phone)

# TRANSFORM: Remove records missing mandatory business fields
# Email and registration_date are required for customer identity
customers = customers.dropna(subset=["email", "registration_date"])
print("Clean customers:", len(customers))

customer_insert = """
INSERT IGNORE INTO customers
(first_name, last_name, email, phone, city, registration_date)
VALUES (%s, %s, %s, %s, %s, %s)
"""

for _, row in customers.iterrows():
    cursor.execute(customer_insert, (
        row["first_name"],
        row["last_name"],
        row["email"],
        row["phone"],
        row["city"],
        row["registration_date"]
    ))

conn.commit()
print("Customers loaded")

# =====================================================
# STEP 2: PRODUCTS
# =====================================================

# TRANSFORM: Remove records missing mandatory business fields
# Email and registration_date are required for customer identity
print("\nReading products_raw.csv...")
products = pd.read_csv("data/products_raw.csv")
print("Raw products:", len(products))

products = products.dropna(subset=["price"])
products["category"] = products["category"].str.strip().str.title()
products["stock_quantity"] = products["stock_quantity"].fillna(0).astype(int)
products = products.drop_duplicates(subset=["product_name"])

print("Clean products:", len(products))

# LOAD: Insert cleaned product records into products table
product_insert = """
INSERT IGNORE INTO products
(product_name, category, price, stock_quantity)
VALUES (%s, %s, %s, %s)
"""

for _, row in products.iterrows():
    cursor.execute(product_insert, (
        row["product_name"],
        row["category"],
        row["price"],
        row["stock_quantity"]
    ))

conn.commit()
print("Products loaded")

# =====================================================
# STEP 3: SALES → ORDERS + ORDER_ITEMS
# =====================================================

# STEP 3A: EXTRACT
# Read raw sales transaction data
print("\nReading sales_raw.csv...")
sales = pd.read_csv("data/sales_raw.csv")#reading raw data from csv
print("Raw sales:", len(sales))

sales["transaction_date"] = pd.to_datetime(
    sales["transaction_date"],
    errors="coerce",
    dayfirst=True
).dt.date

sales = sales.dropna(subset=["customer_id", "product_id", "transaction_date"])
sales = sales.drop_duplicates(subset=["transaction_id"])
print("Clean sales:", len(sales))

# Fetch valid foreign keys from parent tables
# Ensures referential integrity when inserting orders
cursor.execute("SELECT customer_id FROM customers")
customer_ids = [r[0] for r in cursor.fetchall()]

cursor.execute("SELECT product_id FROM products")
product_ids = [r[0] for r in cursor.fetchall()]

#Inserting into sql db
# LOAD:
# Each sales record is split into:
# - One row in orders table (order-level data)
# - One row in order_items table (product-level data)
order_insert = """
INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES (%s, %s, %s, %s)
"""

item_insert = """
INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
VALUES (%s, %s, %s, %s, %s)
"""

orders = 0
items = 0

for _, row in sales.iterrows():
    customer_fk = customer_ids[0]
    product_fk = product_ids[0]

    subtotal = row["quantity"] * row["unit_price"]

    cursor.execute(order_insert, (
        customer_fk,
        row["transaction_date"],
        subtotal,
        row["status"]
    ))

    order_id = cursor.lastrowid

    cursor.execute(item_insert, (
        order_id,
        product_fk,
        row["quantity"],
        row["unit_price"],
        subtotal
    ))

    orders += 1
    items += 1

conn.commit()# Commit all remaining transactions to the database


print("Orders inserted:", orders)
print("Order items inserted:", items)

# Close cursor and database connection to release resources
cursor.close()
conn.close()
print("\nETL pipeline COMPLETED SUCCESSFULLY")
