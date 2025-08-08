
List all customers.
Select [name]  from [dbo].[Customers]

Display all products.
Select distinct [product_name] from [dbo].[Products]

Find all salespersons.
Select distinct [name] from [dbo].[Salespersons]

Show all orders placed.
Select  [order_id] from [dbo].[Orders]

List all order items.
Select [order_item_id] from [dbo].[OrderItems]

Retrieve the names and cities of all customers.
Select [name],[city] from [dbo].[Customers]

List all products with a unit price less than 100.
Select distinct [product_id],[price] from [dbo].[OrderItems] where [price] < 100
 
Show customer emails for those residing in ‘Delhi’.
select [email] from [dbo].[Customers] where [city] = 'delhi'
 
List all products that are either ‘Laptop’ or ‘Keyboard’.
select * from [dbo].[Products] where [product_name] = 'Laptop' or [product_name] = 'Keyboard'

Find the product with the highest price.
Select * from (
Select *,Dense_Rank () over (Order by [unit_price] desc) DR from [dbo].[Products]) as A
where DR =1 

List all orders placed on ‘2024-08-04’.
Select [order_id] from [dbo].[Orders] where [order_date] = '2024-08-04'
 
Show all customers with names starting with ‘A’.
Select [name] from [dbo].[Customers] where [name] like 'a%'

Display the email and city for customer ‘Farhan Akhtar’.
Select [email],[city] from [dbo].[Customers] where [name] = 'Farhan Akhtar'

Find all salespersons working in ‘Pune’. 
Select [name] from [dbo].[Salespersons] where [city] = 'pune'

Show products with a price between 20 and 100.
Select * from [dbo].[Products] where [unit_price] between 20 and 100

List all orders sorted by order_date (descending).
Select * from [dbo].[Orders] order by [order_date] desc
 
Show the product names and their unit prices.
Select [product_name],[unit_price] from [dbo].[Products]

Find all salespersons with a commission of 0.12 or higher.
Select * from [dbo].[Salespersons] where [commission] >= 0.12
 
List all customers who have an email ending with ‘@mail.com’.
select * from [dbo].[Customers] where [email] like '%@mail.com'

Count the total number of products available.
Select count([product_name]) NOP from [dbo].[Products]

List all orders along with the customer’s name.
Select A.[name],B.[order_id] from [dbo].[Customers] A join [dbo].[Orders] B on A.[customer_id]=B.[customer_id]
 
Show each order’s items with product names.
Select A.[order_id],C.[product_name] from [dbo].[Orders] A full outer join [dbo].[OrderItems] B on A.[order_id]=B.[order_id]
full outer join [dbo].[Products] C on B.[product_id]=C.[product_id]

Display all customers and their assigned salespersons.
WITH 
CTE1 AS (SELECT [customer_id], [name] AS CN FROM [dbo].[Customers]),
CTE2 AS (SELECT [salesperson_id], [name] AS SN FROM [dbo].[Salespersons]),
CTE3 AS (SELECT * FROM [dbo].[CustomerSalesperson])

SELECT CTE1.CN, CTE2.SN
FROM CTE3
JOIN CTE1 ON CTE1.[customer_id] = CTE3.[customer_id]
JOIN CTE2 ON CTE2.[salesperson_id] = CTE3.[salesperson_id]



Show orders along with salesperson’s names.
With CTE1 as (Select [order_id],[customer_id] from [dbo].[Orders]),
CTE2 as (Select [customer_id],[salesperson_id] from [dbo].[CustomerSalesperson]),
CTE3 as (Select CTE1.[order_id],CTE2.[salesperson_id] from CTE1 join CTE2 on CTE1.[customer_id]=CTE2.[customer_id])

Select CTE3.[order_id],CTE3.[salesperson_id],A.[name] S_Name from CTE3 join [dbo].[Salespersons] A on CTE3.[salesperson_id]=A.[salesperson_id]
 
List all customers who have placed an order for ‘Laptop’.

with CTE1 as (
Select distinct A.[customer_id],C.[product_name] from [dbo].Orders A join [dbo].[OrderItems] B on A.[order_id]=B.order_id
join [dbo].[Products] C on B.[product_id]=C.product_id),
CTE2 as (Select [customer_id],[name] from [dbo].[Customers])
Select CTE2.[name] CN,CTE1.[product_name] from CTE2 join CTE1 on CTE1.customer_id=CTE2.customer_id

