CREATE PROCEDURE DynamicTable
	(
		@TableSRC NVARCHAR(100),   --������� �������� (�������������)
		@ColumnName NVARCHAR(100), --�������, ���������� ��������, ������� ������ ������� ��������
		@Field NVARCHAR(100),      --�������, ��� ������� ��������� ���������
		@FieldRows NVARCHAR(100),  --������� (�������) ��� ����������� �� ������� (Column1, Column2)
		@FunctionType NVARCHAR(20) = 'SUM',--���������� ������� (SUM, COUNT, MAX, MIN, AVG), �� ��������� SUM
		@Condition NVARCHAR(200) = '' --������� (WHERE � �.�.). �� ��������� ��� �������
	)
	AS 
	BEGIN        
		--���������� ��� �������� ������ �������
		DECLARE @Query NVARCHAR(MAX);                     
		--���������� ��� �������� ���� ��������
		DECLARE @ColumnNames NVARCHAR(MAX);              
		--���������� ��� �������� ���������� ��������������� ������ ������
		DECLARE @ColumnNamesHeader NVARCHAR(MAX); 

		--������� ��� �������� ���������� ��������, ������� ����� �������������� � �������� ��������      
		CREATE TABLE TempColumnNames(ColumnName NVARCHAR(100) NOT NULL PRIMARY KEY);
        
		--��������� ������ ������� ��� ��������� ���������� �������� ��� ���� ��������
		SET @Query = N'INSERT INTO TempColumnNames (ColumnName)
					   SELECT DISTINCT ' + @ColumnName + 
					 ' FROM ' + @TableSRC + ';'
                
		--��������� ������ �������
		EXEC (@Query);

		--��������� ������ � ������� ��������
		SELECT @ColumnNames = ISNULL(@ColumnNames + ', ','') + QUOTENAME(ColumnName) 
		FROM TempColumnNames;
               
		--��������� ������ ��� ��������� ������������� ������������� ������� (PIVOT)
		SELECT @ColumnNamesHeader = ISNULL(@ColumnNamesHeader + ', ','') + 'COALESCE(' + QUOTENAME(ColumnName) + ', 0) AS '+ QUOTENAME(ColumnName)
		FROM TempColumnNames;
        
		--��������� ������ � �������� PIVOT
		SET @Query = N'SELECT ' + @FieldRows + ' , ' + @ColumnNamesHeader + ' 
					   FROM (SELECT ' + @FieldRows + ', ' + @ColumnName + ', ' + @Field 
				   + ' FROM ' + @TableSRC  + ' ' + @Condition + ') AS SRC
					   PIVOT ( ' + @FunctionType + '(' + @Field + ')' +' FOR ' +  
					   @ColumnName + ' IN (' + @ColumnNames + ')) AS PVT
					   ORDER BY ' + @FieldRows + ';'
                
		--������� ��������� �������
		DROP TABLE TempColumnNames;

		--��������� ������ ������� � PIVOT
		EXEC (@Query);
	END;
GO

CREATE PROCEDURE DeleteValue
	(
	 @Del VARCHAR(3)
	 )
	 AS
	 BEGIN
		DELETE FROM Bonus.CrossCurrencyTable
		WHERE FromValue = @Del OR ToValue = @Del
	 END
GO



	
EXEC DynamicTable 'Bonus.CrossCurrencyTable', 'ToValue', 'Price', 'FromValue'
EXEC DeleteValue 'AUD'
EXEC DynamicTable 'Bonus.CrossCurrencyTable', 'ToValue', 'Price', 'FromValue'
