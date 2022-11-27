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
GO

CREATE DATABASE [KB301_Bolshakov]
GO

USE [KB301_Bolshakov]
GO

IF EXISTS(
	SELECT * FROM sys.schemas
	WHERE name = N'Bonus'
) 
DROP SCHEMA Bonus
GO

CREATE SCHEMA Bonus
GO

CREATE TABLE [KB301_Bolshakov].Bonus.CrossCurrencyTable(
	FromValue VARCHAR(3),
	ToValue VARCHAR(3),
	Price MONEY
)
GO