Display all order details for customer ‘Carla White’.
Select A.[name],B.[order_id] from [dbo].[Customers] A join [dbo].[Orders] B on A.customer_id=B.customer_id

Show product names ordered in order 14.
Select A.[product_name],B.[order_id] from [dbo].[Products] A join [dbo].[OrderItems] B on A.product_id=B.product_id
where B.[order_id] = 14

List all the salespersons and their customers living in the same city.
select A.[customer_id],B.[salesperson_id],A.city,B.city from [dbo].[Customers] A join [dbo].[Salespersons] B on A.city=B.city
 
Show products that have been ordered along with order dates.
Select A.[product_id],B.[order_date] from [dbo].[OrderItems] A join [dbo].[Orders] B on A.order_id=B.order_id

Find all orders placed by customers assigned to ‘Jane Roland’.
With CTE1 as (Select A.[order_id],B.[salesperson_id] from [dbo].[Orders] A join [dbo].[CustomerSalesperson] B on A.customer_id=B.customer_id)
Select CTE1.[order_id],B.[name] from CTE1 join [dbo].[Salespersons] B on CTE1.[salesperson_id]=B.[salesperson_id]

Count the total number of orders for each customer.
Select [customer_id],Count([order_id]) NO from [dbo].[Orders]
Group by [customer_id]

Show total sales (sum of total_amount) for each city.
Select A.[city],Sum(B.[total_amount]) TS from [dbo].[Customers] A join [dbo].[Orders] B on A.customer_id=B.customer_id
Group by A.[city]

Find the total amount spent by each customer.
Select [customer_id],Sum([total_amount]) TS from [dbo].[Orders]
Group by [customer_id]

Display the number of products in each order.
Select [order_id],Count([product_id]) NP from [dbo].[OrderItems]
Group by [order_id]

Find the average unit price for all products.
Select AVG([unit_price]) from [dbo].[Products]

Show the maximum order total for each customer.
Select [customer_id],max([total_amount]) TA from [dbo].[Orders]
Group by [customer_id]

List all salespersons and the total sales by their customers.
with CTE1 as (Select [customer_id],Sum([total_amount]) TS from [dbo].[Orders]
Group by [customer_id]),
CTE2 as (select A.[salesperson_id],CTE1.TS from CTE1 join [dbo].[CustomerSalesperson] A on A.[customer_id]=CTE1.[customer_id])
select A.[name],CTE2.TS from [dbo].[Salespersons] A join CTE2 on A.[salesperson_id]=CTE2.[salesperson_id]

Find the customer with the highest number of orders.
Select * from (
Select [customer_id],NO,Dense_Rank () over (Order by NO desc) DR from (
Select [customer_id],Count([order_id]) NO from [dbo].[Orders]
Group by [customer_id]) as A) as B
where B.DR=1

Count how many times each product has been ordered.
Select [product_id],Count(DISTINCT order_id) NT 
from [dbo].[OrderItems]
Group by [product_id]

Show the total quantity sold per product.
Select [product_id],Sum([quantity]) TQ from [dbo].[OrderItems]
Group by [product_id]

List customers who have never placed an order.
Select A.[customer_id],B.[order_id] from [dbo].[Customers] A left join [dbo].Orders B on A.[customer_id]=B.[customer_id]
where B.[order_id] is null

Show orders that do not contain any products priced above 100.
SELECT order_id  
FROM OrderItems  
GROUP BY order_id  
HAVING MAX(price) <= 100  

Find product(s) that have never been ordered.
Select A.[product_id],B.[order_id] from [dbo].[Products] A left join [dbo].[OrderItems] B on A.[product_id]=B.[product_id]
where B.[order_id] is null

Display customers who have made orders in both ‘Mumbai’ and ‘Delhi’.
SELECT A.[name]
FROM [dbo].[Customers] A
JOIN [dbo].[Orders] B ON A.customer_id = B.customer_id
WHERE A.city IN ('Mumbai', 'Delhi')
GROUP BY A.name
HAVING COUNT(DISTINCT A.city) = 2

Find orders with only one product item.
Select [order_id],COunt([product_id]) NP from [dbo].[OrderItems]
Group by [order_id]
having COunt([product_id]) = 1

