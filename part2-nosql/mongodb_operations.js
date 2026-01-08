/*
File Name: mongodb_operations.js
Project: FlexiMart Data Architecture
Part: NoSQL Database Implementation
Database: MongoDB
Collection: products

This file contains MongoDB operations required for Part 2.2:
- Data loading
- Querying
- Aggregation
- Updates
*/

/* ---------------------------------------------------
Operation 1: Load Data
---------------------------------------------------
The product data is imported into MongoDB using Compass
from the file products_catalog.json into:

Database: fleximart_nosql
Collection: products
--------------------------------------------------- */


/* ---------------------------------------------------
Operation 2: Basic Query
---------------------------------------------------
Business Requirement:
Find all products in the "Electronics" category
with price less than 50000.

Return only:
- name
- price
- stock
--------------------------------------------------- */

db.products.find(
  {
    category: "Electronics",
    price: { $lt: 50000 }
  },
  {
    _id: 0,
    name: 1,
    price: 1,
    stock: 1
  }
);


/* ---------------------------------------------------
Operation 3: Review Analysis
---------------------------------------------------
Business Requirement:
Find all products that have an average rating
greater than or equal to 4.0.

Uses aggregation to calculate average rating
from the reviews array.
--------------------------------------------------- */

db.products.aggregate([
  {
    $unwind: "$reviews"
  },
  {
    $group: {
      _id: "$name",
      avg_rating: { $avg: "$reviews.rating" }
    }
  },
  {
    $match: {
      avg_rating: { $gte: 4.0 }
    }
  }
]);


/* ---------------------------------------------------
Operation 4: Update Operation
---------------------------------------------------
Business Requirement:
Add a new review to product with product_id = "ELEC001"

Review details:
- user: U999
- rating: 4
- comment: "Good value"
- date: current date
--------------------------------------------------- */

db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user: "U999",
        rating: 4,
        comment: "Good value",
        date: new Date()
      }
    }
  }
);


/* ---------------------------------------------------
Operation 5: Complex Aggregation
---------------------------------------------------
Business Requirement:
Calculate average price by category.

Return:
- category
- avg_price
- product_count

Sort results by avg_price in descending order.
--------------------------------------------------- */

db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      category: "$_id",
      avg_price: 1,
      product_count: 1
    }
  },
  {
    $sort: { avg_price: -1 }
  }
]);
