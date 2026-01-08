\# Part 1: Database Design and ETL Pipeline



\## Overview

This part of the project focuses on building an end-to-end ETL (Extract, Transform, Load) pipeline for FlexiMart’s transactional data. Raw customer, product, and sales data provided in CSV format contains multiple data quality issues which are cleaned, standardized, and loaded into a relational database.



The objective is to design a clean relational schema, implement data transformation logic, and answer business-driven analytical questions using SQL.



---



\## Objectives

\- Extract raw data from CSV files

\- Clean and standardize inconsistent and missing data

\- Load transformed data into a relational database

\- Document database schema and relationships

\- Answer business questions using SQL queries



---



\## Files Included



\### `etl\_pipeline.py`

Python script that performs:

\- Data extraction from CSV files

\- Data cleaning and transformation

\- Loading cleaned data into the database

\- Generation of a data quality report



---



\### `schema\_documentation.md`

Describes:

\- Entity definitions and attributes

\- Table relationships

\- Normalization (3NF) justification

\- Sample data representation



---



\### `business\_queries.sql`

Contains SQL queries to answer key business questions related to:

\- Customer purchase behavior

\- Product sales performance

\- Monthly sales trends



---



\### `data\_quality\_report.txt`

Automatically generated report summarizing:

\- Records processed

\- Duplicates removed

\- Missing values handled

\- Records successfully loaded



---



\## Technologies Used

\- Python (pandas)

\- MySQL / PostgreSQL

\- SQL



---



\## Outcome

This part ensures that FlexiMart has a clean, reliable transactional database that can support accurate reporting and downstream analytics.



