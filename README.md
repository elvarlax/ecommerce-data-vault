# Ecommerce Data Vault

This project implements a **Data Vault 2.0** architecture for an ecommerce platform using **dbt**. It organizes data into **Hubs**, **Links**, **Satellites**, **Dimensions**, and **Facts**, combining the robustness of Data Vault methodology with the analytical power of dimensional modeling. The solution is designed to support scalable analytics, reporting, and business intelligence.

## Dataset

The dataset has been anonymized and comprises a subset of more than 3 million grocery orders placed by over 200,000 users on Instacart. Each user's dataset includes between 4 and 100 orders, detailing the sequence of products purchased, the week and time of day when the orders occurred, and a relative measure of time between consecutive orders.

You can download the dataset from [Kaggle](https://www.kaggle.com/c/instacart-market-basket-analysis).

## Project Structure

### **1. Dimensions**
Dimensions enrich reporting and offer descriptive data to enable in-depth analysis:
- **dim_aisle**: Contains attributes related to product aisles.
- **dim_departments**: Holds information about product departments.
- **dim_product**: Provides detailed attributes for products.
- **dim_time**: Standard time dimension to support time-based analysis.

### **2. Facts**
Fact tables store business metrics and aggregations:
- **fact_aisle_orders**: Aggregated order data at the aisle level.
- **fact_department_performance**: Key performance indicators by department.
- **fact_order_analysis**: In-depth analysis of order-level data.
- **fact_order_frequency**: Insights into user order frequencies.
- **fact_orders_by_time**: Aggregated orders based on time.
- **fact_orders**: Overview of customer orders.
- **fact_product_department_sales**: Product and department sales metrics.
- **fact_product_reorder**: Data on product reorders.
- **fact_product_sales**: Detailed product sales data.
- **fact_user_order_analysis**: User-level order behavior insights.

### **3. Hubs**
Hubs contain the unique identifiers (keys) for core business entities:
- **hub_aisle**: Unique identifier for aisles.
- **hub_department**: Unique identifier for departments.
- **hub_order**: Unique identifier for orders.
- **hub_product**: Unique identifier for products.

### **4. Links**
Links represent relationships between business entities:
- **link_order_product**: Describes the relationship between orders and products.
- **link_product_department**: Represents the relationship between products and departments.

### **5. Satellites**
Satellites store historical and descriptive data:
- **sat_department**: Historical changes for department attributes.
- **sat_order**: Historical order data, tracking changes over time.
- **sat_product**: Historical product information.
- **sat_aisle**: Historical aisle-related data.

### **6. Staging**
Staging tables handle the raw, unprocessed data from source systems:
- **stg_aisles**: Raw data for aisles.
- **stg_departments**: Raw department data.
- **stg_order_products**: Raw data linking orders to products.
- **stg_orders**: Raw order data.
- **stg_products**: Raw product data.

## Sources

Data is sourced from the **ecommerce** schema, which includes the following key tables:
- **aisles**: Contains data about aisles.
- **departments**: Contains data about product departments.
- **products**: Contains detailed product attributes.
- **orders**: Includes customer order information.
- **order_products**: Describes product details within orders.

## Installation

1. Clone this repository.
2. Set up a PostgreSQL database environment.
3. Use **dbt** to execute the models, which will create the necessary tables and populate data.

## Usage

- **Fact Tables**: Provide insights into orders, products, and user behaviors, enabling business intelligence and reporting.
- **Dimension Tables**: Offer enriched data to improve reporting and support dimensional analysis.
- **Hubs, Links, and Satellites**: Enable efficient tracking of data lineage, relationships, and historical data, supporting an auditable and scalable data architecture.