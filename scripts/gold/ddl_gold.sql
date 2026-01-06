/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/


-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================

DROP VIEW IF EXISTS gold.fact_sales CASCADE;

CREATE VIEW gold.fact_sales AS
	SELECT 
	sa.sls_ord_num AS order_number,
	ca.customer_key,
	pr.product_key,
	sa.sls_order_dt AS order_date ,
	sa.sls_ship_dt AS  shipping_date,
	sa.sls_due_dt AS due_date,
	sa.sls_sales AS sales_amount,
	sa.sls_quantity AS quantity, 
	sa.sls_price As price
	FROM 
	silver.crm_sales_details sa
	LEFT JOIN   gold.dim_customers ca
	ON 		sa.sls_cust_id= ca.customer_id
	LEFT JOIN   gold.dim_products pr
	ON		sa.sls_prd_key = pr.product_number;



-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

DROP VIEW IF EXISTS gold.dim_products CASCADE;

CREATE VIEW gold.dim_products AS
	Select
	ROW_NUMBER() OVER (ORDER BY pr.prd_start_dt ,pr.prd_key) AS product_key,
	pr.prd_id AS product_id,
	pr.prd_key AS product_number,
	pr.prd_nm AS product_name,
	pr.cat_id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance,
	pr.prd_cost AS  product_cost,
	pr.prd_line As  product_line,
	pr.prd_start_dt AS start_date
	FROM  silver.crm_prd_info pr 
	LEFT JOIN  silver.erp_px_cat_g1v2 pc
	ON	pr.cat_id = pc.id
	WHERE prd_end_dt IS NULL ; ---- Filter all historical data

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

DROP VIEW IF EXISTS gold.dim_customers CASCADE;

CREATE VIEW  gold.dim_customers AS
	Select
	ROW_NUMBER() OVER( ORDER BY ci.cst_id) AS customer_key,
	ci. cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname  AS last_name,
	lo.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE WHEN cst_gndr != 'n/a' THEN cst_gndr
		ElSE COALESCE(gen,'n/a')
	END as gender ,
	ca.bdate  AS birthdate,
	ci.cst_create_date AS create_date 
	
	FROM silver.crm_cust_info ci 
	LEFT JOIN  silver.erp_cust_az12  ca  ON ci.cst_key= ca.cid
	LEFT JOIN  silver.erp_loc_a101 lo  ON  ci.cst_key= lo.cid;
