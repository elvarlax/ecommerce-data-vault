# Ecommerce Data Vault

## Overview

This project implements a **Data Vault 2.0** architecture for an ecommerce platform using **dbt**. The architecture organizes data into **Hubs, Links, Satellites, Point-in-Time (PIT) Tables, Bridge Tables, Dimensions, and Facts**, ensuring a scalable, auditable, and efficient analytical data model.

## Dataset

The dataset consists of anonymized ecommerce transactions, capturing over **3 million grocery orders** from more than **200,000 users**. It provides insights into:

- Order sequences
- Products purchased per order
- Day and time of orders
- Time gaps between consecutive purchases

The dataset is publicly available on [Kaggle](https://www.kaggle.com/c/instacart-market-basket-analysis).

## Project Structure

### **1. Staging (Raw Data Processing)**

Staging tables handle raw, unprocessed data from source systems and prepare it for Data Vault modeling:

- **stg_aisles**: Raw data for aisles.
- **stg_departments**: Raw department data.
- **stg_order_products**: Raw data linking orders to products.
- **stg_orders**: Raw order data.
- **stg_products**: Raw product data.

### **2. Hubs (Core Business Entities)**

Hubs store unique business keys, providing a single source of truth for key business entities:

- **hub_aisle**: Unique identifier for aisles.
- **hub_department**: Unique identifier for departments.
- **hub_order**: Unique identifier for orders.
- **hub_product**: Unique identifier for products.
- **hub_user**: Unique identifier for users.

### **3. Links (Entity Relationships)**

Links establish relationships between business entities and enable historical tracking:

- **link_order_product**: Connects orders to products.
- **link_product_department**: Maps products to departments.
- **link_order_user**: Associates users with their orders.

### **4. Satellites (Historical & Descriptive Data)**

Satellites store attributes and historical changes for business entities:

- **sat_aisle**: Historical changes for aisle attributes.
- **sat_department**: Historical changes for department attributes.
- **sat_order**: Tracks historical order data over time.
- **sat_order_product**: Tracks order-product interactions, including reorder status.
- **sat_product**: Stores product information.
- **sat_user**: Tracks user-related changes.

### **5. PIT Tables (Point-in-Time Snapshots for Query Optimization)**

PIT tables speed up historical data retrieval by storing the latest valid data per key:

- **pit_order**: Latest state of orders.
- **pit_order_user**: Latest state of user orders.
- **pit_order_product**: Latest order-product relationships.
- **pit_product**: Latest product attributes.

### **6. Bridge Tables (Many-to-Many Relationship Optimization)**

Bridge tables optimize queries involving **many-to-many** relationships:

- **brg_order_product**: Precomputes metrics for order-product relationships, improving query performance.

### **7. Dimensions (Enriched Analytical Views)**

Dimensions provide descriptive data for reporting and business intelligence:

- **dim_aisle**: Attributes related to product aisles.
- **dim_department**: Department-level attributes.
- **dim_product**: Enriched attributes for products.
- **dim_user**: Aggregated user-level attributes.
- **dim_order**: Enriched order details.

### **8. Facts (Aggregated Business Metrics)**

Fact tables store numerical data for analytical reporting and dashboards:

- **fact_orders**: Aggregated order data per customer.
- **fact_orders_by_time**: Time-based analysis of orders.
- **fact_product_sales**: Key sales metrics for products.
- **fact_product_reorder**: Tracks product reorder rates.
- **fact_user_order_analysis**: Provides insights into user purchasing behavior.

## Data Sources

The data is sourced from the **ecommerce** schema, which includes:

- **aisles**: Contains data about aisles.
- **departments**: Contains data about product departments.
- **products**: Contains detailed product attributes.
- **orders**: Includes customer order information.
- **order_products**: Describes product details within orders.

## Installation

1. Clone this repository:
   ```sh
   git clone https://github.com/elvarlax/ecommerce-data-vault
   cd ecommerce-data-vault
   ```
2. Set up a PostgreSQL database environment.
3. Run dbt tests:
   ```sh
   dbt test
   ```

## Usage

- **Fact Tables**: Provide insights into orders, products, and user behaviors for business intelligence and reporting.
- **Dimension Tables**: Improve reporting with descriptive data for entities.
- **Hubs, Links, Satellites**: Enable scalable historical tracking and data lineage for auditability.
- **PIT & Bridge Tables**: Optimize query performance and accelerate analytical workflows.

## Performance Optimization Strategies

- **Indexing**: Key business keys (`hub_order_id`, `hub_product_id`) are indexed to optimize joins.
- **Pre-aggregations**: Bridge tables precompute totals to reduce query complexity.
- **Point-in-Time Tables (PIT)**: Snapshots reduce the need for costly historical joins.
- **Custom Indexing**: The following indexes enhance query performance:
  ```sql
  CREATE INDEX idx_link_order_product ON public.link_order_product (hub_order_id, hub_product_id);
  CREATE INDEX idx_sat_order_product ON public.sat_order_product (hub_order_id, hub_product_id);
  CREATE INDEX idx_brg_order_product ON public.brg_order_product (hub_order_id, hub_product_id);
  CREATE INDEX idx_fact_product_sales ON public.fact_product_sales (hub_product_id);
  CREATE INDEX idx_pit_order_product ON public.pit_order_product (hub_order_id, hub_product_id);
  
  ANALYZE public.link_order_product;
  ANALYZE public.sat_order_product;
  ANALYZE public.brg_order_product;
  ANALYZE public.fact_product_sales;
  ANALYZE public.pit_order_product;
  ```

---

**Built with ❤️ using dbt, PostgreSQL, and Data Vault 2.0.** 🚀