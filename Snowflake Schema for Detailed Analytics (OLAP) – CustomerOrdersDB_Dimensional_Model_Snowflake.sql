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
    Week_Number INT NOT NULL,
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



Create Table CustomerOrdersDB_Fact (
customer_id VARCHAR(50),
name  VARCHAR(255),
email VARCHAR(255),
city VARCHAR(50),
order_id INT,
order_date DATE,
total_amount DECIMAL(10, 2),
order_item_id INT,
quantity INT,
price DECIMAL(10, 2),
ProductID Int,
unit_price DECIMAL(10, 2),
salesperson_id Int,
salesperson_name VARCHAR(255),
salesperson_city VARCHAR(50),
commission DECIMAL(5, 2),
mapped_salesperson_id Int)

Alter Table CustomerOrdersDB_Fact
Add constraint FK_Date foreign key (order_date) references DimDate(Date_ID)

Alter Table CustomerOrdersDB_Fact
Add constraint FK_PID foreign key (ProductID) references DimProduct(ProductID)

Create Index IN_Date on CustomerOrdersDB_Fact (order_date)
Create Index IN_PID on CustomerOrdersDB_Fact (ProductID)

insert into CustomerOrdersDB_Fact ( customer_id ,
name  ,
email ,
city ,
order_id ,
order_date ,
total_amount,
order_item_id ,
quantity ,
price,
ProductID ,
unit_price,
salesperson_id ,
salesperson_name ,
salesperson_city,
commission ,
mapped_salesperson_id )


SELECT 
    C.customer_id,
    C.name AS customer_name,
    C.email AS customer_email,
    C.city AS customer_city,
    O.order_id,
    O.order_date AS Date,
    O.total_amount,
    OI.order_item_id,
    OI.quantity,
    OI.price AS item_price,
    P.product_id,
    P.unit_price,
    S.salesperson_id,
    S.name AS salesperson_name,
    S.city AS salesperson_city,
    S.commission,
    CS.salesperson_id AS mapped_salesperson_id
FROM Customers C
INNER JOIN Orders O 
    ON C.customer_id = O.customer_id
INNER JOIN OrderItems OI 
    ON O.order_id = OI.order_id
INNER JOIN Products P 
    ON OI.product_id = P.product_id
INNER JOIN CustomerSalesperson CS 
    ON C.customer_id = CS.customer_id
INNER JOIN Salespersons S 
    ON CS.salesperson_id = S.salesperson_id
