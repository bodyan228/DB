USE KB301_Bolshakov
GO

--�������� �� ������������ �������
EXEC InsertCar 2, '�556��', '02', 'Out', '10:06:00'
EXEC InsertCar 2, '�556��', '02', 'In', '10:02:00'

--�������� �� ������ ����������
EXEC InsertCar 2, '�777��', '02', 'In', '10:02:00'
EXEC InsertCar 2, '�777��', '02', 'In', '10:10:00'


--�������� �� ������������ �������
EXEC InsertCar 2, '�557��', '000', 'Out', '10:06:00'
EXEC InsertCar 2, '�557��', '300', 'Out', '10:06:00'
EXEC InsertCar 2, '�557��', '500', 'Out', '10:06:00'
EXEC InsertCar 2, '�557��', '900', 'Out', '10:06:00'
EXEC InsertCar 2, '�557��', '001', 'Out', '10:06:00'

--�������� �� ������������ ������
EXEC InsertCar 2, '�557��', '66', 'Out', '10:06:00'
EXEC InsertCar 2, '�557��', '66', 'Out', '10:06:00'
EXEC InsertCar 2, '�000��', '66', 'Out', '10:06:00'
EXEC InsertCar 2, '�557�', '66', 'Out', '10:06:00'

--��� ���������� � �������
EXEC InsertCar 1, '�345��', '102', 'In', '10:30:00'
EXEC InsertCar 3, '�777��', '178', 'Out', '10:02:00'
EXEC InsertCar 3, '�536��', '102', 'In', '10:02:00'
EXEC InsertCar 4, '�123��', '102', 'In', '10:02:00'
EXEC InsertCar 5, '�556��', '196', 'Out', '10:12:00'
EXEC InsertCar 4, '�737��', '102', 'In', '11:12:00'
EXEC InsertCar 1, '�321��', '777', 'In', '10:02:00'
EXEC InsertCar 2, '�777��', '02', 'In', '10:02:00'

--���������� ������
EXEC InsertCar 2, '�777��', '777', 'In', '10:02:00'
EXEC InsertCar 4, '�777��', '777', 'Out', '10:15:00'
EXEC InsertCar 2, '�777��', '777', 'In', '10:02:00'
EXEC InsertCar 3, '�777��', '777', 'Out', '10:15:00'

--����������� ������
EXEC InsertCar 3, '�777��', '777', 'In', '10:00:00'
EXEC InsertCar 3, '�777��', '777', 'Out', '10:15:00'
EXEC InsertCar 1, '�621��', '198', 'In', '11:00:00'
EXEC InsertCar 1, '�621��', '198', 'Out', '12:15:00'

--������� ������
EXEC InsertCar 2, '�776��', '02', 'In', '10:02:00'
EXEC InsertCar 3, '�776��', '02', 'Out', '10:15:00'
EXEC InsertCar 2, '�876��', '102', 'In', '10:02:00'
EXEC InsertCar 3, '�876��', '102', 'Out', '10:15:00'


SELECT * FROM Cars
SELECT * FROM LocalCars
SELECT * FROM TransitCars
SELECT * FROM NonLocalCars
