USE KB301_Bolshakov
GO

--���������� � ������� ������
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

--����� � �������-������� ������� 
CREATE VIEW Cars
	AS
		SELECT PolicePost.PostId as '����� �����', PolicePost.CarNumber + PolicePost.CarRegion as '����� ������ � �������', Region.NameRegion as '�������� �������',
				PolicePost.CarInOut as '�����\�����', PolicePost.CarTime as '����� �����������' 
		FROM Task3.PolicePost
		JOIN Task3.VariactionRegion on PolicePost.CarRegion = VariactionRegion.VariactionRegion
		JOIN Task3.Region on VariactionRegion.MainRegion = Region.MainRegion
GO

--����� ������� �����
CREATE VIEW LocalCars
AS
	SELECT PolicePost.PostId as '����', PolicePost.CarNumber+PolicePost.CarRegion as '����� � ������', Region.NameRegion as '�������� �������',
			PolicePost.CarTime as '����� �����������', PolicePost.CarInOut '�����\�����' 
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

--����� ���������� �����
CREATE VIEW TransitCars
AS
	SELECT PolicePost.PostId as '����', PolicePost.CarNumber + PolicePost.CarRegion as '����� � ������', 
			Region.NameRegion as '�������� �������', PolicePost.CarTime as '����� �����������', 
			PolicePost.CarInOut '�����\�����' 
			FROM Task3.PolicePost
	JOIN(SELECT CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion as '����, ����� � ������', COUNT(PostId) as '���������� �������� ����� ����' 
			FROM Task3.PolicePost
	JOIN (SELECT CarNumber+CarRegion as CR 
			FROM Task3.PolicePost 
			GROUP BY CarNumber+CarRegion 
			HAVING COUNT(*) > 1) as T 
			on PolicePost.CarNumber+PolicePost.CarRegion = T.CR
	WHERE CarRegion != '02' and CarRegion != '102' and CarRegion != '702'
	GROUP BY CAST(PolicePost.PostId as varchar)+' '+PolicePost.CarNumber+' '+PolicePost.CarRegion
	HAVING COUNT(PostId) = 1) AS T 
	on T.[����, ����� � ������] = CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion
	JOIN Task3.VariactionRegion on PolicePost.CarRegion = VariactionRegion.VariactionRegion
	JOIN Task3.Region on VariactionRegion.MainRegion = Region.MainRegion
GO

--����� ��������� �����
CREATE VIEW NonLocalCars
AS
	SELECT PolicePost.PostId as '����', PolicePost.CarNumber + PolicePost.CarRegion as '����� � ������', 
			Region.NameRegion as '�������� �������',
			PolicePost.CarTime as '����� �����������', PolicePost.CarInOut as '�����\�����' 
			FROM Task3.PolicePost
	JOIN(SELECT CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion as '����, ����� � ������', 
			COUNT(PostId) as '���������� �������� ����� ����' 
			FROM Task3.PolicePost
	JOIN (SELECT CarNumber+CarRegion as CR 
			FROM Task3.PolicePost 
			GROUP BY CarNumber+CarRegion 
			HAVING COUNT(*) > 1) as T 
			on PolicePost.CarNumber+PolicePost.CarRegion = T.CR
	WHERE CarRegion != '02' and CarRegion != '102' and CarRegion != '702'
	GROUP BY CAST(PolicePost.PostId as varchar)+' '+PolicePost.CarNumber+' '+PolicePost.CarRegion
	HAVING COUNT(PostId) > 1) AS T 
	on T.[����, ����� � ������] = CAST(PolicePost.PostId as varchar)+ ' ' + PolicePost.CarNumber + ' ' + PolicePost.CarRegion
	JOIN Task3.VariactionRegion on PolicePost.CarRegion = VariactionRegion.VariactionRegion
	JOIN Task3.Region on VariactionRegion.MainRegion = Region.MainRegion
GO