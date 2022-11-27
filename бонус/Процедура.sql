CREATE PROCEDURE DynamicTable
	(
		@TableSRC NVARCHAR(100),   --Таблица источник (Представление)
		@ColumnName NVARCHAR(100), --Столбец, содержащий значения, которые станут именами столбцов
		@Field NVARCHAR(100),      --Столбец, над которым проводить агрегацию
		@FieldRows NVARCHAR(100),  --Столбец (столбцы) для группировки по строкам (Column1, Column2)
		@FunctionType NVARCHAR(20) = 'SUM',--Агрегатная функция (SUM, COUNT, MAX, MIN, AVG), по умолчанию SUM
		@Condition NVARCHAR(200) = '' --Условие (WHERE и т.д.). По умолчанию без условия
	)
	AS 
	BEGIN        
		--Переменная для хранения строки запроса
		DECLARE @Query NVARCHAR(MAX);                     
		--Переменная для хранения имен столбцов
		DECLARE @ColumnNames NVARCHAR(MAX);              
		--Переменная для хранения заголовков результирующего набора данных
		DECLARE @ColumnNamesHeader NVARCHAR(MAX); 

		--Таблица для хранения уникальных значений, которые будут использоваться в качестве столбцов      
		CREATE TABLE TempColumnNames(ColumnName NVARCHAR(100) NOT NULL PRIMARY KEY);
        
		--Формируем строку запроса для получения уникальных значений для имен столбцов
		SET @Query = N'INSERT INTO TempColumnNames (ColumnName)
					   SELECT DISTINCT ' + @ColumnName + 
					 ' FROM ' + @TableSRC + ';'
                
		--Выполняем строку запроса
		EXEC (@Query);

		--Формируем строку с именами столбцов
		SELECT @ColumnNames = ISNULL(@ColumnNames + ', ','') + QUOTENAME(ColumnName) 
		FROM TempColumnNames;
               
		--Формируем строку для заголовка динамического перекрестного запроса (PIVOT)
		SELECT @ColumnNamesHeader = ISNULL(@ColumnNamesHeader + ', ','') + 'COALESCE(' + QUOTENAME(ColumnName) + ', 0) AS '+ QUOTENAME(ColumnName)
		FROM TempColumnNames;
        
		--Формируем строку с запросом PIVOT
		SET @Query = N'SELECT ' + @FieldRows + ' , ' + @ColumnNamesHeader + ' 
					   FROM (SELECT ' + @FieldRows + ', ' + @ColumnName + ', ' + @Field 
				   + ' FROM ' + @TableSRC  + ' ' + @Condition + ') AS SRC
					   PIVOT ( ' + @FunctionType + '(' + @Field + ')' +' FOR ' +  
					   @ColumnName + ' IN (' + @ColumnNames + ')) AS PVT
					   ORDER BY ' + @FieldRows + ';'
                
		--Удаляем временную таблицу
		DROP TABLE TempColumnNames;

		--Выполняем строку запроса с PIVOT
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
