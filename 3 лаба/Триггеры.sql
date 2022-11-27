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
        (C, NNN, CC, Region)
        SELECT * FROM inserted
    END
GO

CREATE TRIGGER PolicePostInsert
ON Task3.PolicePost
INSTEAD OF INSERT
AS
  DECLARE @NewEventTime time 
  DECLARE @NewCarEvent varchar(3)

  SELECT @NewEventTime = EventTime FROM inserted
  SELECT @NewCarEvent = CarEvent FROM inserted

  IF NOT EXISTS  (
    SELECT EventTime
    FROM W3.PolicePost
    WHERE CarId = (SELECT CarId FROM inserted)
  )
  BEGIN
    DECLARE @OldEventTime time
    DECLARE @OldCarEvent varchar(3)

    select top 1 @OldEventTime =
      EventTime
      from W3.PolicePost
      where CarId = (select CarId from inserted)
      order by EventTime desc
    select top 1 @OldCarEvent =
      CarEvent
      from W3.PolicePost
      where CarId = (select CarId from inserted)
      order by EventTime desc

    if (datediff(mi, @OldEventTime, @NewEventTime) < 5) or (@OldCarEvent like @NewCarEvent)
      begin
        raiserror('Невозможно.. Время меньше пяти минут', 1, 0)
      end
    else
      begin
        insert into W3.PolicePost
          (PostId, CarId, CarEvent, EventTime)
          select PostId, CarId, CarEvent, EventTime from inserted
      end
  end
go 