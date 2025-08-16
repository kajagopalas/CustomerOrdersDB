-- Create and use database
CREATE DATABASE CustomerOrdersDB;
USE CustomerOrdersDB;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT NOT NULL ,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
	Constraint PK Primary Key (customer_id)
)

-- Orders Table
CREATE TABLE Orders (
    order_id INT NOT NULL ,
    customer_id INT  NULL,
    order_date DATE,
    total_amount DECIMAL(10,2),
	Constraint PK1 Primary Key (order_id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
)

-- Products Table
CREATE TABLE Products (
    product_id INT NOT NULL ,
    unit_price DECIMAL(10,2),
	Constraint PK2 Primary Key (product_id)
)

-- OrderItems Table
CREATE TABLE OrderItems (
    order_item_id INT NOT NULL ,
    order_id INT  NULL,
    product_id INT  NULL,
    quantity INT,
    price DECIMAL(10,2),
	Constraint PK3 Primary Key (order_item_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Products(product_id)
)

-- Salespersons Table
CREATE TABLE Salespersons (
    salesperson_id INT NOT NULL ,
    name VARCHAR(100),
    city VARCHAR(50),
    commission DECIMAL(5,2)  ,
	Constraint PK4 Primary Key (salesperson_id)
)

-- CustomerSalesperson  Table
CREATE TABLE CustomerSalesperson (
    customer_id INT NOT NULL,
    salesperson_id INT NOT NULL,
    CONSTRAINT fk_cs_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_cs_salesperson FOREIGN KEY (salesperson_id) REFERENCES Salespersons(salesperson_id)
)

Create Table Calendar (
Date Date Not NULL,
Constraint PK_Calendar Primary Key (Date))


-- DimYear

CREATE TABLE DimYear (
    Year_ID INT NOT NULL,
    Year_Name VARCHAR(4) NOT NULL,
    CONSTRAINT PK_Year PRIMARY KEY (Year_ID)
);

-- DimQuarter

CREATE TABLE DimQuarter (
    Quarter_ID INT NOT NULL,
    Year_ID INT NOT NULL,
    Quarter_Name VARCHAR(6) NOT NULL,
    CONSTRAINT PK_Quarter PRIMARY KEY (Quarter_ID),
    CONSTRAINT FK_Quarter_Year FOREIGN KEY (Year_ID)
        REFERENCES DimYear(Year_ID)
);


-- DimMonth

CREATE TABLE DimMonth (
    Month_ID INT NOT NULL,
    Quarter_ID INT NOT NULL,
    Year_ID INT NOT NULL,
    Month_Name VARCHAR(20) NOT NULL,
    Month_Number INT NOT NULL,
    CONSTRAINT PK_Month PRIMARY KEY (Month_ID),
    CONSTRAINT FK_Month_Quarter FOREIGN KEY (Quarter_ID)
        REFERENCES DimQuarter(Quarter_ID),
    CONSTRAINT FK_Month_Year FOREIGN KEY (Year_ID)
        REFERENCES DimYear(Year_ID)
);


-- DimWeek

CREATE TABLE DimWeek (
    Week_ID INT NOT NULL,
    Year_ID INT NOT NULL,
    Week_Number INT NOT NULL
    CONSTRAINT PK_Week PRIMARY KEY (Week_ID),
    CONSTRAINT FK_Week_Year FOREIGN KEY (Year_ID)
        REFERENCES DimYear(Year_ID)
);


-- DimDate

CREATE TABLE DimDate (
    Date_ID DATE NOT NULL,
    Day_Of_Week VARCHAR(10) NOT NULL,
    Day_Number INT NOT NULL,
    Week_ID INT NOT NULL,
    Month_ID INT NOT NULL,
    Quarter_ID INT NOT NULL,
    Year_ID INT NOT NULL,
    CONSTRAINT PK_Date PRIMARY KEY (Date_ID),
    CONSTRAINT FK_Date_Week FOREIGN KEY (Week_ID)
        REFERENCES DimWeek(Week_ID),
    CONSTRAINT FK_Date_Month FOREIGN KEY (Month_ID)
        REFERENCES DimMonth(Month_ID),
    CONSTRAINT FK_Date_Quarter FOREIGN KEY (Quarter_ID)
        REFERENCES DimQuarter(Quarter_ID),
    CONSTRAINT FK_Date_Year FOREIGN KEY (Year_ID)
        REFERENCES DimYear(Year_ID)
);



INSERT INTO DimYear (Year_ID, Year_Name)
SELECT DISTINCT
    YEAR(Date) AS Year_ID,
    CAST(YEAR(Date) AS CHAR(4)) AS Year_Name
FROM Calendar


INSERT INTO DimQuarter (Quarter_ID, Year_ID, Quarter_Name)
SELECT DISTINCT
    (YEAR(Date) * 10) + DATEPART(QUARTER, Date) AS Quarter_ID,
    YEAR(Date) AS Year_ID,
    CONCAT('Q', DATEPART(QUARTER, Date)) AS Quarter_Name
FROM Calendar


INSERT INTO DimMonth (Month_ID, Quarter_ID, Year_ID, Month_Name, Month_Number)
SELECT DISTINCT
    (YEAR(Date) * 100) + MONTH(Date) AS Month_ID,
    (YEAR(Date) * 10) + DATEPART(QUARTER, Date) AS Quarter_ID,
    YEAR(Date) AS Year_ID,
    DATENAME(MONTH, Date) AS Month_Name,
    MONTH(Date) AS Month_Number
FROM Calendar

INSERT INTO DimWeek (Week_ID, Year_ID, Week_Number)
SELECT DISTINCT
    (YEAR(Date) * 100) + DATEPART(WEEK, Date) AS Week_ID,
    YEAR(Date) AS Year_ID,
    DATEPART(WEEK, Date) AS Week_Number
FROM Calendar


INSERT INTO DimDate (Date_ID, Day_Of_Week, Day_Number, Week_ID, Month_ID, Quarter_ID, Year_ID)
SELECT
    Date AS Date_ID,
    DATENAME(WEEKDAY, Date) AS Day_Of_Week,
    DAY(Date) AS Day_Number,
    (YEAR(Date) * 100) + DATEPART(WEEK, Date) AS Week_ID,
    (YEAR(Date) * 100) + MONTH(Date) AS Month_ID,
    (YEAR(Date) * 10) + DATEPART(QUARTER, Date) AS Quarter_ID,
    YEAR(Date) AS Year_ID
FROM Calendar

CREATE TABLE DimProduct_Category (
    ProductCategoryID INT NOT NULL PRIMARY KEY,
    ProductCategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE DimProduct_Subcategory (
    ProductSubcategoryID INT NOT NULL PRIMARY KEY,
    ProductSubcategoryName VARCHAR(50) NOT NULL,
    ProductCategoryID INT NOT NULL,
    CONSTRAINT FK_ProductCategoryID FOREIGN KEY (ProductCategoryID) REFERENCES DimProduct_Category(ProductCategoryID)
);

CREATE TABLE DimProduct (
    ProductID INT NOT NULL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    ProductSubcategoryID INT NOT NULL,
    CONSTRAINT FK_ProductSubcategoryID FOREIGN KEY (ProductSubcategoryID) REFERENCES DimProduct_Subcategory(ProductSubcategoryID)
);
