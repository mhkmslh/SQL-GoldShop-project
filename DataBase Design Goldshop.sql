--products
--customers
--invoices
--invoiceitems
--goldpricehistory
--adminusers
----------------------------
---1---create database
-------------- برای حذف دیتابیس تکراری
---ALTER DATABASE adminusers SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--DROP DATABASE adminusers;
--SELECT * FROM sys.tables WHERE name = 'adminusers';
---DROP TABLE adminusers;
-------------------- ساختن دیتابیس
--CREATE DATABASE GoldShop;
--GO

--USE GoldShop;
--GO
----------------------------
----------------------- نشون دادن تمام دیتابیس های موجود
--SELECT name FROM sys.databases;
-------------SINGLE USER DATABASE		
---ALTER DATABASE GoldShop SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
------------- حذف کردن دیتابیس
---DROP DATABASE ;

------------------------------------ یه شرط اینکه اون جدول وجود نداره بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'adminusers')
--,'products','customers','invoices','invoiceitems','goldpricehistory','InventoryMovements')
BEGIN
create table adminusers 
(admin_ID int identity(1,1) primary key, username varchar(20) not null unique, fullname varchar(30), roll varchar(20) not null, created_at datetime default getdate());
create table products 
(product_ID int identity(1,1) primary key, sku varchar(10) unique, title varchar(20) not null, category varchar(50), weight decimal(8,3) not null, wage_toamn decimal (12,2) default 0, markup_toman decimal (12,2) default 0, created_at datetime default getdate(), gold_purity int check  (gold_purity in (18,21,22,24)), active bit default 1);
create table customers 
(customer_ID int identity(1,1) primary key, name varchar(20) not null, phone varchar(10), email varchar(20), birthday date, created_at datetime default getdate());
create table invoices 
(invoice_ID int identity(1,1) primary key, customer_ID int null, admin_ID int null, type varchar(10) check (type in ('buy','sell')), tota_price decimal(14,2) default 0, notes nvarchar(max), created_at datetime default getdate(), FOREIGN KEY (customer_ID) REFERENCES Customers(customer_ID), FOREIGN KEY (admin_ID) REFERENCES adminusers(admin_ID));
create table invoiceitems 
(item_ID int identity(1,1) primary key, invoice_ID int not null, product_ID int null, unit_price decimal(14,2) not null, quantity int default 1, FOREIGN KEY (invoice_ID) REFERENCES Invoices(invoice_ID) ON DELETE CASCADE, FOREIGN KEY (product_ID) REFERENCES Products(product_ID));
create table goldpricehistory 
(ID int identity(1,1) primary key, price_per_gram decimal(12,2) not null, currency varchar(5) default 'IRR', created_at datetime default getdate());
create table InventoryMovements 
(movement_id INT IDENTITY(1,1) PRIMARY KEY, product_id INT NOT NULL, change_qty INT NOT NULL, reason VARCHAR(120), created_at DATETIME DEFAULT GETDATE(), FOREIGN KEY (product_id) REFERENCES Products(product_id));
END

----------------- برای خطا دیتابیس مشابه
---SELECT name 
---FROM sys.databases 
---WHERE name = 'GoldShop';
USE GoldShop; 
GO
SELECT * FROM INFORMATION_SCHEMA.TABLES;


