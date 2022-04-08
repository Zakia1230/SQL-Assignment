--  Assigment of sql

--1. Desgin the above database with following table by applying Primary key and Foreign key
CREATE TABLE [customer] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [firstName] nvarchar(40),
  [lastName] nvarchar(40),
  [city] nvarchar(40),
  [country] nvarchar(40),
  [phone] nvarchar(20)
)
GO

CREATE TABLE [product] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [productName] nvarchar(50),
  [unitePrice] decimal(12,2),
  [package] nvarchar(30),
  [isDiscounted] boolean DEFAULT (true)
)
GO

CREATE TABLE [order] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [orderDate] datetime,
  [orderNo] nvarchar(10),
  [customerId] int,
  [totalAmount] decimal(12,2)
)
GO

CREATE TABLE [orderItem] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [orderId] int,
  [productId] int,
  [unitePrice] decimal(12,2),
  [quantity] int
)
GO

ALTER TABLE [order] ADD FOREIGN KEY ([customerId]) REFERENCES [customer] ([id])
GO

ALTER TABLE [orderItem] ADD FOREIGN KEY ([orderId]) REFERENCES [order] ([id])
GO

ALTER TABLE [orderItem] ADD FOREIGN KEY ([productId]) REFERENCES [product] ([id])
GO

CREATE INDEX [customer_index_0] ON [customer] ("firstName", "lastName")
GO

CREATE INDEX [product_index_1] ON [product] ("productName")
GO

CREATE INDEX [product_index_2] ON [product] ("id")
GO

CREATE INDEX [order_index_3] ON [order] ("customerId")
GO

CREATE INDEX [order_index_4] ON [order] ("orderDate")
GO

CREATE INDEX [orderItem_index_5] ON [orderItem] ("orderId")
GO

CREATE INDEX [orderItem_index_6] ON [orderItem] ("productId")
GO

-- 2.Insert Records in all tables
-- insert on customer table
INSERT INTO `customer` (`id`, `firstName`, `lastName`, `city`, `country`, `phone`) VALUES ('1', 'Demo', 'kumar', 'Jharkhand', 'India', '9889125690');
-- inset into product table
INSERT INTO `product` (`id`, `productName`, `unitePrice`, `package`, `isDiscounted`) VALUES ('1', 'Pen', '15', 'no package', '1');
--  insert into order table
INSERT INTO `order` (`id`, `orderDate`, `orderNo`, `customerId`, `totalAmount`) VALUES ('1', '2022-04-04 08:16:42', '091245', '1', '180');
-- insert into order item table
INSERT INTO `orderItem` (`id`, `orderId`, `productId`, `unitePrice`, `quantity`) VALUES ('1', '1', '1', '10.0', '17');

-- 3.In Customer table FirstName Attribute should not accept null value
ALTER TABLE `customer` CHANGE `firstName` `firstName` NVARCHAR(40) NOT NULL;

-- 4.In Order table OrderDate should not accept null value
ALTER TABLE `order` CHANGE `orderDate` `orderDate` DATETIME NOT NULL

-- 5.Display all customer details
select * from customer

-- 6.write a query to display Country whose name starts with A or I
SELECT * FROM `customer` WHERE country like 'a%' or country like 'i%';

-- 7 .write a query to display whose name of customer whose third character is i
SELECT CONCAT(firstName, lastName) as customerName FROM `customer` WHERE CONCAT(firstName, lastName) like '__i%'


------------------- Second Assigment -----------------
-- 1. Display the details from Customer table who is from country Germany
select * from customer where country = 'Germany';
-- 2. Display the fullname of the employee
SELECT CONCAT(firstName, lastName) as customerName FROM `customer`;
-- 3. Display the customer details who has Fax number
ALTER TABLE `customer` ADD `faxNumber` NVARCHAR(20);
SELECT * FROM `customer` WHERE faxNumber is not null;
-- 4. display the customer details whoes name holds second letter as U
SELECT CONCAT(firstName, lastName) as customerName FROM `customer` WHERE CONCAT(firstName, lastName) like '_U%'
-- 5. select order Details where unit price is greater than 10 and less than 20
SELECT orderNo, orderDate, totalAmount, orderItem.unitePrice FROM `order` left join orderItem on orderItem.orderId = order.id WHERE orderItem.unitePrice > 10 AND orderItem.unitePrice <20
-- 6. Display order details which contains shipping date and arrange the order by date
SELECT * FROM `order` WHERE orderDate is not null order by orderDate;
-- 7. Print the orders shipped by ship name 'La corne d'abondance' between 2 dates(Choose dates of your choice)
ALTER TABLE `order` ADD `shipName` NVARCHAR(50) NULL AFTER `customerId`;
SELECT * FROM `order` WHERE `shipName` = 'La corne dabondance' and orderDate > '2022-03-07 00:00:00' and orderDate <= '2022-05-07 00:00:00';
-- 8. Print the products supplied by 'Exotic Liquids'
-- 'shipped by' is not mention in given schema
-- 9. print the average quantity ordered for every product
SELECT AVG(quantity) as avgQuantity FROM `orderItem` GROUP by productId;
-- 9. print the average quantity ordered for every product
SELECT product.productName, AVG(quantity) as avgQuantity FROM `orderItem` left join product on product.id = orderItem.productId GROUP by productId;
-- 10. Print all the Shipping company name and the ship names if they are operational
-- Shipping company name and the ship names are not mention in given schema
-- 11. Print all Employees with Manager Name
-- Manager Name is not mention in given schema
-- 12. Print the bill for a given order id .bill should contain Productname, Categoryname,price after discount
SELECT orderNo, orderDate, totalAmount, orderItem.unitePrice, product.productName, product.unitePrice, product.package FROM `order` left join orderItem on orderItem.orderId = order.id LEFT JOIN product on product.id = orderItem.productId WHERE order.orderNo = '091245';
-- 13. Print the Total price of orders which have the products supplied by 'Exotic Liquids' if the price is > 50 and also print it by Shipping company's Name
-- Shipping company name and the ship names are not mention in given schema
