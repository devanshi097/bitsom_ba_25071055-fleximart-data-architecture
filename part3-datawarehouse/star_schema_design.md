\# Star Schema Design Documentation – FlexiMart Data Warehouse



---



\## Section 1: Schema Overview



The FlexiMart data warehouse is designed using a star schema to support analytical reporting on sales transactions. The schema consists of a central fact table connected to multiple dimension tables.



\### FACT TABLE: fact\_sales



\*\*Grain:\*\*  

One row per product per order line item.



\*\*Business Process:\*\*  

Sales transactions.



\*\*Measures (Numeric Facts):\*\*

\- quantity\_sold: Number of units sold

\- unit\_price: Price per unit at the time of sale

\- discount\_amount: Discount applied on the sale

\- total\_amount: Final sales amount (quantity × unit\_price − discount)



\*\*Foreign Keys:\*\*

\- date\_key → dim\_date

\- product\_key → dim\_product

\- customer\_key → dim\_customer



---



\### DIMENSION TABLE: dim\_date



\*\*Purpose:\*\*  

Acts as the date dimension to support time-based analysis of sales.



\*\*Type:\*\*  

Conformed dimension.



\*\*Attributes:\*\*

\- date\_key (Primary Key): Surrogate key in YYYYMMDD format

\- full\_date: Actual calendar date

\- day\_of\_week: Day name (Monday, Tuesday, etc.)

\- month: Month number (1–12)

\- month\_name: Month name (January, February, etc.)

\- quarter: Quarter (Q1, Q2, Q3, Q4)

\- year: Calendar year

\- is\_weekend: Boolean indicator for weekend



---



\### DIMENSION TABLE: dim\_product



\*\*Purpose:\*\*  

Stores descriptive information about products for sales analysis.



\*\*Attributes:\*\*

\- product\_key (Primary Key)

\- product\_id: Source system product identifier

\- product\_name: Name of the product

\- category: Product category

\- subcategory: Product subcategory

\- unit\_price: Product price



---



\### DIMENSION TABLE: dim\_customer



\*\*Purpose:\*\*  

Stores customer details to enable customer segmentation and geographic analysis.



\*\*Attributes:\*\*

\- customer\_key (Primary Key)

\- customer\_id: Source system customer identifier

\- customer\_name: Full name of the customer

\- city: City of residence

\- state: State of residence

\- customer\_segment: Customer classification (High, Medium, Low value)



---



\## Section 2: Design Decisions



The fact table is designed at the transaction line-item level to allow detailed analysis of sales at the most granular level. This granularity enables reporting by product, customer, and time, and supports flexible analytical queries such as daily sales trends and product-level performance.



Surrogate keys are used instead of natural keys to improve query performance, simplify joins, and maintain historical consistency even if source system identifiers change over time. Surrogate keys also help isolate the data warehouse from operational system changes.



The star schema structure supports efficient drill-down and roll-up operations. Users can roll up data from daily to monthly or yearly levels and drill down from high-level summaries to individual transactions, making the design suitable for OLAP analytics.



---



\## Section 3: Sample Data Flow



\*\*Source Transaction:\*\*  

Order #101 placed by customer “John Doe” for product “Laptop” with quantity 2 at a unit price of ₹50,000.



\*\*Data Warehouse Representation:\*\*



\*\*fact\_sales:\*\*  

date\_key: 20240115  

product\_key: 5  

customer\_key: 12  

quantity\_sold: 2  

unit\_price: 50000  

total\_amount: 100000  



\*\*dim\_date:\*\*  

date\_key: 20240115  

full\_date: 2024-01-15  

month: 1  

quarter: Q1  



\*\*dim\_product:\*\*  

product\_key: 5  

product\_name: Laptop  

category: Electronics  



\*\*dim\_customer:\*\*  

customer\_key: 12  

customer\_name: John Doe  

city: Mumbai  



