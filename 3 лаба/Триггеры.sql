USE KB301_Bolshakov
GO

CREATE TRIGGER CarNumberInsert
ON Task3.CarNumber
INSTEAD OF INSERT
AS
  DECLARE @CarRegionCode varchar(3)
  SELECT @CarRegionCode = Region FROM inserted
  IF NOT EXISTS (
    SELECT VariactionRegion
    FROM Task3.VariactionRegion
    WHERE VariactionRegion = @CarRegionCode
  )
    RAISERROR('Недопустимый регион...', 1, 0)
  ELSE
    BEGIN
      INSERT INTO Task3.CarNumber
        (CNNNCC, Region)
        SELECT UPPER(CNNNCC), Region FROM inserted
    END
GO


CREATE TRIGGER PolicePostInsert
ON Task3.PolicePost
INSTEAD OF INSERT
AS
  DECLARE @NewTime time 
  DECLARE @NewEvent varchar(3)

  SELECT @NewTime = CarTime FROM inserted
  SELECT @NewEvent = CarInOut FROM inserted

  IF EXISTS  (
    SELECT CarInOut
    FROM Task3.PolicePost
    WHERE CarNumber = (SELECT UPPER(CarNumber) FROM inserted)
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
      BEGIN
        RAISERROR('С момента послдней регистрации прошло менее 5 минут', 1, 0)
      END
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
        SELECT CNNNCC
        FROM Task3.CarNumber
        WHERE CNNNCC = (SELECT CarNumber FROM inserted) AND Region = (SELECT Region FROM inserted)
      )
		BEGIN
          INSERT INTO Task3.CarNumber
            (CNNNCC, Region)
            SELECT CarNumber, CarRegion FROM inserted
        END
		INSERT INTO Task3.PolicePost
        (PostId, CarNumber, CarRegion, CarInOut, CarTime)
        SELECT PostId, UPPER(CarNumber), CarRegion, CarInOut, CarTime FROM inserted
	END
GO
