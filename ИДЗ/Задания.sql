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
SELECT Books FROM IDZ.Books
