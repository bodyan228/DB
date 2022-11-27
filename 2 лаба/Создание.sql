USE master
GO

IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'KB301_Bolshakov'
)
ALTER DATABASE [KB301_Bolshakov] set single_user with rollback immediate
GO

IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'KB301_Bolshakov'
)
DROP DATABASE [KB301_Bolshakov]
GO

CREATE DATABASE [KB301_Bolshakov]
GO

USE KB301_Bolshakov
GO

CREATE SCHEMA Debet
GO

CREATE TABLE Debet.Card_Table(
	Value_name nvarchar(10) NULL,
	Balance money NULL
	CONSTRAINT Positive_balance CHECK (Balance >= 0)
)
GO


CREATE TABLE Debet.Buy(
	From_value nvarchar(10) NOT NULL,
	To_value nvarchar(10) NOT NULL,
	Price float NOT NULL,
)
GO

CREATE TABLE Debet.Sell(
	From_value nvarchar(10) NOT NULL,
	To_value nvarchar(10) NOT NULL,
	Price float NOT NULL,
)
GO



