USE KB301_Bolshakov
GO

--Проверка на соответствие времени
EXEC InsertCar 2, 'в556тм', '02', 'Out', '10:06:00'
EXEC InsertCar 2, 'в556тм', '02', 'In', '10:02:00'

--Проверка на статус автомобиля
EXEC InsertCar 2, 'а777мс', '02', 'In', '10:02:00'
EXEC InsertCar 2, 'а777мс', '02', 'In', '10:10:00'


--Проверка на соответствие региону
EXEC InsertCar 2, 'а557тм', '000', 'Out', '10:06:00'
EXEC InsertCar 2, 'а557тм', '300', 'Out', '10:06:00'
EXEC InsertCar 2, 'а557тм', '500', 'Out', '10:06:00'
EXEC InsertCar 2, 'а557тм', '900', 'Out', '10:06:00'
EXEC InsertCar 2, 'а557тм', '001', 'Out', '10:06:00'

--Проверка на соответствие номеру
EXEC InsertCar 2, 'а557ть', '66', 'Out', '10:06:00'
EXEC InsertCar 2, 'а557лн', '66', 'Out', '10:06:00'
EXEC InsertCar 2, 'а000тк', '66', 'Out', '10:06:00'
EXEC InsertCar 2, 'а557т', '66', 'Out', '10:06:00'

--Для добавления в таблицу
EXEC InsertCar 1, 'т345тт', '102', 'In', '10:30:00'
EXEC InsertCar 3, 'а777тм', '178', 'Out', '10:02:00'
EXEC InsertCar 3, 'в536тм', '102', 'In', '10:02:00'
EXEC InsertCar 4, 'в123тм', '102', 'In', '10:02:00'
EXEC InsertCar 5, 'в556тм', '196', 'Out', '10:12:00'
EXEC InsertCar 4, 'а737тм', '102', 'In', '11:12:00'
EXEC InsertCar 1, 'т321аа', '777', 'In', '10:02:00'
EXEC InsertCar 2, 'а777тм', '02', 'In', '10:02:00'

--транзитные машины
EXEC InsertCar 2, 'т777тм', '777', 'In', '10:02:00'
EXEC InsertCar 4, 'т777тм', '777', 'Out', '10:15:00'
EXEC InsertCar 2, 'в777тм', '777', 'In', '10:02:00'
EXEC InsertCar 3, 'в777тм', '777', 'Out', '10:15:00'

--иногородние машины
EXEC InsertCar 3, 'к777тм', '777', 'In', '10:00:00'
EXEC InsertCar 3, 'к777тм', '777', 'Out', '10:15:00'
EXEC InsertCar 1, 'а621кн', '198', 'In', '11:00:00'
EXEC InsertCar 1, 'а621кн', '198', 'Out', '12:15:00'

--местные машины
EXEC InsertCar 2, 'в776тм', '02', 'In', '10:02:00'
EXEC InsertCar 3, 'в776тм', '02', 'Out', '10:15:00'
EXEC InsertCar 2, 'в876тм', '102', 'In', '10:02:00'
EXEC InsertCar 3, 'в876тм', '102', 'Out', '10:15:00'


SELECT * FROM Cars
SELECT * FROM LocalCars
SELECT * FROM TransitCars
SELECT * FROM NonLocalCars
