# 📊 Snapdeal Sales Analysis

A SQL-based sales analysis project built to explore Snapdeal order performance, customer behavior, category-wise revenue, profit trends, and monthly target achievement using relational data modeling.

## ✨ Project Objective

This project aims to:

* organize raw sales data into structured tables
* clean and standardize date fields for analysis
* connect order-level and item-level data using relationships
* compare actual sales against monthly targets
* extract business insights from revenue, profit, quantity, and category performance

## 📁 Dataset Overview

### 1) `Order_List.csv`

Contains order-level customer details.

**Columns:**

* `Order ID`
* `Order Date`
* `CustomerName`
* `State`
* `City`

### 2) `Order Details.csv`

Contains item-level sales information.

**Columns:**

* `Order ID`
* `Amount`
* `Profit`
* `Quantity`
* `Category`
* `Sub-Category`

### 3) `Sales_target.csv`

Contains monthly target values by category.

**Columns:**

* `Month of Order Date`
* `Category`
* `Target`

## 🧱 Database Schema

The project uses three core tables:

* `orderlist`
* `orderDetails`
* `salesTarget`

## 🔗 Relationships

* `orderlist.orderId` → primary key
* `orderDetails.orderId` → foreign key linked to `orderlist.orderId`
* `orderDetails.Category` → used for category-based target comparison
* `salesTarget.monthOfOrder` → used for monthly sales target analysis

## 🗂️ Clean Project Structure

```text
snapdeal-sales-analysis/
├── Order_List.csv
├── Order Details.csv
├── Sales_target.csv
├── snapdeal.sql
└── README.md
```

## 🛠️ Tech Stack

* PostgreSQL
* SQL
* CSV data files
* Relational data modeling

## 📈 Key Analysis Areas

This project can be used to analyze:

* overall sales and profit performance
* top-performing categories and sub-categories
* customer distribution by state and city
* quantity sold across categories
* monthly target vs actual sales
* low-profit or underperforming product segments

## 💡 Key Insights

Based on the structure of this project, the analysis is designed to reveal:

* which categories generate the highest revenue
* where sales are concentrated geographically
* whether high sales also translate into high profit
* which months or categories miss targets
* which product groups need business attention

## 🧪 SQL Features Used

The SQL script includes:

* schema creation
* table creation
* date cleaning and conversion
* joins across order and target tables
* aggregations using `SUM()`, `COUNT()`, and grouping
* monthly and category-wise performance comparison
* analytical queries for reporting

## 🚀 How to Use

1. Create the database schema and tables using `snapdeal.sql`.
2. Import the CSV files into the respective tables.
3. Run the SQL queries included in the script.
4. Use the output to build dashboards or generate business insights.

## 🧹 Data Cleaning Notes

The raw data contains date values that may need conversion before month-wise analysis. Standardizing the date format is important before performing target comparisons and trend analysis.

## 🎯 Outcome

This project helps identify:

* top revenue-generating categories
* states and cities with strong order volume
* products with weak margins
* category-wise target achievement
* important business trends for decision-making

## 👤 Author

Jateen Patil prepared a Snapdeal sales analysis project for SQL reporting and business insight generation.

---

⭐ If you like this project, feel free to star the repository!
