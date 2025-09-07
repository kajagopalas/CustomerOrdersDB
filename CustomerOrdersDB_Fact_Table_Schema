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
