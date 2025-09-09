## Project Overview

CustomerOrdersDB is a practical, self-developed SQL project that simulates complex customer order management and analytics for real-world business scenarios.

Designed to continuously strengthen SQL proficiency and demonstrate hands-on solutions for business intelligence and data analytics.

- **Dimensional Models Used**:

       First, Schema was designed for querying and OLAP analysis  
      (Diagram: Dimensional_Model_For_Queries.jpg)

      Later, the model was refined into a Snowflake Schema for more detailed analytics  
      (Diagram: CustomerOrdersDB_Dimensional_Model_Snowflake.jpg)

- **Database**:

  SQL Server 
- **Data Type**:

  Synthetic but realistic data created specifically for this project  
- **Fact Table Handling**:

  Microsoft Excel (structured and used for data loading/testing)  
- **Visualization Layer**:

  MicroStrategy (MSTR) dashboards for BI insights  

 
This project demonstrates end-to-end BI/SQL development skills, including database design, advanced SQL queries, and MicroStrategy dashboarding

-----

## Features

**Realistic Business Scenario**: Represents actual customer order workflows with tables for customers, orders, products, and related details.

**Advanced SQL Queries**: Demonstrates joins, aggregations, CTEs, window functions, and subqueries to perform insightful data analysis.

**Normalized Schema Design**: Follows industry best practices for relational integrity and efficient data storage.

**Date Hierarchy Dimension**: Implements a structured date hierarchy (Year \> Quarter \> Month \> Day) to enable flexible time-based analysis and reporting.

**Product Hierarchy Dimension**: Implements a structured product hierarchy (Category \> Subcategory \> Product) to enable flexible product-level, category-level, and portfolio-level analysis and reporting.

**Sample Data & Use Cases**: Includes synthetic but realistic sample data and example queries aligned with common business questions.

**Active Development & Improvement**: Continuously updated with new queries, optimizations, and documentation based on feedback and learning.

-----

## Dashboards & Visualizations

The `CustomerOrdersDB` project can power comprehensive business intelligence dashboards, providing insights into customer behavior, sales performance, and product trends. The following are examples of dashboards and visualizations that can be created using the data and queries from this project.

### Core Business Performance KPIs

This dashboard provides a holistic view of key sales metrics, including total revenue, average order value per customer, and average items per order. It showcases the project's ability to support high-level business overviews and key performance indicators (KPIs).

### Business Performance Overview

This dashboard presents a detailed breakdown of revenue by product and salesperson, alongside daily trend analysis. It demonstrates the use of advanced SQL queries for multi-dimensional analysis, enabling users to identify top-performing products and sales team members.

### Measuring and Analyzing Order Performance

This dashboard focuses on product-specific performance and sales trends over time. It includes tables for product performance and sales trends, as well as a visual representation of revenue versus quantity over time, highlighting the project's capacity for time-series analysis and detailed reporting.

-----

## File Structure

**Schema for queries Practice.sql & CustomerOrdersDB_Fact_Table_Schema**/ -- SQL scripts to create and optimize tables, indexes, relationships

**Queries**/ -- Advanced SQL query scripts grouped by scenario or concept

**Data**/ -- Sample data insert scripts (insert\_sample\_data.sql)

**Indexes**/ – Scripts for creating and maintaining database indexes to improve query performance.

**Stored\_Procedures**/ – Parameterized SQL scripts encapsulating business logic for reusable operations.

**Views**/ – Predefined SQL views for simplified reporting and analytics.

**Docs**/ – Contains CustomerOrdersDB\_Dimensional\_Model.jpg, the ER/Dimensional model diagram.

**README**.md -- Project overview and instructions

-----

## Getting Started

1.  **Clone the Repository**

    ```bash
    git clone https://github.com/yourusername/CustomerOrdersDB.git
    cd CustomerOrdersDB
    ```

2.  **Set Up Database**

      - Run SQL scripts in `Schema/` in your SQL client (MSSQL).

3.  **Insert Sample Data**

      - Execute `Data.sql` to populate tables with realistic data.

4.  **Run Queries**

      - Explore practice queries and analytics challenges in the `Queries/` directory.

-----

## Prerequisites

SQL Server (preferred database)

Microsoft Excel (fact table dataset)

MicroStrategy (MSTR) for visualization

Basic knowledge of SQL & relational modeling

-----

## Development & Maintenance

Actively improved with more queries, sample data, and BI visualizations.

Portfolio-driven – Built as both a self-learning resource and professional BI/SQL showcase.

Technologies Used – SQL Server, Excel, MicroStrategy, Git.

-----

## Contributions

Suggestions and pull requests are welcome.

Feel free to fork, experiment, and propose improvements or additional scenarios\!

## Open Source

This project is released as an **open-source learning resource**.
- **License**: free to use, modify, and share.
- **Goal**: To support SQL/BI learners and professionals in practicing real-world scenarios.
- **How to Contribute**: Fork, experiment, and submit pull requests or open issues with ideas and improvements.

***This project reflects ongoing self-driven learning and serves as a robust foundation for real-world SQL analytics.***
