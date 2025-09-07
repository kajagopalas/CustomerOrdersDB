CustomerOrdersDB – SQL Analytics & BI Project
Project Overview

CustomerOrdersDB is a practical, self-developed SQL project that simulates complex customer order management and analytics for real-world business scenarios.

This project is designed to continuously strengthen SQL proficiency while demonstrating hands-on business intelligence (BI) and analytics solutions.

Database: SQL Server

Data Type: Synthetic but realistic data created specifically for this project

Fact Table Handling: Microsoft Excel (structured and used for data loading/testing)

Visualization Layer: MicroStrategy (MSTR) dashboards for BI insights

Features

Realistic Business Scenario – Represents actual customer order workflows with customers, orders, products, and related details.

Advanced SQL Queries – Covers joins, aggregations, CTEs, window functions, subqueries, and analytics queries.

Normalized Schema Design – Follows relational modeling best practices for integrity and efficiency.

Date Hierarchy Dimension – Structured hierarchy (Year > Quarter > Month > Day) for time-based analysis.

Product Hierarchy Dimension – Structured hierarchy (Category > Subcategory > Product) for product-level and portfolio-level analysis.

Synthetic Data & Use Cases – Includes sample synthetic datasets with realistic patterns.

Visualization with MSTR – Interactive dashboards built in MicroStrategy for KPI tracking, trend analysis, and BI storytelling.

Active Development – Continuously updated with new queries, optimizations, and dashboards.

Dashboards & Visualizations (MSTR)

The CustomerOrdersDB project powers MicroStrategy dashboards, showcasing customer behavior, sales performance, and product insights.

Example Dashboards

Core Business Performance KPIs – Revenue, AOV, items per order, and top-line metrics.

Business Performance Overview – Revenue by product/salesperson and daily trends.

Order Performance Analysis – Product-level performance, time-series sales, and revenue vs. quantity trends.

File Structure
CustomerOrdersDB/
│
├── Schema/                     # Table & schema creation scripts
├── Queries/                    # SQL queries grouped by concept/scenario
├── Data/                       # Synthetic sample data (insert scripts, Excel fact table)
├── Indexes/                    # Index optimization scripts
├── Stored_Procedures/          # Encapsulated SQL business logic
├── Views/                      # Predefined SQL views for reporting
├── Docs/                       # Dimensional/ER diagrams & documentation
└── README.md                   # Project overview & instructions

Getting Started

Clone the Repository

git clone https://github.com/yourusername/CustomerOrdersDB.git
cd CustomerOrdersDB


Set Up Database (SQL Server)

Run SQL scripts in Schema/ folder.

Insert Sample Data

Use Data/insert_sample_data.sql and Excel fact table for loading synthetic datasets.

Explore Queries

Run queries in Queries/ to practice advanced SQL techniques.

Visualize in MSTR

Connect SQL Server + Excel fact table to MicroStrategy and explore dashboards.

Prerequisites

SQL Server (preferred database)

Microsoft Excel (fact table dataset)

MicroStrategy (MSTR) for visualization

Basic knowledge of SQL & relational modeling

Development & Maintenance

Actively improved with more queries, sample data, and BI visualizations.

Portfolio-driven: Built as both a self-learning resource and professional BI/SQL showcase.

Technologies Used: SQL Server, Excel, MicroStrategy, Git.

Contributions

Suggestions and pull requests are welcome.
Feel free to fork, experiment, and propose improvements!

This project reflects ongoing self-driven learning and serves as a strong foundation for SQL, BI, and analytics expertise.
