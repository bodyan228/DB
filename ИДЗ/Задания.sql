USE KB301_Bolshakov
GO

--1
SELECT * FROM IDZ.Deliveries
ORDER BY INN DESC
GO

--2
SELECT Books.TitleBook AS 'Название книги', Books.Pages AS 'Количество страниц', PublishingHouse.Publish AS 'Издательство', PublishingHouse.City AS 'Город'
FROM IDZ.Books
JOIN IDZ.PublishingHouse ON Books.CodePublish = PublishingHouse.CodePublish
GO

--3
SELECT Books.TitleBook AS 'Название книги', PublishingHouse.Publish AS 'Издательство' FROM IDZ.Books
JOIN IDZ.PublishingHouse ON PublishingHouse.CodePublish = Books.CodePublish
WHERE PublishingHouse.Publish != '«Питер-Софт»'
GO

--4
SELECT Books.TitleBook as 'Название книги', IDZ.Purchases.CodeDelivery AS 'Код поставщика' FROM IDZ.Books
JOIN IDZ.Purchases ON IDZ.Books.CodeBook = IDZ.Purchases.CodeBook
WHERE IDZ.Purchases.CodeDelivery = 3 OR IDZ.Purchases.CodeDelivery = 7 OR IDZ.Purchases.CodeDelivery = 9 OR IDZ.Purchases.CodeDelivery = 11
GO

--5
SELECT NameCompany FROM IDZ.Deliveries
WHERE NameCompany LIKE '%ский'
GO

--6
SELECT Authors.NameAuthor AS 'Автор', IDZ.PublishingHouse.Publish AS 'Издательство' FROM IDZ.Authors
JOIN IDZ.Books ON IDZ.Books.CodeAuthor = IDZ.Authors.CodeAuthor 
JOIN IDZ.PublishingHouse ON IDZ.PublishingHouse.CodePublish = IDZ.Books.CodePublish
WHERE IDZ.PublishingHouse.Publish = '«Мир»'
GO

--7
SELECT DATEDIFF(year, Birthday, '09.12.2022') as 'Количество лет', NameAuthor FROM IDZ.Authors 
GO

--8
SELECT TOP 1 Purchases.DateOrder as 'Дата закупки', Purchases.CodeDelivery as 'Код поставщика', 
		     Purchases.TypePurchase as 'Тип закупки', 
			 Purchases.Cost*Purchases.Amount as 'Общая сумма затрат', Purchases.CodePurchase as 'Код закупки',
			 Books.TitleBook as 'Название книги'
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
	SELECT DATEDIFF(year, Birthday, '09.12.2022') as 'Количество лет', NameAuthor as 'Писатель' FROM IDZ.Authors
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
		SELECT @Title as 'Название книги', @Pages as 'Количество страниц'
		FETCH NEXT FROM Temp1 INTO @Title, @Pages
	END
CLOSE Temp1

--11
SELECT TitleBook as 'Название книги', Pages as 'Количество страниц' FROM IDZ.Books
WHERE Pages = (SELECT MIN(Pages) FROM IDZ.Books)

--12
SELECT * FROM IDZ.Deliveries

UPDATE IDZ.Deliveries
SET Deliveries.Address = 'Нет сведений'
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
		SELECT Purchases.DateOrder as 'Дата заказа', 
			Purchases.Cost*Purchases.Amount as 'Доход с продаж', 
			Deliveries.NameCompany as 'Компания-поставщик', 
			Books.TitleBook as 'Название книги', 
			Authors.NameAuthor as 'Автор' 
		FROM IDZ.Authors
		JOIN IDZ.Books on Books.CodeAuthor = Authors.CodeAuthor
		JOIN IDZ.Purchases on Purchases.CodeBook = Books.CodeAuthor
		JOIN IDZ.Deliveries on Deliveries.CodeDelivery = Purchases.CodeDelivery
		WHERE NameAuthor = @Author
		ORDER BY Purchases.DateOrder

		SELECT Purchases.DateOrder as 'Дата заказа',
			SUM(Purchases.Cost*Purchases.Amount) as 'Доход с продаж за месяц'
		FROM IDZ.Authors
		JOIN IDZ.Books on Books.CodeAuthor = Authors.CodeAuthor
		JOIN IDZ.Purchases on Purchases.CodeBook = Books.CodeAuthor
		JOIN IDZ.Deliveries on Deliveries.CodeDelivery = Purchases.CodeDelivery
		WHERE NameAuthor = @Author
		GROUP BY DateOrder

		SELECT ISNULL(SUM([Доход с продаж за месяц]), 0) as 'Общий доход'
		FROM(SELECT Purchases.DateOrder as 'Дата заказа',
			   SUM(Purchases.Cost*Purchases.Amount) as 'Доход с продаж за месяц'
			 FROM IDZ.Authors
			 JOIN IDZ.Books on Books.CodeAuthor = Authors.CodeAuthor
			 JOIN IDZ.Purchases on Purchases.CodeBook = Books.CodeAuthor
			 JOIN IDZ.Deliveries on Deliveries.CodeDelivery = Purchases.CodeDelivery
			 WHERE NameAuthor = @Author
			 GROUP BY DateOrder) as T
	END
GO

DROP PROCEDURE Itog
EXEC Itog 'Толстой Л.Н.'
EXEC Itog 'authorName6'
EXEC Itog 'Кассиль Лев Абрамович'
EXEC Itog 'Акунин Борис'
