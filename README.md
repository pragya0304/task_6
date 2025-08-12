Task 6: Subqueries and Nested Queries in SQL
# Objective
To practice using scalar subqueries, correlated subqueries, and derived tables in SQL, and understand their role in filtering, selecting, and aggregating data.

# Tools Used
MySQL Workbench 

MySQL 8.0

# Description
In this task, we created two related tables (Customers and Orders) and wrote SQL queries using subqueries in:

SELECT (Scalar subqueries)

WHERE (IN, EXISTS, correlated subqueries)

FROM (Derived tables)

# Database Setup
CREATE DATABASE Hello;
USE Hello;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Customer_Name VARCHAR(20),
    Country VARCHAR(20)
);

INSERT INTO Customers (CustomerID, Customer_Name, Country) VALUES
(1, 'John', 'Africa'),
(2, 'Aditya', 'India'),
(3, 'Rahul', 'USA'),
(4, 'Aarvik', 'India');

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (Order_ID, CustomerID, Amount) VALUES
(101, 1, 500),
(102, 2, 1000),
(103, 3, 2000),
(104, 4, 3000);
## SQL Queries
1️ Scalar Subquery in SELECT

SELECT Customer_Name,
       (SELECT MAX(Amount)
        FROM Orders
        WHERE Orders.CustomerID = Customers.CustomerID) AS HighestOrder
FROM Customers;
Purpose: Returns each customer's highest order amount.

2️ Subquery in WHERE with EXISTS

SELECT Customer_Name
FROM Customers c
WHERE EXISTS (SELECT 1 
              FROM Orders o 
              WHERE o.CustomerID = c.CustomerID);
Purpose: Returns customers who have placed at least one order.

3 Correlated Subquery in WHERE

SELECT Customer_Name
FROM Customers c
WHERE (SELECT MAX(Amount) 
       FROM Orders o 
       WHERE o.CustomerID = c.CustomerID) > 600;
Purpose: Returns customers whose highest order is greater than 600.

4️ Subquery in FROM (Derived Table)

SELECT Country, AVG(TotalAmount) AS AvgOrderAmount
FROM (
    SELECT c.Country, SUM(o.Amount) AS TotalAmount
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.Country
) AS CustomerTotals
GROUP BY Country;
Purpose: Calculates the average total order amount per country.

5️ Subquery in WHERE with IN

SELECT Customer_Name
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE Amount > 500);
Purpose: Returns customers who have any order above 500.

# Sample Output Example
Customer_Name	HighestOrder
John	500.00
Aditya	1000.00
Rahul	2000.00
Aarvik	3000.00

## Outcome
Learned scalar subqueries inside SELECT statements.

Understood correlated subqueries and how they depend on outer queries.

Used EXISTS, IN, and derived tables effectively.

Practiced filtering and aggregating data using subqueries.