Show customers who have placed more than two orders.
Select [customer_id],Count([order_id]) NO from [dbo].[Orders]
Group by [customer_id]
having Count([order_id]) > 2

List salespersons who have no customers assigned.
SELECT A.name  
FROM Salespersons A  
LEFT JOIN CustomerSalesperson B  
ON A.salesperson_id = B.salesperson_id  
WHERE B.customer_id IS NULL  

Find orders where the order total exceeds 500.
Select [order_id],[total_amount] from [dbo].[Orders]
where [total_amount] > 500

List products that have been ordered by all customers.
select distinct A.[product_id],count(B.[customer_id]) from [dbo].[OrderItems] A join [dbo].[Orders] B on A.order_id=B.order_id
group by A.[product_id]
having count(B.[customer_id])  = (select count(*) from [dbo].[Customers])

Show orders placed in the last 7 days (use CURRENT_DATE).
Select * from [dbo].[Orders] where [order_date] between  dateadd(DD,-7,cast(getdate() as date)) and cast(getdate() as date)

List each customer’s first order details.
select * from (
select *,dense_rank () over (partition by customer_id Order by [order_date]) Dr from [dbo].[Orders]) as A
where DR =1 

Display orders where the total_amount does not match the sum of order items.
SELECT O.order_id  
FROM Orders O  
JOIN (
  SELECT order_id, SUM(price * quantity) AS correct_total  
  FROM OrderItems  
  GROUP BY order_id  
) T ON O.order_id = T.order_id  
WHERE O.total_amount != T.correct_total  


Show products ordered only by customers from ‘Bangalore’.
Select distinct D.product_name from [dbo].[Customers] A join [dbo].[Orders] B on A.[customer_id]=B.[customer_id]
join [dbo].[OrderItems] C on B.[order_id]=C.[order_id]
join [dbo].[Products] D on C.[product_id]=D.[product_id]
where A.[city] in ('Bangalore')

Find the top 3 products by sales amount.
Select C.[product_name],sum(B.[total_amount]) TS from [dbo].[OrderItems] A join [dbo].[Orders] B on A.[order_id]=B.[order_id]
join [dbo].[Products] C on A.[product_id]=C.[product_id]
Group by C.[product_name]

List customers who have purchased all products.
select A.[customer_id],count (distinct B.[product_id]) NOP from [dbo].[Orders] A join [dbo].[OrderItems] B on A.[order_id]=B.[order_id]
Group by A.[customer_id]
having count (distinct B.[product_id]) = (select count(*) from [dbo].[Products])

Find customers who have never ordered ‘Smartphone’.


select  distinct A.[name] from [dbo].[Customers] A join CTE1 on CTE1.[customer_id]=A.[customer_id]

Display total number of orders that include ‘Headphones’.

SELECT name
FROM Customers C
WHERE NOT EXISTS (
  SELECT 1
  FROM Orders O
  JOIN OrderItems OI ON O.order_id = OI.order_id
  JOIN Products P ON OI.product_id = P.product_id
  WHERE O.customer_id = C.customer_id
    AND P.product_name = 'Smartphone'
)

List products that have never been sold in Hyderabad.
Select distinct  D.[product_name],A.[city] from [dbo].[Customers] A join [dbo].[Orders] B on A.[customer_id]=B.[customer_id]
join [dbo].[OrderItems] C on B.[order_id]=C.[order_id]
join [dbo].[Products] D on C.[product_id]=D.[product_id]
where A.[city] not in ('Hyderabad')

Show the average total for orders placed by ‘Eva Green’.
Select A.[name],AVG(B.[total_amount]) ATA from [dbo].[Customers] A join [dbo].[Orders] B on A.[customer_id]=B.[customer_id]
where A.[name] in ('Eva Green')
Group by A.[name] 

Find the salesperson with the highest commission.
select * from (
Select [name],[commission],dense_rank () over (order by [commission] desc) DR from [dbo].[Salespersons]) as A
where DR=1

Show orders that include more than one product.
Select [order_id] from [dbo].[OrderItems]
group by [order_id]
having count([product_id]) > 1

List the salespersons who have customers with orders over 1,000.
Select [name] from [dbo].[Salespersons] where [salesperson_id] in (
Select [salesperson_id] from [dbo].[CustomerSalesperson] where [customer_id] in (
Select [customer_id] from [dbo].[Orders]
Group by [customer_id]
having sum([total_amount])  > 1000) )

