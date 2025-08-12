create database Hello;
use Hello;
create table Customers(
CustomerID int primary key ,
Customer_Name varchar(20),
Country varchar(20)
);
insert into Customers(CustomerID,Customer_Name,Country)values(1,'John','Africa'),
(2,'Aditya','India'),
(3,'Rahul','USA'),
(4,'Aarvik','India')
;
create table Orders(
Order_ID int primary key,
CustomerID int,
Amount Decimal(10,2),
foreign key (CustomerID) references Customers(CustomerID)
);

insert into Orders(Order_ID,CustomerID,Amount)values(101,1,500),
(102,2,1000),
(103,3,2000),
(104,4,3000);
SELECT Customer_Name,
       (SELECT MAX(Amount)
        FROM Orders
        WHERE Orders.CustomerID = Customers.CustomerID) AS HighestOrder
FROM Customers;
SELECT Customer_Name
FROM Customers c
WHERE EXISTS (SELECT 1 
              FROM Orders o 
              WHERE o.CustomerID = c.CustomerID);
              
              
-- 4. Correlated Subquery
SELECT Customer_Name
FROM Customers c
WHERE (SELECT MAX(Amount) 
       FROM Orders o 
       WHERE o.CustomerID = c.CustomerID) > 600;
-- Subquery in FROM (Derived Table)

SELECT Country, AVG(TotalAmount) AS AvgOrderAmount
FROM (
    SELECT c.Country, SUM(o.Amount) AS TotalAmount
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.Country
) AS CustomerTotals
GROUP BY Country;
SELECT Customer_Name
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE Amount > 500);
