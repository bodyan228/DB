USE KB301_Bolshakov
GO

--1
SELECT * FROM IDZ.Deliveries
ORDER BY INN DESC
GO

--2
SELECT Books.TitleBook AS '�������� �����', Books.Pages AS '���������� �������', PublishingHouse.Publish AS '������������', PublishingHouse.City AS '�����'
FROM IDZ.Books
JOIN IDZ.PublishingHouse ON Books.CodePublish = PublishingHouse.CodePublish
GO

--3
SELECT Books.TitleBook AS '�������� �����', PublishingHouse.Publish AS '������������' FROM IDZ.Books
JOIN IDZ.PublishingHouse ON PublishingHouse.CodePublish = Books.CodePublish
WHERE PublishingHouse.Publish != '������-����'
GO

--4
SELECT Books.TitleBook as '�������� �����', IDZ.Purchases.CodeDelivery AS '��� ����������' FROM IDZ.Books
JOIN IDZ.Purchases ON IDZ.Books.CodeBook = IDZ.Purchases.CodeBook
WHERE IDZ.Purchases.CodeDelivery = 3 OR IDZ.Purchases.CodeDelivery = 7 OR IDZ.Purchases.CodeDelivery = 9 OR IDZ.Purchases.CodeDelivery = 11
GO

--5
SELECT NameCompany FROM IDZ.Deliveries
WHERE NameCompany LIKE '%����'
GO

--6
SELECT Authors.NameAuthor AS '�����', IDZ.PublishingHouse.Publish AS '������������' FROM IDZ.Authors
JOIN IDZ.Books ON IDZ.Books.CodeAuthor = IDZ.Authors.CodeAuthor 
JOIN IDZ.PublishingHouse ON IDZ.PublishingHouse.CodePublish = IDZ.Books.CodePublish
WHERE IDZ.PublishingHouse.Publish = '����'
GO

--7
SELECT DATEDIFF(year, Birthday, '09.12.2022') as '���������� ���', NameAuthor FROM IDZ.Authors 
GO

--8
SELECT TOP 1 Purchases.DateOrder as '���� �������', Purchases.CodeDelivery as '��� ����������', 
		     Purchases.TypePurchase as '��� �������', 
			 Purchases.Cost*Purchases.Amount as '����� ����� ������', Purchases.CodePurchase as '��� �������',
			 Books.TitleBook as '�������� �����'
FROM IDZ.Purchases
JOIN IDZ.Books on IDZ.Books.CodeBook = IDZ.Purchases.CodeBook
ORDER BY Purchases.Cost*Purchases.Amount DESC
GO

--9
CREATE PROCEDURE Task9(
	@Year int
	)
AS
BEGIN
	SELECT DATEDIFF(year, Birthday, '09.12.2022') as '���������� ���', NameAuthor as '��������' FROM IDZ.Authors
	WHERE @Year > DATEDIFF(year, Birthday, '09.12.2022')
END
GO

EXEC Task9 100

--10
DECLARE @Title varchar(40)
DECLARE @Pages int

DECLARE Temp1 CURSOR FOR
SELECT TitleBook, Pages FROM IDZ.Books
OPEN Temp1
	FETCH NEXT FROM Temp1 INTO @Title, @Pages
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @Title as '�������� �����', @Pages as '���������� �������'
		FETCH NEXT FROM Temp1 INTO @Title, @Pages
	END
CLOSE Temp1

--11
SELECT TitleBook as '�������� �����', Pages as '���������� �������' FROM IDZ.Books
WHERE Pages = (SELECT MIN(Pages) FROM IDZ.Books)

--12
SELECT * FROM IDZ.Deliveries

UPDATE IDZ.Deliveries
SET Deliveries.Address = '��� ��������'
FROM IDZ.Deliveries
WHERE Deliveries.Address = ''

SELECT * FROM IDZ.Deliveries


--13
SELECT * FROM IDZ.Purchases

DELETE FROM IDZ.Purchases
WHERE Purchases.Amount = 0

SELECT * FROM IDZ.Purchases
GO


--14
CREATE TRIGGER DeleteDelevier
ON IDZ.Purchases
INSTEAD OF DELETE
AS 
	DECLARE @NumberDel int

	SELECT @NumberDel = CodeDelivery FROM IDZ.Purchases
	GROUP BY CodeDelivery
	HAVING COUNT(CodeDelivery) = 1
	DELETE FROM IDZ.Purchases 
	WHERE CodeDelivery = @NumberDel
GO

DELETE FROM IDZ.Purchases
GO

--15
CREATE PROCEDURE Itog
	(@Author varchar(50))
	AS 
	BEGIN
		SELECT Purchases.DateOrder as '���� ������', 
			Purchases.Cost*Purchases.Amount as '����� � ������', 
			Deliveries.NameCompany as '��������-���������', 
			Books.TitleBook as '�������� �����', 
			Authors.NameAuthor as '�����' 
		FROM IDZ.Authors
		JOIN IDZ.Books on Books.CodeAuthor = Authors.CodeAuthor
		JOIN IDZ.Purchases on Purchases.CodeBook = Books.CodeAuthor
		JOIN IDZ.Deliveries on Deliveries.CodeDelivery = Purchases.CodeDelivery
		WHERE NameAuthor = @Author
		ORDER BY Purchases.DateOrder

		SELECT Purchases.DateOrder as '���� ������',
			SUM(Purchases.Cost*Purchases.Amount) as '����� � ������ �� �����'
		FROM IDZ.Authors
		JOIN IDZ.Books on Books.CodeAuthor = Authors.CodeAuthor
		JOIN IDZ.Purchases on Purchases.CodeBook = Books.CodeAuthor
		JOIN IDZ.Deliveries on Deliveries.CodeDelivery = Purchases.CodeDelivery
		WHERE NameAuthor = @Author
		GROUP BY DateOrder

		SELECT ISNULL(SUM([����� � ������ �� �����]), 0) as '����� �����'
		FROM(SELECT Purchases.DateOrder as '���� ������',
			   SUM(Purchases.Cost*Purchases.Amount) as '����� � ������ �� �����'
			 FROM IDZ.Authors
			 JOIN IDZ.Books on Books.CodeAuthor = Authors.CodeAuthor
			 JOIN IDZ.Purchases on Purchases.CodeBook = Books.CodeAuthor
			 JOIN IDZ.Deliveries on Deliveries.CodeDelivery = Purchases.CodeDelivery
			 WHERE NameAuthor = @Author
			 GROUP BY DateOrder) as T
	END
GO

DROP PROCEDURE Itog
EXEC Itog '������� �.�.'
EXEC Itog 'authorName6'
EXEC Itog '������� ��� ���������'
EXEC Itog '������ �����'
