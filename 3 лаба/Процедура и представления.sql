USE KB301_Bolshakov
GO

--Добавление в таблицу машины
CREATE PROCEDURE InsertCar
	(@PostId tinyint,
	 @CarNumber varchar (6),
	 @CarRegion varchar (3),
	 @CarInOut varchar (3),
	 @CarTime time(0))
	 AS
		BEGIN
			INSERT INTO Task3.PolicePost
			(PostId, CarNumber, CarRegion, CarInOut, CarTime)
			VALUES
			(@PostId, @CarNumber, @CarRegion, @CarInOut, @CarTime)
		END
GO

--Вывод в русской-язычной таблице 
CREATE VIEW Cars
	AS
		SELECT PolicePost.PostId as 'Номер поста', PolicePost.CarNumber + PolicePost.CarRegion as 'Номер машины и региона', Region.NameRegion as 'Название региона',
				PolicePost.CarInOut as 'Въезд\Выезд', PolicePost.CarTime as 'Время регистрации' 
		FROM Task3.PolicePost
		JOIN Task3.VariactionRegion on PolicePost.CarRegion = VariactionRegion.VariactionRegion
		JOIN Task3.Region on VariactionRegion.MainRegion = Region.MainRegion
GO

--Вывод местных машин
CREATE VIEW LocalCars
AS
	SELECT PolicePost.PostId as 'Пост', PolicePost.CarNumber+PolicePost.CarRegion as 'Номер и регион', Region.NameRegion as 'Название региона',
			PolicePost.CarTime as 'Время регистрации', PolicePost.CarInOut 'Въезд\Выезд' 
	FROM Task3.PolicePost
	JOIN (SELECT CarNumber+CarRegion as CR 
			FROM Task3.PolicePost 
			GROUP BY CarNumber+CarRegion 
			HAVING COUNT(*) > 1) as T 
			on PolicePost.CarNumber+PolicePost.CarRegion = T.CR
	JOIN Task3.VariactionRegion on PolicePost.CarRegion = VariactionRegion.VariactionRegion
	JOIN Task3.Region on VariactionRegion.MainRegion = Region.MainRegion
	WHERE PolicePost.CarRegion = '02' or PolicePost.CarRegion = '102' or PolicePost.CarRegion = '702'
GO

--Вывод транзитных машин
CREATE VIEW TransitCars
AS
	SELECT PolicePost.PostId as 'Пост', PolicePost.CarNumber + PolicePost.CarRegion as 'Номер и регион', 
			Region.NameRegion as 'Название региона', PolicePost.CarTime as 'Время регистрации', 
			PolicePost.CarInOut 'Въезд\Выезд' 
			FROM Task3.PolicePost
	JOIN(SELECT CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion as 'Пост, номер и регион', COUNT(PostId) as 'Количество проездов через пост' 
			FROM Task3.PolicePost
	JOIN (SELECT CarNumber+CarRegion as CR 
			FROM Task3.PolicePost 
			GROUP BY CarNumber+CarRegion 
			HAVING COUNT(*) > 1) as T 
			on PolicePost.CarNumber+PolicePost.CarRegion = T.CR
	WHERE CarRegion != '02' and CarRegion != '102' and CarRegion != '702'
	GROUP BY CAST(PolicePost.PostId as varchar)+' '+PolicePost.CarNumber+' '+PolicePost.CarRegion
	HAVING COUNT(PostId) = 1) AS T 
	on T.[Пост, номер и регион] = CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion
	JOIN Task3.VariactionRegion on PolicePost.CarRegion = VariactionRegion.VariactionRegion
	JOIN Task3.Region on VariactionRegion.MainRegion = Region.MainRegion
GO

--Вывод неместных машин
CREATE VIEW NonLocalCars
AS
	SELECT PolicePost.PostId as 'Пост', PolicePost.CarNumber + PolicePost.CarRegion as 'Номер и Регион', 
			Region.NameRegion as 'Навзание региона',
			PolicePost.CarTime as 'Время регистрации', PolicePost.CarInOut as 'Въезд\Выезд' 
			FROM Task3.PolicePost
	JOIN(SELECT CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion as 'Пост, номер и регион', 
			COUNT(PostId) as 'Количество проездов через пост' 
			FROM Task3.PolicePost
	JOIN (SELECT CarNumber+CarRegion as CR 
			FROM Task3.PolicePost 
			GROUP BY CarNumber+CarRegion 
			HAVING COUNT(*) > 1) as T 
			on PolicePost.CarNumber+PolicePost.CarRegion = T.CR
	WHERE CarRegion != '02' and CarRegion != '102' and CarRegion != '702'
	GROUP BY CAST(PolicePost.PostId as varchar)+' '+PolicePost.CarNumber+' '+PolicePost.CarRegion
	HAVING COUNT(PostId) > 1) AS T 
	on T.[Пост, номер и регион] = CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion
	JOIN Task3.VariactionRegion on PolicePost.CarRegion = VariactionRegion.VariactionRegion
	JOIN Task3.Region on VariactionRegion.MainRegion = Region.MainRegion
GO