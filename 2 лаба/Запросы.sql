USE KB301_Bolshakov
GO

BEGIN TRY
	BEGIN TRANSACTION Trans

	UPDATE Debet.Card_Table
	SET Balance=Balance - 13400
	WHERE Card_Table.Value_name='RUB';

	UPDATE Debet.Card_Table
	SET Balance=Balance + (SELECT Price*13400 FROM Debet.Buy WHERE Debet.Buy.From_value='RUB' AND Debet.Buy.To_value='USD')
	WHERE Card_Table.Value_name='USD';

	COMMIT TRANSACTION Trans
	PRINT 'Перевод выполнен успешно!'
END TRY
BEGIN CATCH 
	ROLLBACK TRANSACTION Trans
		PRINT 'Перевод не выполнен, т.к. на счету недостаточно средств'
END CATCH
GO
/*Перевод с рублевого счета на долларовый*/

SELECT ROUND(SUM(Balance*Price),2) as 'Общий баланс в рублях'
FROM Debet.Card_Table
JOIN Debet.Sell 
ON Debet.Sell .To_value = 'RUB' AND Card_Table.Value_name = Debet.Sell .From_value
GO
/*Вывод общего баланса в рублях*/

UPDATE Debet.Card_Table
SET Balance=Balance + 500
WHERE Card_Table.Value_name='RUB';
GO
/*Пополнение рублевого счета на 500 */

BEGIN TRY
	UPDATE Debet.Card_Table
	SET Balance=Balance - 500
	WHERE Card_Table.Value_name='RUB';
	PRINT 'Успешное снятие наличных!'
END TRY
BEGIN CATCH 
	PRINT 'На балансе недостаточно средств' 
END CATCH
GO
/*Снятие 500 рублей со счета*/


SELECT Card_Table.Value_name as 'Валюта', Card_Table.Balance as 'Баланс' FROM Debet.Card_Table
WHERE Card_Table.Balance > 0
GO
/*Вывод баланса на ненулевых счетах*/
