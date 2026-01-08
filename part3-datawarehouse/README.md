\# Part 3: Data Warehouse and Analytics



\## Overview

This part of the project focuses on building a data warehouse for FlexiMart to support historical sales analysis and decision-making. A star schema is designed to optimize analytical queries, followed by implementation of dimensional tables, fact tables, and OLAP-style analytical queries.



The data warehouse enables efficient drill-down, roll-up, and aggregation across time, product, and customer dimensions.



---



\## Objectives

\- Design a star schema for sales analytics

\- Implement dimension and fact tables using SQL

\- Populate tables with realistic sample data

\- Write analytical queries to support business intelligence use cases



---



\## Files Included



\### `star\_schema\_design.md`

Contains:

\- Star schema description

\- Fact and dimension table definitions

\- Design decisions and justification

\- Sample data flow from source to warehouse



---



\### `warehouse\_schema.sql`

SQL script to create:

\- Date, product, and customer dimension tables

\- Sales fact table with foreign key relationships



---



\### `warehouse\_data.sql`

Contains INSERT statements to populate:

\- 30 dates (Jan–Feb 2024)

\- Products across multiple categories

\- Customers across cities

\- Sales transactions with realistic patterns



---



\### `analytics\_queries.sql`

Includes OLAP queries for:

\- Time-based drill-down analysis

\- Product performance evaluation

\- Customer segmentation analysis



---



\## Technologies Used

\- SQL

\- MySQL / PostgreSQL

\- Dimensional modeling concepts



---



\## Outcome

This data warehouse design enables FlexiMart to analyze trends, identify top-performing products, and segment customers effectively using analytical queries.



