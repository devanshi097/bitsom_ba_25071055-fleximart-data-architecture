\## Section A: Limitations of Relational Databases



Traditional relational databases like MySQL are not well suited for highly

diverse and rapidly changing product data. In an e-commerce platform such as

FlexiMart, different products have different attributes. For example, laptops

require specifications like RAM and processor, while shoes require size and

color. Representing such variations in a relational schema would require

multiple tables or frequent schema alterations.



Additionally, relational databases enforce a fixed schema. Whenever a new

product type with new attributes is introduced, the database schema must be

altered. This makes the system less flexible and harder to scale.



Storing nested data such as customer reviews is also inefficient in relational

databases. Reviews would require separate tables and complex JOIN operations,

which increases query complexity and impacts performance.





\## Section B: Benefits of MongoDB



MongoDB is a NoSQL document-based database that addresses the limitations of

relational databases for flexible product catalogs. It allows products to be

stored as documents with a flexible schema, meaning each product can have its

own set of attributes without affecting other records.



MongoDB supports embedded documents, which makes it ideal for storing nested

data such as customer reviews directly inside product documents. This improves

read performance and simplifies data access by avoiding complex joins.



MongoDB also supports horizontal scalability through sharding, making it

suitable for applications with growing data volume and high traffic. Its

JSON-like structure closely matches application data formats, enabling faster

development and easier schema evolution.



\## Section C: Trade-offs of Using MongoDB



Despite its flexibility, MongoDB has certain disadvantages compared to

relational databases. It does not enforce strict schema constraints, which can

lead to data inconsistency if proper validation is not implemented at the

application level.



Additionally, MongoDB does not support complex multi-table transactions as

robustly as relational databases. For systems that require strong ACID

compliance and complex transactional operations, relational databases like

MySQL may still be a better choice.