Display the city and number of customers in each.
Select [city],Count([customer_id]) NOC from [dbo].[Customers]
Group by [city]

Find products whose price is above the average price.
Select * from [dbo].[Products] where [unit_price] > (select AVG([unit_price]) from [dbo].[Products])

For each customer, list products they have never ordered.
WITH CTE_OrderedProducts AS (
    SELECT DISTINCT O.customer_id, OI.product_id
    FROM [dbo].[Orders] O
    JOIN [dbo].[OrderItems] OI ON O.order_id = OI.order_id
)

SELECT C.customer_id, P.product_id, P.product_name
FROM [dbo].[Customers] C
CROSS JOIN [dbo].[Products] P
LEFT JOIN CTE_OrderedProducts OP ON C.customer_id = OP.customer_id AND P.product_id = OP.product_id
WHERE OP.product_id IS NULL
ORDER BY C.customer_id, P.product_id;

Show all products along with the number of unique customers for each.
Select A.[product_id],Count(Distinct B.[customer_id]) NUC from [dbo].[OrderItems] A join [dbo].[Orders] B on A.order_id=B.order_id
Group by A.[product_id]
 
List customers who have placed their first order after ‘2024-08-05’.
select * from (
Select [customer_id],[order_date],Dense_Rank () over (partition by [customer_id] order by [order_date]) DR from [dbo].[Orders] where [order_date] > '2024-08-05') as A
where DR =1 

Find the smallest order (by total_amount) for each customer.
Select [customer_id],Min([total_amount]) SA from [dbo].[Orders]
group by [customer_id]

List salespersons who have more than one customer.
select [name] from [dbo].[Salespersons] where [salesperson_id] in (
Select [salesperson_id]  from [dbo].[CustomerSalesperson]
Group by [salesperson_id]
having Count(distinct [customer_id]) > 1)

Assign row numbers to customers ordered by customer_id.
Select *,Row_number () over (Order by [customer_id]) RN from [dbo].[Customers]

List the second-highest value order for each customer.
Select [customer_id],[total_amount] from (
Select *,Dense_Rank () over (partition by [customer_id] order by [total_amount] desc) DR from [dbo].[Orders]) as A
where DR = 2

Find customers with the earliest and latest order dates.
Select [customer_id],Min([order_date]) Earliest,Max([order_date]) Latest from [dbo].[Orders]
group by [customer_id]

Rank customers by their total sales amount.
Select *,Dense_Rank () over (Order by TS) Rank from (
Select [customer_id],Sum([total_amount]) TS from [dbo].[Orders]
group by [customer_id]) as A

Show orders and their cumulative total amounts by customer.
Select [customer_id],[order_id],[order_date],[total_amount],sum([total_amount]) over (order by [order_date] rows between unbounded preceding and current row) RT from [dbo].[Orders]


For each product, show the order that bought the most units.

select [product_id],[order_id],max([quantity]) MU from (
Select * from (
Select [product_id],[order_id],[quantity],dense_rank () over (partition by [product_id],[order_id] order by [quantity] desc) Rank   from [dbo].[OrderItems]) as A
where Rank = 1) as B
group by [product_id],[order_id]

Find the average commission rate by city for salespersons.
select [city],AVG([commission]) AC from [dbo].[Salespersons]
group by [city]

Show, for each customer, the product they ordered in highest quantity.

Select * from (
select A.[customer_id],B.[product_id],B.[quantity],Dense_Rank () over (partition by [customer_id] order by [quantity] desc) rank from [dbo].[Orders] A join [dbo].[OrderItems] B on A.[order_id]=B.order_id) as A
where rank =1 

List all products and update unit_price to unit_price * 1.10.

update   dbo.Products
set unit_price = unit_price * 1.10

select * from [dbo].[Products]

Create a view for top 5 best-selling products.
create or alter View VC as (
Select [product_id],TS from (
Select *,Dense_Rank () over (order by TS desc) Rank  from (
select A.[product_id],Sum(B.[total_amount]) TS from [dbo].[OrderItems] A join [dbo].[Orders] B on A.order_id=B.order_id
Group by A.[product_id]) as A) as B
where Rank <=5)

Insert a new customer named ‘Gopal Verma’ in ‘Kolkata’.
insert into Customers (customer_id,name,city) values (7,'Gopal Verma','Kolkata')


