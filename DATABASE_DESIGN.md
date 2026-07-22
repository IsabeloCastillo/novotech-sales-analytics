# Database Design

## Database Name

**novotech_sales**

---

# Database Overview

The original dataset contains transactional sales information where each row represents a single purchase.

To improve data organization and follow relational database design principles, the dataset has been normalized into three related tables:

- customers
- products
- orders

This design reduces data redundancy, improves data integrity and simplifies SQL analysis.

---

# Entity Relationship Diagram

```
customers
    │
    │
    │
    ▼
orders
    ▲
    │
    │
products
```

---

# Tables

## customers

| Column | Data Type | Description |
|---------|-----------|-------------|
| customer_id | INT | Primary Key |
| age | INT | Customer age |
| gender | VARCHAR(10) | Customer gender |
| loyalty_member | BOOLEAN | Loyalty program member |

---

## products

| Column | Data Type | Description |
|---------|-----------|-------------|
| product_id | INT | Primary Key |
| sku | VARCHAR(50) | Product identifier |
| product_type | VARCHAR(100) | Product category |

---

## orders

| Column | Data Type | Description |
|---------|-----------|-------------|
| order_id | INT | Primary Key |
| customer_id | INT | Foreign Key |
| product_id | INT | Foreign Key |
| purchase_date | DATE | Purchase date |
| quantity | INT | Units purchased |
| unit_price | DECIMAL(10,2) | Unit price at the time of purchase |
| total_price | DECIMAL(10,2) | Total order amount |
| rating | INT | Customer rating |
| order_status | VARCHAR(30) | Order status |
| payment_method | VARCHAR(50) | Payment method |
| shipping_type | VARCHAR(30) | Shipping method |
| add_ons_purchased | TEXT | Purchased add-ons |
| add_on_total | DECIMAL(10,2) | Total amount spent on add-ons |

---

# Relationships

- customers.customer_id → orders.customer_id
- products.product_id → orders.product_id

---

# Notes

The database has been intentionally designed following relational database principles instead of importing the original CSV directly into MySQL.

The **customers** and **products** tables act as dimension tables, while **orders** acts as the fact table containing transactional information.

This structure provides a clean and scalable model for SQL analysis and Power BI reporting.