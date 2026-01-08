FlexiMart Database Schema Documentation



This document describes the entities, attributes, and relationships

of the FlexiMart transactional database.



1\. Entity–Relationship Description



ENTITY: customers



Purpose:



Stores information about customers registered on the FlexiMart platform.



Attributes:



customer\_id (INT, PK): Unique identifier for each customer



first\_name (VARCHAR): Customer’s first name



last\_name (VARCHAR): Customer’s last name



email (VARCHAR, UNIQUE): Customer’s email address



phone (VARCHAR): Customer’s contact number



city (VARCHAR): City where the customer resides



registration\_date (DATE): Date when the customer registered



Relationships:



One customer can place many orders



Relationship: customers (1) → orders (M)



ENTITY: products



Purpose:



Stores information about products sold by FlexiMart.



Attributes:



product\_id (INT, PK): Unique identifier for each product



product\_name (VARCHAR): Name of the product



category (VARCHAR): Product category (e.g., Electronics)



price (DECIMAL): Price of the product



stock\_quantity (INT): Available inventory count



Relationships:



One product can appear in many order items



Relationship: products (1) → order\_items (M)



ENTITY: orders



Purpose:



Stores order-level information for customer purchases.



Attributes:



order\_id (INT, PK): Unique identifier for each order



customer\_id (INT, FK): References customers.customer\_id



order\_date (DATE): Date when the order was placed



total\_amount (DECIMAL): Total value of the order



status (VARCHAR): Order status (Pending, Completed, etc.)



Relationships:



Each order belongs to one customer



One order can contain many order items



ENTITY: order\_items



Purpose:



Stores line-item details for each order.



Attributes:



order\_item\_id (INT, PK): Unique identifier for each order line



order\_id (INT, FK): References orders.order\_id



product\_id (INT, FK): References products.product\_id



quantity (INT): Number of units purchased



unit\_price (DECIMAL): Price per unit at time of purchase



subtotal (DECIMAL): quantity × unit\_price



Relationships:



Many order items belong to one order



Each order item references one product







2\. Normalization Explanation (3NF)



The FlexiMart database schema is designed in Third Normal Form (3NF) to ensure data integrity, reduce redundancy, and prevent anomalies.



Each table satisfies First Normal Form (1NF) because all attributes contain atomic values and there are no repeating groups. For example, product details and customer information are stored in separate rows, not multi-valued fields.



The schema satisfies Second Normal Form (2NF) because all non-key attributes are fully functionally dependent on the entire primary key. In the order\_items table, attributes such as quantity, unit\_price, and subtotal depend entirely on order\_item\_id, not partially on order\_id or product\_id.



The schema satisfies Third Normal Form (3NF) because there are no transitive dependencies. Non-key attributes do not depend on other non-key attributes. For example, customer city information is stored only in the customers table and not duplicated in the orders table. Similarly, product price and category are stored only in the products table.



This design prevents update anomalies (changing product price in multiple places), insert anomalies (adding products without orders), and delete anomalies (removing orders without losing customer data). As a result, the schema ensures consistency, scalability, and efficient data maintenance.







3\. Sample Data Representation



customers (sample)



customer\_id	 first\_name	 last\_name	   email	       city	       registration\_date

1	          Rahul	  Sharma    rahul@gmail.com   Mumbai	       2024-01-10

2	          Priya	  Patel	    priya@yahoo.com   Ahmedabad	       2024-01-15







products (sample)

product\_id	   product\_name	    category	          price	     tock\_quantity

1	          Laptop	    Electronics	       55000	      10

2	          Headphones	Electronics	        3000	      25







orders (sample)

order\_id	          customer\_id	   order\_date	     total\_amount	status

101		                    1          2024-02-05	        58000	    Completed

102		                    2          2024-02-10	        3000	     Pending







order\_items (sample)

order\_item\_id	order\_id	product\_id	     quantity	unit\_price	     subtotal

1	               101	       1	             1	      55000	          55000

2	               101	       2	             1	      3000	           3000