Update ‘Mouse’ unit price to 20.

Update [dbo].[Products]
set  unit_price = 20 where [product_name] ='Mouse'


Delete all order items for orders before ‘2024-08-01’.

Select * into Orders_D from [dbo].[Orders]
Select * into OrderItems_D from [dbo].[OrderItems]

DELETE B
FROM OrderItems_D B
JOIN Orders_D A ON A.order_id = B.order_id
WHERE A.order_date < '2024-08-01'


Assign ‘Gopal Verma’ to salesperson ‘Jane Roland’.


select * from [dbo].[Customers]
Select [salesperson_id],[name] from [dbo].[Salespersons]
where [name] in ('Jane Roland')
select * from [dbo].[CustomerSalesperson]
insert into CustomerSalesperson values (7,501)

Insert a new order for ‘Gopal Verma’ with 2 items.
select * from [dbo].[Orders]
select * from [dbo].[OrderItems]

insert into [OrderItems] values (14,17,107,2,90)
insert into [Orders] values (17,7,'2024-05-12',1200)

Update the commission for ‘Paul Atkinson’ to 0.14.
update Salespersons
set [commission] = 0.14 where [name] in ('Paul Atkinson')

Remove all customers with no orders.

Select * into Customers_R from [dbo].[Customers]
delete from Customers_R where [customer_id] not in (select distinct [customer_id] from Orders)

Add ‘Tablet’ as a new product for 200.
Select * from [dbo].[Products]
insert into [Products] values (108,'Tablet',200)

Update every order’s total_amount as sum of its order items.

UPDATE O
SET O.total_amount = T.total
FROM [dbo].[Orders] O
JOIN (
    SELECT order_id, SUM(price * quantity) AS total
    FROM [dbo].[OrderItems]
    GROUP BY order_id
) T ON O.order_id = T.order_id;


Delete products that are not in any order.
delete from Products_R
where not exists (
  select 1 from OrderItems OI where OI.product_id = Products_R.product_id
)

List customer names and the total number of different products they’ve purchased.
Select A.[customer_id],Count(distinct B.[product_id]) NOP from [dbo].[Orders] A join [dbo].[OrderItems] B on A.order_id=B.order_id
Group by A.[customer_id]

Find products ordered together in the same order (order bundles).

Select distinct([product_id]),[order_id] from [dbo].[OrderItems] where [order_id] in (
Select [order_id]NOP from [dbo].[OrderItems]
Group by [order_id]
having Count(distinct [product_id])  > 1)

For each salesperson, list their customers and each customer's last order date.

with CTE1 as (Select [customer_id],Max([order_date]) LOD from [dbo].[Orders]
Group by customer_id)

Select Distinct A.[salesperson_id],CTE1.customer_id from [dbo].[CustomerSalesperson] A join CTE1 on A.customer_id=CTE1.customer_id

Show sales trends by product (orders per month).
Select Month([order_date]) Month,Sum([total_amount]) TS from [dbo].[Orders]
Group by  Month([order_date])

Find customers whose last order was more than 90 days ago.
Select customer_id,OD,Datediff(DD,OD,cast(getdate() as date)) Diff from (
Select [customer_id],Max([order_date]) OD from [dbo].[Orders]
Group by customer_id) as A
where Datediff(DD,OD,cast(getdate() as date)) > 90


List customers who spent more this year than last year.

with TY as (Select  [customer_id],Sum([total_amount]) TYI from [dbo].[Orders]
where Year([order_date]) =  Year(getdate())
Group by customer_id),

LY as (Select  [customer_id],Sum([total_amount]) LYI from [dbo].[Orders]
where Year([order_date]) =  Year(dateadd(YYYY,-1,getdate()))
Group by customer_id)

Select TY.customer_id,TY.TYI,LY.LYI from TY join LY on TY.customer_id=LY.customer_id
where TY.TYI > LY.LYI

Find products where total units sold exceeds 5.
Select [product_id],Sum([quantity]) TQ from [dbo].[OrderItems]
Group by product_id
having Sum([quantity]) > 5


List all combinations of customers and products (cross join).
Select A.[customer_id],B.[product_name] from [dbo].[Customers] A cross join Products B

