USE KB301_Bolshakov
Go

SELECT * FROM Навигация.Item /*Выбрать все записи из таблицы Item*/
Go

SELECT * FROM Навигация.Group_Item /*Выбрать все записи из таблицы Group_Item*/
Go

SELECT * FROM Навигация.Shop /*Выбрать все записи из таблицы Shop*/
Go

SELECT * FROM Навигация.Storage /*Выбрать все записи из таблицы Storage*/
Go

SELECT * FROM Навигация.Item
WHERE Unit = 'литр' /*Выбрать все записи из таблицы Item, где единицы измерения равны 'литр' */
Go

SELECT * FROM Навигация.Storage 
WHERE Market_street = 'Большакова' /*Выбрать все записи из таблицы Storage, где Street равен 'Больашкова'*/
Go

SELECT * FROM Навигация.Storage 
WHERE Market_street = 'Гоголя' AND Price > 100 /*Выбрать все записи из таблицы Storage, где Street равен 'Гоголя' и Price больше 100*/
Go

SELECT * FROM Навигация.Storage 
WHERE Market_street = 'Гоголя' AND Price > 100  
ORDER BY Price /*Выбрать все записи из таблицы Storage, где Street равен 'Гоголя' и Price больше 100 и отсортировать по цене*/
Go

SELECT * FROM Навигация.Storage 
WHERE Item_count BETWEEN 300 AND 1500 /*Выбрать все записи из таблицы Storage, где количество товаров лежат в промежутке от 300 до 1500*/
Go

UPDATE Навигация.Group_Item 
SET Group_name='Детские товары' 
WHERE Group_name = 'Товары для детей' /* Обновление поля 'Товары для детей' на 'Детские товары'*/
Go


SELECT * FROM Навигация.Storage JOIN Навигация.Item 
ON Навигация.Storage.Item_id = Навигация.Item.Item_id 
WHERE Навигация.Storage.Item_id = 1 AND Навигация.Storage.Item_count > 0/*Выбор магазинов где есть хлеб */
Go

SELECT Price as 'Цена', FORMAT(Item_date, 'D', 'ru-RU') as 'Дата' FROM Навигация.Storage /*Форматирование даты в понятном формате*/
Go


SELECT TOP 1 Market_street as 'Название улицы', Market_home as 'Номер дома', Price as 'Цена' 
FROM Навигация.Storage JOIN Навигация.Item
ON Навигация.Storage.Item_id = Навигация.Item.Item_id 
WHERE Навигация.Storage.Item_id = 3  
ORDER BY Price /*Выбор магазина, в котором молоко минимальной стоимости*/
Go


SELECT SUM(Item_count*Item_status) as 'Количество' FROM Навигация.Storage JOIN Навигация.Item
ON Навигация.Storage.Item_id = Навигация.Item.Item_id
WHERE Навигация.Storage.Item_id = 4 AND Item_count > 0 AND Item_date BETWEEN '2022-1-11 00:00:00' AND '2022-30-11 00:00:00' /*Разность между прибывшими на склад йогуртами и проданными*/
Go 

SELECT TOP 1 Market_street as 'Название улицы', Market_home as 'Номер дома', Price FROM Навигация.Storage JOIN Навигация.Item
ON Навигация.Storage.Item_id = Навигация.Item.Item_id 
WHERE Навигация.Storage.Item_id = 3  
ORDER BY Price /*Выбор магазина, в котором молоко минимальной стоимости 1 способ*/
Go

SELECT Навигация.Shop.Market_street as 'Название улицы', Навигация.Shop.Market_home as 'Номер дома' , Навигация.Storage.Price as 'Цена', Навигация.Shop.Shop_name as 'Навзание магазина'
FROM Навигация.Shop JOIN Навигация.Storage 
ON Навигация.Storage.Market_street = Навигация.Shop.Market_street AND Навигация.Storage.Market_home = Навигация.Shop.Market_home
WHERE Навигация.Storage.Price = 
(SELECT MIN(Price) FROM Навигация.Storage JOIN Навигация.Item
 ON Навигация.Storage.Item_id = Навигация.Item.Item_id
 WHERE Навигация.Item.Item_id = 3) /*Выбор магазина, в котором молоко минимальной стоимости 2 способ*/