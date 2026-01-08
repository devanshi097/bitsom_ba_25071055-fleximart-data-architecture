\# Part 2: NoSQL Database Analysis – MongoDB



\## Overview

This part of the assignment evaluates the suitability of a NoSQL database for handling highly diverse and flexible product data at FlexiMart. As the product catalog expands across multiple categories with varying attributes, traditional relational databases become less efficient. MongoDB is analyzed and implemented as an alternative solution.



---



\## Objectives

The objectives of this part are:

\- To analyze the limitations of relational databases for flexible product catalogs

\- To justify the use of MongoDB as a NoSQL solution

\- To implement basic MongoDB operations on product data

\- To demonstrate querying, updating, and aggregation using MongoDB



---



\## Files Included



\### `nosql\_analysis.md`

Contains a theoretical analysis covering:

\- Limitations of relational databases (RDBMS)

\- Benefits of MongoDB and NoSQL databases

\- Trade-offs and disadvantages of MongoDB



This file is structured into clearly defined sections as per the assignment requirements.



---



\### `products\_catalog.json`

A sample product catalog in JSON format containing:

\- Product details

\- Category-specific attributes

\- Embedded specifications

\- Customer reviews stored as nested documents



This file is used as input data for MongoDB operations.



---



\### `mongodb\_operations.js`

Contains MongoDB shell commands that demonstrate:

1\. Loading product data into MongoDB

2\. Querying products by category and price

3\. Performing aggregation to calculate average ratings

4\. Updating documents by adding new reviews

5\. Complex aggregation to calculate average price by category



All operations are commented for clarity and understanding.



---



\## Tools and Technologies

\- MongoDB

\- MongoDB Shell (`mongosh`)

\- JSON

\- NoSQL document-based data modeling



---



\## Learning Outcome

This part demonstrates how MongoDB efficiently handles schema flexibility, nested data, and scalability challenges that are difficult to manage using traditional relational databases.



---



\## Conclusion

MongoDB is well-suited for managing FlexiMart’s evolving product catalog due to its flexible schema design, support for embedded documents, and scalability. While it introduces certain trade-offs, its advantages make it a strong choice for NoSQL-based product data management.



