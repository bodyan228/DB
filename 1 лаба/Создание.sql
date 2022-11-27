USE master
Go

IF exists (
	SELECT NAME
	FROM sys.databases
	WHERE NAME = N'KB301_Bolshakov'
)
ALTER DATABASE [KB301_Bolshakov] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
Go


IF EXISTS (
	SELECT name 
		FROM sys.databases
		WHERE name = N'KB301_Bolshakov'
)
DROP DATABASE [KB301_Bolshakov]

CREATE DATABASE [KB301_Bolshakov]
Go

USE [KB301_Bolshakov]
Go

IF EXISTS(
	SELECT * FROM sys.schemas
	WHERE name = N'Навигация'
) 
DROP SCHEMA Навигация
Go

CREATE SCHEMA Навигация
Go

IF OBJECT_ID('[KB301_Bolshakov].Навигация.Shop', 'U') IS NOT NULL
	DROP TABLE [KB301_Bolshakov].Навигация.Shop
Go


CREATE TABLE [KB301_Bolshakov].Навигация.Shop(
	Market_street nvarchar(20) NOT NULL,
	Market_home nvarchar(10) NOT NULL,
	Shop_name nvarchar(20) NOT NULL,
	CONSTRAINT PK_shop PRIMARY KEY (Market_street, Market_home)
)
Go


CREATE TABLE [KB301_Bolshakov].Навигация.Storage(
	Item_status smallint NOT NULL,
	Item_count int NOT NULL,
	Price money NOT NULL,
	Item_date smalldatetime NOT NULL,
	Item_id tinyint NOT NULL,
	Market_street nvarchar(20) NOT NULL,
	Market_home nvarchar(10) NOT NULL,
)
Go


CREATE TABLE [KB301_Bolshakov].Навигация.Item(
	Item_name nvarchar(20) NOT NULL,
	Unit nvarchar(4) NOT NULL,
	Item_id tinyint IDENTITY(1,1) NOT NULL,
	Group_id tinyint NOT NULL,
	CONSTRAINT PK_item PRIMARY KEY (Item_id)
)
Go


CREATE TABLE [KB301_Bolshakov].Навигация.Group_Item(
	Group_name nvarchar(30) NOT NULL,
	Group_id tinyint IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_Id PRIMARY KEY (Group_id)
)
Go


ALTER TABLE [KB301_Bolshakov].Навигация.Storage ADD 
	CONSTRAINT FK_Shop_Id FOREIGN KEY (Market_street, Market_home) 
	REFERENCES [KB301_Bolshakov].Навигация.Shop(Market_street, Market_home)
	ON UPDATE CASCADE 
Go

ALTER TABLE [KB301_Bolshakov].Навигация.Storage ADD 
	CONSTRAINT FK_Item_Id FOREIGN KEY (Item_id) 
	REFERENCES [KB301_Bolshakov].Навигация.Item(Item_id)
	ON UPDATE CASCADE 
Go

ALTER TABLE [KB301_Bolshakov].Навигация.Item ADD 
	CONSTRAINT FK_Item FOREIGN KEY (Group_id) 
	REFERENCES [KB301_Bolshakov].Навигация.Group_Item(Group_id)
	ON UPDATE CASCADE 
Go
