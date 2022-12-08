USE master
GO

IF exists (
	SELECT NAME
	FROM sys.databases
	WHERE NAME = N'KB301_Bolshakov'
)
ALTER DATABASE [KB301_Bolshakov] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

IF EXISTS (
	SELECT name 
		FROM sys.databases
		WHERE name = N'KB301_Bolshakov'
)
DROP DATABASE [KB301_Bolshakov]

CREATE DATABASE [KB301_Bolshakov]
GO

USE [KB301_Bolshakov]
GO

IF EXISTS(
	SELECT * FROM sys.schemas
	WHERE name = N'IDZ'
) 
DROP SCHEMA IDZ
GO

CREATE SCHEMA IDZ
GO

CREATE TABLE IDZ.Authors(
	CodeAuthor int NOT NULL,
	NameAuthor varchar(50) NOT NULL,
	Birthday date NOT NULL,
	PRIMARY KEY(CodeAuthor)
)
GO

CREATE TABLE IDZ.PublishingHouse(
	CodePublish int NOT NULL,
	Publish varchar(50) NOT NULL,
	City varchar(20) NOT NULL,
	PRIMARY KEY(CodePublish)
)
GO

CREATE TABLE IDZ.Deliveries(
	CodeDelivery int NOT NULL,
	NameDelivery varchar(50) NOT NULL,
	NameCompany varchar(50) NOT NULL,
	Address varchar(100) NOT NULL,
	Phone numeric NOT NULL,
	INN varchar(20) NOT NULL,
	PRIMARY KEY(CodeDelivery)
)
GO

CREATE TABLE IDZ.Books(
	CodeBook int NOT NULL,
	TitleBook varchar(40) NOT NULL,
	CodeAuthor int NOT NULL,
	Pages int NOT NULL,
	CodePublish int NOT NULL,
	PRIMARY KEY(CodeBook),
	FOREIGN KEY(CodeAuthor) REFERENCES IDZ.Authors(CodeAuthor),
	FOREIGN KEY(CodePublish) REFERENCES IDZ.PublishingHouse(CodePublish)
)
GO

CREATE TABLE IDZ.Purchases(
	CodeBook int NOT NULL,
	DateOrder date NOT NULL,
	CodeDelivery int NOT NULL,
	TypePurchase bit NOT NULL,
	Cost money NOT NULL,
	Amount int NOT NULL,
	CodePurchase int NOT NULL,
	FOREIGN KEY(CodeBook) REFERENCES IDZ.Books(CodeBook),
	FOREIGN KEY(CodeDelivery) REFERENCES IDZ.Deliveries(CodeDelivery)
)
GO

