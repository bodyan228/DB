USE KB301_Bolshakov
GO

INSERT INTO IDZ.Authors
VALUES
(1, 'Ը��� ���������� �����������', '11.11.1821'),
(2, '��� ���������� �������', '09.09.1828'),
(3, '������� ���������� ����������', '12.06.1979'),
(4, '������ ������� ��������', '20.08.1890'),
(5, '��������� ��������� ������', '06.06.1799'),
(6, '��������� ��������� ���������', '15.01.1795'),
(7, '������ ������� ���������', '15.10.1814'),
(8, '������ ����', '21.09.1947'),
(9, '������ ���������� �����', '01.06.1977'),
(10, '������� �������� ���������','02.04.1985'),
(11, '����� �������� �����','29.01.1860')

INSERT INTO IDZ.PublishingHouse
VALUES
(1, '�������-�������', '������'),
(2, '�������', '������'),
(3, '������-����', '�����-���������'),
(4, '������������ ����������', '�����-���������'),
(5, '���� �����', '���'),
(6, '�������', '�������')


INSERT INTO IDZ.Deliveries
VALUES
(3, '��������� ������ ����������', '�������� ����', '����. ������������, �.�����, ��.�����������������, �.14', '89881689578', '482608019236'),
(7, '��������� ����� ����������', '������', '', '89174568936', '456326982464'),
(9, '��������� ������ ���������', 'BooksClub', '�. ������, ��. ������, �.46', '89995648924', '456982314584'),
(11, '������ ������ ���������', '�������� �����', '�. �����-���������, ��. �����-������', '89568695423', '458963217855'),
(14, '�������� ����� ���������', '������ ��������', '����. ������������, �. ���, ��. ����, �. 123', '89871568456', '485693215899')


INSERT INTO IDZ.Books
VALUES
(1, '����� � ���', 2, 1300, 3),
(2, '���� ��������', 2, 960, 1),
(3, '������������ � ���������', 1, 432, 2),
(4, '�����', 1, 640, 4),
(5, '����� 2033', 3, 384, 5),
(6, '�����', 3, 263, 2),
(7, '������ ��� �������', 4, 320, 6),
(8, '���� ��� ���������', 4, 352, 6),
(9, '������� ������', 5, 288, 1),
(10, '����������� �����', 5, 160, 2),
(11, '���� �� ���', 6, 176, 4),
(12, '1812', 6, 353, 3),
(13, '�����', 7, 192, 2),
(14, '����� ������ �������', 7, 224, 6),
(15, '���', 8, 1392, 6),
(16, '�������� �������� ��������', 8, 480, 4),
(17, '������� ��������� �����', 9, 562, 2),
(18, '������ �� ���������', 9, 521, 6),
(19, '��������-��������', 10, 256, 3),
(20, '�������� ���',11, 305, 5)


INSERT INTO IDZ.Purchases
VALUES
(1,'08.10.2022',7, 'False', 2500, 100, 1),
(2,'09.10.2022',3, 'False', 1800, 50, 2),
(3,'09.10.2022',11, 'False', 2200, 75, 2),
(4,'11.10.2022',7, 'True', 1000, 5, 3),
(5,'12.10.2022',14, 'True', 1500, 4, 5),
(6,'12.10.2022',3, 'True', 1000, 1, 5),
(7,'1.11.2022',14, 'True', 2000, 3, 6),
(8,'1.11.2022',9, 'True', 1500, 5, 6),
(9,'5.11.2022',7, 'False', 1300, 100, 7),
(10,'5.11.2022',9, 'False', 1100, 70, 7),
(11,'15.11.2022',14, 'False', 1000, 100, 8),
(12,'16.11.2022',14, 'False', 900, 30, 9),
(13,'22.11.2022',11, 'True', 1700, 7, 10),
(14,'22.11.2022',7, 'False', 1500, 45, 10),
(15,'1.12.2022',11, 'True', 1500, 8, 11),
(16,'1.12.2022',11, 'True', 1200, 5, 11),
(17,'09.12.2022',9, 'True', 1000, 9, 12),
(18,'09.12.2022',9, 'True', 800, 8, 12),
(19,'13.12.2022',3, 'True', 500, 5, 13),
(20,'13.12.2022',14, 'False', 1200, 35, 14)
