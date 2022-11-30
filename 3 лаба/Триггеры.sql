USE KB301_Bolshakov
GO


CREATE TRIGGER PolicePostInsert
ON Task3.PolicePost
INSTEAD OF INSERT
AS
  DECLARE @NewTime time 
  DECLARE @NewEvent varchar(3)
  DECLARE @Region varchar(3)
  DECLARE @Number varchar(6)

  SELECT @NewTime = CarTime FROM inserted
  SELECT @NewEvent = CarInOut FROM inserted
  SELECT @Region = CarRegion FROM inserted
  SELECT @Number = CarNumber FROM inserted

  IF (@Region NOT LIKE '[0-9][1-9]' and @Region NOT LIKE '1[0-9][0-9]' and 
		@Region NOT LIKE '2[0-9][0-9]' and @Region NOT LIKE '7[0-9][0-9]')
		THROW 50002, 'Такого региона не существует!', 2

  IF (@Number NOT LIKE '_[0-9][0-9][0-9]__' or @Number LIKE '_000__' or
		@Number NOT LIKE '[АВЕКМНОРСТУХ]___[АВЕКМНОРСТУХ][АВЕКМНОРСТУХ]')
        THROW 50003, 'Такого номера не существует!', 3

  IF EXISTS  (
    SELECT CarInOut
    FROM Task3.PolicePost
    WHERE CarNumber = (SELECT UPPER(CarNumber) FROM inserted) and CarRegion = (SELECT CarRegion FROM inserted) 
  )
  BEGIN
    DECLARE @OldTime time
    DECLARE @OldEvent varchar(3)

    SELECT TOP 1 @OldTime = CarTime
    FROM Task3.PolicePost
    WHERE CarNumber = (SELECT UPPER(CarNumber) FROM inserted)
    ORDER BY CarTime DESC

    SELECT TOP 1 @OldEvent = CarInOut
    FROM Task3.PolicePost
    WHERE CarNumber = (SELECT UPPER(CarNumber) FROM inserted)
    ORDER BY CarTime DESC

    IF (DATEDIFF(mi, @OldTime, @NewTime) < 5) or (@OldEvent like @NewEvent)
		THROW 50001,'С момента послдней регистрации прошло менее 5 минут!', 1

    ELSE
      BEGIN
        INSERT INTO Task3.PolicePost
          (PostId, CarNumber, CarRegion, CarInOut, CarTime)
          SELECT PostId, UPPER(CarNumber),CarRegion, CarInOut, CarTime FROM inserted
      END
  END

  ELSE
    BEGIN
      IF NOT EXISTS (
        SELECT CarNumber, CarRegion
        FROM Task3.PolicePost
        WHERE CarNumber = (SELECT CarNumber FROM inserted) AND CarRegion = (SELECT CarRegion FROM inserted)
      )
		INSERT INTO Task3.PolicePost
		(PostId, CarNumber, CarRegion, CarInOut, CarTime)
		SELECT PostId, UPPER(CarNumber), CarRegion, CarInOut, CarTime FROM inserted
	END
GO
