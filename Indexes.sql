Create an index on customer_id in Orders table.
Create Index CID on Orders (customer_id)

Drop an index on product_name.
Drop Index PN on Products

Create a view showing customer, order, and amount.
Create or alter view SGK as (select customer_id,order_date,total_amount from Orders)

Create an index on the city column in the Customers table to optimize queries that filter by city.
Create Index CIX on Customers (City)

Create an index on the order_date column in the Orders table to improve the performance of queries searching by order date.
Create Index ODI on Orders (Order_Date)

Create an index on the product_id column in the OrderItems table to speed up joins between OrderItems and Products.
Create Index PIX on OrderItems (product_id)
