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
	PRINT '������� �������� �������!'
END TRY
BEGIN CATCH 
	ROLLBACK TRANSACTION Trans
		PRINT '������� �� ��������, �.�. �� ����� ������������ �������'
END CATCH
GO
/*������� � ��������� ����� �� ����������*/

SELECT ROUND(SUM(Balance*Price),2) as '����� ������ � ������'
FROM Debet.Card_Table
JOIN Debet.Sell 
ON Debet.Sell .To_value = 'RUB' AND Card_Table.Value_name = Debet.Sell .From_value
GO
/*����� ������ ������� � ������*/

UPDATE Debet.Card_Table
SET Balance=Balance + 500
WHERE Card_Table.Value_name='RUB';
GO
/*���������� ��������� ����� �� 500 */

BEGIN TRY
	UPDATE Debet.Card_Table
	SET Balance=Balance - 500
	WHERE Card_Table.Value_name='RUB';
	PRINT '�������� ������ ��������!'
END TRY
BEGIN CATCH 
	PRINT '�� ������� ������������ �������' 
END CATCH
GO
/*������ 500 ������ �� �����*/


SELECT Card_Table.Value_name as '������', Card_Table.Balance as '������' FROM Debet.Card_Table
WHERE Card_Table.Balance > 0
GO
/*����� ������� �� ��������� ������*/
