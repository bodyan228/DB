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

CREATE SCHEMA Task3
GO


CREATE TABLE Task3.CarNumber(
	CNNNCC nvarchar(6) NOT NULL,
	Region nvarchar(3) NOT NULL,
	CHECK (CNNNCC LIKE '_[0-9][0-9][0-9]__' and 
		   CNNNCC NOT LIKE '_000__' and
		   CNNNCC LIKE '[юбейлмнпярсу]___[юбейлмнпярсу][юбейлмнпярсу]' and 
		   (Region LIKE '[0-9][1-9]' or Region LIKE '[1][0-9][0-9]' or Region LIKE '[2][0-9][0-9]' or Region LIKE '[7][0-9][0-9]'))
)
GO


CREATE TABLE Task3.Region(
	MainRegion nvarchar(3) NOT NULL,
	NameRegion nvarchar(20) NOT NULL,
	PRIMARY KEY (MainRegion)
)


CREATE TABLE Task3.VariactionRegion(
	MainRegion nvarchar(3) NOT NULL,
	VariactionRegion nvarchar(3) NOT NULL
)


ALTER TABLE Task3.VariactionRegion ADD
	CONSTRAINT FK_Region FOREIGN KEY (MainRegion)
	REFERENCES Task3.Region(MainRegion)
	ON UPDATE CASCADE 
GO


CREATE TABLE Task3.PolicePost(
	CarNumber nvarchar(6) NOT NULL,
	CarRegion nvarchar(3) NOT NULL,
	CarTime time(0)  NOT NULL,
	CarInOut nvarchar(3) NOT NULL,
	PostId tinyint NOT NULL,
)