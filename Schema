Create Database CustomerOrdersDB
Use CustomerOrdersDB


Create table Customers (
customer_id int,
name varchar(100),
email varchar(100),
city varchar(100))

alter table Customers
alter column customer_id int not null

alter table Customers
add constraint CI1 primary key (customer_id)


------------------------------------------------------------------------------------------------------


Create table Orders (
order_id int not null,
customer_id int,
order_date date,
total_amount decimal(15,2))

alter table Orders
add constraint O1 primary key (order_id)  

alter table Orders
add constraint CIF1 foreign key (customer_id) references Customers (customer_id)


------------------------------------------------------------------------------------------------------

create table Products (
product_id int not null,
product_name varchar(100),
unit_price decimal(15,2))

alter table Products
add constraint PI1 primary key (product_id)


------------------------------------------------------------------------------------------------------


Create table OrderItems (
order_item_id int not null,
order_id int,
product_id int,
quantity int,
price int)

alter table OrderItems
add constraint OIID1 primary key (order_item_id)

alter table OrderItems
add  constraint FKO1 foreign key (order_id) references Orders (order_id)

alter table OrderItems
add  constraint FKP1 foreign key (product_id) references Products (product_id)

------------------------------------------------------------------------------------------------------
Salespersons


create table Salespersons (
salesperson_id int not null,
name varchar (100),
city varchar(100),
commission varchar(100))

alter table Salespersons
add constraint SID primary key (salesperson_id)


------------------------------------------------------------------------------------------------------

create table CustomerSalesperson (
customer_id int,
salesperson_id int)

alter table CustomerSalesperson
add constraint CIF2 foreign key (customer_id) references Customers (customer_id)

alter table CustomerSalesperson
add constraint CIS1 foreign key (salesperson_id) references Salespersons (salesperson_id)