Show salespersons with orders.
Select A.[order_id],B.[salesperson_id] from [dbo].[Orders] A join [dbo].[CustomerSalesperson] B on A.customer_id=B.customer_id

List customer names who have emails containing the word "test".
Select [name] from [dbo].[Customers] where [email] like '%test%'

Show products whose name starts with ‘S’.
Select distinct [product_name] from [dbo].[Products] where [product_name] like 's%'

Retrieve all orders placed after ‘2025-01-01’.
Select [order_id] from [dbo].[Orders] where [order_date] > '2025-01-01'

List distinct cities from which customers have placed orders.
Select distinct A.[city] from [dbo].[Customers] A join [dbo].[Orders] B on A.customer_id=B.customer_id

Show the number of products that have a unit price over 500.
Select count(product_id) NOP from [dbo].[Products] where [unit_price] > 500

Display all orders that were made on a Monday.
Select [order_id],datename(weekday,[order_date]) Weekday from [dbo].[Orders]
where datename(weekday,[order_date]) in ('Monday')

Find products with unit prices that are multiples of 10.
Select [product_id],[unit_price] from Products
where [unit_price] % 10 =0

List customers whose names end with ‘n’.
Select [name] from [dbo].[Customers] where name like '%n'

Show all customers who live in cities starting with ‘M’.
Select [name] from [dbo].[Customers] where [city] like 'M%'

List all orders where the total amount is exactly 1000.
Select [order_id] from [dbo].[Orders] where [total_amount] =1000

 List all customers along with the total number of orders they have placed.

Show each product and the number of times it was ordered.
Select [product_id],Count([order_id]) NO from [dbo].[OrderItems]
Group by [product_id]

Find the average quantity of each product sold.
Select [product_id],Avg([quantity]) Avga from [dbo].[OrderItems]
Group by [product_id]

Show total sales per product.
SELECT [product_id], SUM([quantity] * [price]) AS total_sales 
FROM [dbo].[OrderItems] 
GROUP BY [product_id]

List each salesperson with their assigned customers and number of orders.
Select A.[salesperson_id],B.[customer_id],Count(B.[order_id]) NO from [dbo].[CustomerSalesperson] A join [dbo].[Orders] B on A.customer_id=B.customer_id
Group by A.[salesperson_id],B.[customer_id] 

Display orders along with the count of distinct products in each.
select [order_id],count(distinct [product_id]) NDP from [dbo].[OrderItems]
Group by [order_id]

Retrieve customers along with the total amount they’ve spent.
Select [customer_id],Sum([total_amount]) TA from [dbo].[Orders]
Group by [customer_id]

Find products that have been ordered in more than 2 different cities.
Select A.[product_id],Count(distinct C.[city]) NC from [dbo].[OrderItems] A join [dbo].[Orders] B on A.order_id=B.order_id
join [dbo].[Customers] C on B.customer_id=C.customer_id
Group by A.[product_id]
Having Count(distinct C.[city]) > 2

Show salespersons with total sales greater than 10,000.
Select A.[name],Sum(C.[total_amount]) TS from [dbo].[Salespersons] A join [dbo].[CustomerSalesperson] B on A.salesperson_id=B.salesperson_id Join [dbo].[Orders] C on B.customer_id=C.customer_id
Group by A.[name]

List customers who have ordered both ‘Keyboard’ and ‘Monitor’.
SELECT A.[customer_id]
FROM Orders A
JOIN [dbo].[OrderItems] B ON A.[order_id] = B.[order_id]
JOIN [dbo].[Products] C ON B.product_id = C.product_id
WHERE C.[product_name] IN ('Keyboard', 'Monitor')
GROUP BY A.[customer_id]
HAVING COUNT(DISTINCT C.[product_name]) = 2

Find customers who have never ordered any product under ₹100.
SELECT customer_id
FROM Orders A
JOIN [dbo].[OrderItems] B ON A.[order_id] = B.[order_id]
JOIN [dbo].[Products] C ON B.product_id = C.product_id
GROUP BY customer_id
HAVING MIN(C.unit_price) >= 100

Retrieve products that were only ordered in ‘Delhi’.
SELECT C.product_name
FROM Orders A
JOIN [dbo].[OrderItems] B ON A.[order_id] = B.[order_id]
JOIN [dbo].[Products] C ON B.product_id = C.product_id
JOIN [dbo].[Customers] D ON A.customer_id = D.customer_id
GROUP BY C.product_name
HAVING SUM(CASE WHEN D.city <> 'Delhi' THEN 1 ELSE 0 END) = 0

