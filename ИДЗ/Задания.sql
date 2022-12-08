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
SELECT Books FROM IDZ.Books
