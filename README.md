
## 📖 Project Overview

**This project demonstrates a complete Data Warehousing solution using PostgreSQL.** It is designed to simulate a real-world data engineering environment, involving:

* **Data Architecture:** Designing a Modern Data Warehouse using **Medallion Architecture** (Bronze, Silver, and Gold layers).
* **ETL Pipelines:** Extracting, transforming, and loading data from source systems into the warehouse using stored procedures.
* **Data Modeling:** Developing fact and dimension tables (Star Schema) optimized for analytical queries.
* **Analytics & Reporting:** Creating SQL-based reports and dashboards for actionable insights.


## 🏗 Architecture

The project follows the **Medallion Architecture**, processing data through three distinct layers:

1. **Bronze Layer (Raw Data):**
* Ingests raw data from CSV files "as-is".
* Focuses on quick data capture with minimal transformation.
* **Tables:** `bronze.crm_cust_info`, `bronze.erp_loc_a101`, etc.


2. **Silver Layer (Cleansed & Transformed):**
* Cleans and standardizes data from the Bronze layer.
* Handles missing values, standardizes dates, removes duplicates, and normalizes field values (e.g., converting 'M'/'F' to 'Male'/'Female').
* **Tables:** `silver.crm_cust_info`, `silver.crm_prd_info`, etc.


3. **Gold Layer (Business Logic & Modeling):**
* Implements a **Star Schema** optimized for reporting.
* Aggregates and joins data to create Dimension and Fact tables.
* **Views:** `gold.dim_customers`, `gold.dim_products`, `gold.fact_sales`.



## 📂 Project Structure

```bash
.
├── datasets/               # Source CSV files (CRM and ERP data)
├── docs/                   # Documentation and diagrams
├── scripts/                # SQL scripts for database logic
│   ├── init_database.sql   # Database creation script
│   ├── bronze/             # DDL and Stored Procs for Bronze layer
│   ├── silver/             # DDL and Stored Procs for Silver layer
│   └── gold/               # DDL for Gold layer (Views)
└── tests/                  # Quality check scripts

```

## 🛠 Tech Stack

* **Database:** PostgreSQL
* **SQL Dialect:** PL/pgSQL
* **ETL Tool:** Native SQL Stored Procedures
* **Data Modeling:** Star Schema (Facts & Dimensions)

## 🚀 Getting Started

### Prerequisites

* PostgreSQL installed and running.
* A SQL client (e.g., pgAdmin, DBeaver, or Datagrip).

### Installation & Setup

1. **Clone the Repository**
```bash
git clone https://github.com/yourusername/sql-data-warehouse-project.git

```


2. **Initialize the Database**
* Run `scripts/init_database.sql`.
* **Warning:** This script drops and recreates the `datawarehouse` database. Ensure you don't have existing data you want to keep.


3. **Setup Database Objects (DDL)**
* Run `scripts/bronze/ddl_bronze.sql` to create raw tables.
* Run `scripts/silver/ddl_silver.sql` to create transformation tables.
* Run `scripts/gold/ddl_gold.sql` to create analytical views.


4. **Data Loading (ETL)**
* *Note: Before running the bronze load script, you must update the CSV file paths in `scripts/bronze/proc_load_bronze.sql` to match your local machine's file path for the `datasets` folder.*


Execute the stored procedures to process data:
```sql
-- Load Raw Data
CALL bronze.load_bronze_proc();

-- Process & Transform Data
CALL silver.load_silver_proc();

```


5. **Run Quality Checks**
* Run `tests/quality_checks_silver.sql` to validate data cleaning logic.
* Run `tests/quality_checks_gold.sql` to verify referential integrity and key uniqueness.



## 📊 Data Model (Gold Layer)

The final output is a Star Schema consisting of:

* **Fact Table:** `gold.fact_sales` (Transactions, Sales, Quantity)
* **Dimension Tables:**
* `gold.dim_customers` (Demographics, Location)
* `gold.dim_products` (Categories, Cost, Product Lines)



## 🧪 Quality Assurance

The project includes a robust testing suite (`tests/` folder) that checks for:

* Null or duplicate primary keys.
* Referential integrity between facts and dimensions.
* Validity of date ranges (e.g., Ship Date cannot be before Order Date).
* Data standardization (e.g., no unwanted spaces, consistent naming conventions).

## 📝 License

This project is open-source and available under the [MIT License]
