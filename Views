Create a view listing each customer's name, email, total number of orders placed, and total amount spent.

Create View Customers_Vw as (Select A.[name],A.[email],Count(B.[order_id]) NO,Sum(B.[total_amount]) TA from Customers A join Orders B
on A.customer_id=B.customer_id
Group by A.[name],A.[email])

Create a view that displays order id, order date, customer name, product name, and quantity for each item in an order.

Create view Display_Vw as (Select B.order_id,B.order_date,A.name,D.product_name,C.Quantity from Customers A join Orders B on A.customer_id=B.customer_id
Join OrderItems c on B.order_id=C.order_id join Products D on C.product_id=D.product_id)

Create a view that shows each salesperson’s name together with the names and emails of all their assigned customers.

Create View SPName_Vw as (
Select  A.name as SPN,C.name as CN,C.email CM  from Salespersons A join CustomerSalesperson B on A.salesperson_id=B.salesperson_id join Customers C
on B.customer_id=C.customer_id )
Write a stored procedure to insert a new order for a given customer, taking customer_id, order_date, and total_amount as input.
