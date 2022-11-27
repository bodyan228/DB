USE KB301_Bolshakov
Go

SELECT * FROM ���������.Item /*������� ��� ������ �� ������� Item*/
Go

SELECT * FROM ���������.Group_Item /*������� ��� ������ �� ������� Group_Item*/
Go

SELECT * FROM ���������.Shop /*������� ��� ������ �� ������� Shop*/
Go

SELECT * FROM ���������.Storage /*������� ��� ������ �� ������� Storage*/
Go

SELECT * FROM ���������.Item
WHERE Unit = '����' /*������� ��� ������ �� ������� Item, ��� ������� ��������� ����� '����' */
Go

SELECT * FROM ���������.Storage 
WHERE Market_street = '����������' /*������� ��� ������ �� ������� Storage, ��� Street ����� '����������'*/
Go

SELECT * FROM ���������.Storage 
WHERE Market_street = '������' AND Price > 100 /*������� ��� ������ �� ������� Storage, ��� Street ����� '������' � Price ������ 100*/
Go

SELECT * FROM ���������.Storage 
WHERE Market_street = '������' AND Price > 100  
ORDER BY Price /*������� ��� ������ �� ������� Storage, ��� Street ����� '������' � Price ������ 100 � ������������� �� ����*/
Go

SELECT * FROM ���������.Storage 
WHERE Item_count BETWEEN 300 AND 1500 /*������� ��� ������ �� ������� Storage, ��� ���������� ������� ����� � ���������� �� 300 �� 1500*/
Go

UPDATE ���������.Group_Item 
SET Group_name='������� ������' 
WHERE Group_name = '������ ��� �����' /* ���������� ���� '������ ��� �����' �� '������� ������'*/
Go


SELECT * FROM ���������.Storage JOIN ���������.Item 
ON ���������.Storage.Item_id = ���������.Item.Item_id 
WHERE ���������.Storage.Item_id = 1 AND ���������.Storage.Item_count > 0/*����� ��������� ��� ���� ���� */
Go

SELECT Price as '����', FORMAT(Item_date, 'D', 'ru-RU') as '����' FROM ���������.Storage /*�������������� ���� � �������� �������*/
Go


SELECT TOP 1 Market_street as '�������� �����', Market_home as '����� ����', Price as '����' 
FROM ���������.Storage JOIN ���������.Item
ON ���������.Storage.Item_id = ���������.Item.Item_id 
WHERE ���������.Storage.Item_id = 3  
ORDER BY Price /*����� ��������, � ������� ������ ����������� ���������*/
Go


SELECT SUM(Item_count*Item_status) as '����������' FROM ���������.Storage JOIN ���������.Item
ON ���������.Storage.Item_id = ���������.Item.Item_id
WHERE ���������.Storage.Item_id = 4 AND Item_count > 0 AND Item_date BETWEEN '2022-1-11 00:00:00' AND '2022-30-11 00:00:00' /*�������� ����� ���������� �� ����� ��������� � ����������*/
Go 

SELECT TOP 1 Market_street as '�������� �����', Market_home as '����� ����', Price FROM ���������.Storage JOIN ���������.Item
ON ���������.Storage.Item_id = ���������.Item.Item_id 
WHERE ���������.Storage.Item_id = 3  
ORDER BY Price /*����� ��������, � ������� ������ ����������� ��������� 1 ������*/
Go

SELECT ���������.Shop.Market_street as '�������� �����', ���������.Shop.Market_home as '����� ����' , ���������.Storage.Price as '����', ���������.Shop.Shop_name as '�������� ��������'
FROM ���������.Shop JOIN ���������.Storage 
ON ���������.Storage.Market_street = ���������.Shop.Market_street AND ���������.Storage.Market_home = ���������.Shop.Market_home
WHERE ���������.Storage.Price = 
(SELECT MIN(Price) FROM ���������.Storage JOIN ���������.Item
 ON ���������.Storage.Item_id = ���������.Item.Item_id
 WHERE ���������.Item.Item_id = 3) /*����� ��������, � ������� ������ ����������� ��������� 2 ������*/