List customers who placed an order but are not assigned to any salesperson.
SELECT DISTINCT A.customer_id
FROM Customers A
JOIN Orders O ON O.customer_id = A.customer_id
LEFT JOIN CustomerSalesperson B ON A.customer_id = B.customer_id
WHERE B.salesperson_id IS NULL

Show products that have never been sold with quantity more than 5.
SELECT product_id
FROM OrderItems
GROUP BY product_id
HAVING MAX(quantity) <= 5

Show all customers who have placed exactly two orders.
SELECT customer_id
FROM [dbo].[Orders]
GROUP BY customer_id
HAVING COUNT(order_id) = 2

 Find customers who have ordered more than one product on the same date.
SELECT A.customer_id, A.order_date
FROM [dbo].[Orders] A
JOIN [dbo].[OrderItems] B ON A.order_id = B.order_id
GROUP BY A.customer_id, A.order_date
HAVING COUNT(DISTINCT B.product_id) > 1


Show products ordered only once.
SELECT product_id
FROM [dbo].[OrderItems]
GROUP BY product_id
HAVING COUNT(order_id) = 1

List cities where total sales exceed the city average.
WITH CityTotals AS (
    SELECT A.city, SUM(B.total_amount) AS total_sales
    FROM [dbo].[Customers] A
    JOIN [dbo].[Orders] B ON A.customer_id = B.customer_id
    GROUP BY A.city
),
AvgTotal AS (
    SELECT AVG(total_sales) AS avg_city_sales
    FROM CityTotals
)
SELECT C.city, C.total_sales
FROM CityTotals C, AvgTotal A
WHERE C.total_sales > A.avg_city_sales

 Find products that were never ordered.
Select B.[product_id] from [dbo].[OrderItems] A right join [dbo].[Products] B on A.[product_id]=B.[product_id]
where A.[product_id] is null

Retrieve customers who placed the largest order.
Select [customer_id],[order_id] from [dbo].[Orders]
where [total_amount]=(select max([total_amount]) from [Orders])

List products with price higher than average.
Select [product_name],[unit_price] from [dbo].[Products]
where [unit_price] > (select Avg([unit_price]) from [Products])

Display orders with total amount above the overall average.
Select [order_id],[total_amount] from [dbo].[Orders] where [total_amount] > (select avg([total_amount]) from Orders)

Retrieve customers whose total spending is above the average.
SELECT customer_id, SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id
HAVING SUM(total_amount) > (SELECT AVG(total_amount) FROM Orders)

Find products ordered by more than one customer.
select A.[product_id],Count(Distinct B.[customer_id]) NOC from [dbo].[OrderItems] A join [dbo].[Orders] B on A.order_id=B.order_id
Group by A.[product_id]
having Count(Distinct B.[customer_id]) > 1

Get customers who have only ordered once.
select [customer_id],count([order_id]) NO from Orders group by [customer_id]
having count([order_id])  = 1

List customers who placed orders in both 2024 and 2025.

select [customer_id] from orders where year([order_date])=2024
intersect
select [customer_id] from orders where year([order_date])=2025

Find the second highest order amount.
Select * from (
Select [order_id],[total_amount],Dense_Rank () over (Order by [total_amount] desc) Rank From Orders ) as A
where Rank = 2

Show orders placed by customers from 'Bangalore' only.
Select A.[name],A.[city] from [dbo].[Customers] A join [dbo].[Orders] B on A.customer_id=B.customer_id
where A.[city] in ('Bangalore')

List product names that appear in more than one order.
Select [product_name] from [dbo].[Products] where product_id in (
Select product_id  from [dbo].[OrderItems]
Group by product_id
having count(distinct [order_id]) > 1)

Retrieve orders placed on the same date as the highest order.
Select [order_id],[order_date] from [dbo].[Orders] where [order_date] = (select max(order_date) from Orders)

Show product details with price equal to the highest price.
Select [product_name],[unit_price] from [dbo].[Products] where unit_price = (select max(unit_price) from Products)

Get customer names who placed orders matching the lowest value order.
select name from Customers where customer_id in (
Select [customer_id] from Orders where total_amount = (select min(total_amount) from Orders))




 
