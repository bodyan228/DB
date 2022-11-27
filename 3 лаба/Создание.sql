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

CREATE TABLE Task3.Post(
	PostId tinyint NOT NULL
	PRIMARY KEY (PostId)
)
GO


CREATE TABLE Task3.CarType(
	CarType nvarchar(20) NOT NULL
	PRIMARY KEY (CarType) 
)
GO


CREATE TABLE Task3.CarNumber(
	C nvarchar(1) NOT NULL,
	NNN nvarchar(3) NOT NULL,
	CC nvarchar(2) NOT NULL,
	Region nvarchar(3) NOT NULL,
	CHECK (C LIKE '[юбейлмнпярсу]' and
		   NNN LIKE '[0-9][0-9][0-9]' and
		   NNN NOT LIKE '000' and
		   CC LIKE '[юбейлмнпярсу][юбейлмнпярсу]' and 
		   (Region LIKE '[0-9][1-9]' or Region LIKE '[127][0-9][0-9]'))
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
	CarNumber nvarchar(9) NOT NULL,
	CarTime time  NOT NULL,
	CarInOut nvarchar(3) NOT NULL,
	CarType nvarchar(20) NOT NULL,
	PostId tinyint NOT NULL,
)

ALTER TABLE Task3.PolicePost ADD
	CONSTRAINT FK_Post FOREIGN KEY (PostId)
	REFERENCES Task3.Post(PostId)
	ON UPDATE CASCADE 
GO

ALTER TABLE Task3.PolicePost ADD
	CONSTRAINT FK_CarType FOREIGN KEY (CarType)
	REFERENCES Task3.CarType(CarType)
	ON UPDATE CASCADE 
GO
