/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [KCC].[dbo].[Orders]

  SELECT *
  FROM [KCC].[dbo].[Orders];



  SELECT COUNT(OrderID)
  AS TotalOrders
  FROM [KCC].[dbo].[Orders]
  ---Total number of orders:


  SELECT SUM(OrderTotal) 
  AS TotalSales 
  FROM [KCC].[dbo].[Orders];
  ---Total sales:

SELECT AVG(OrderTotal) 
AS AverageOrderTotal 
FROM [KCC].[dbo].[Orders];
---Average order total:


SELECT MIN(OrderTotal)
AS MinOrderTotal, 
MAX(OrderTotal) 
AS MaxOrderTotal 
FROM [KCC].[dbo].[Orders];
---Minimum and maximum order totals:

SELECT OrderDate, 
COUNT(OrderID) 
AS NumOrders 
FROM [KCC].[dbo].[Orders]
GROUP BY OrderDate;
---Orders by date (grouped by day)

SELECT CustomerID,
SUM(OrderTotal) 
AS TotalSpending 
FROM [KCC].[dbo].[Orders]
GROUP BY CustomerID 
ORDER BY TotalSpending DESC;
---Top customers by total spending:

SELECT CustomerID, 
COUNT(OrderID)
AS NumOrders 
FROM [KCC].[dbo].[Orders]
GROUP BY CustomerID;
---Orders placed by each customer:

SELECT TOP 
1 OrderID, OrderDate, CustomerID, OrderTotal 
FROM [KCC].[dbo].[Orders] 
ORDER BY OrderTotal DESC;
---Orders with the highest total

SELECT TOP 1 OrderID, OrderDate, CustomerID, OrderTotal 
FROM [KCC].[dbo].[Orders] 
ORDER BY OrderTotal ASC;
---Orders with the lowest total:


SELECT DATEPART(MONTH, OrderDate) AS Month, DATEPART(YEAR, OrderDate) AS Year, COUNT(OrderID) AS NumOrders
FROM [KCC].[dbo].[Orders]
GROUP BY DATEPART(MONTH, OrderDate), DATEPART(YEAR, OrderDate)
ORDER BY Year, Month;
---Orders by month and year:

SELECT CustomerID, AVG(OrderTotal) AS AverageOrderTotal
FROM [KCC].[dbo].[Orders]
GROUP BY CustomerID;
----Average order total by customer:


SELECT DATEPART(YEAR, OrderDate) AS Year, SUM(OrderTotal) AS TotalSales
FROM [KCC].[dbo].[Orders]
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY Year;
---Total sales by year:

SELECT TOP 5 CustomerID, AVG(OrderTotal) AS AverageOrderTotal
FROM [KCC].[dbo].[Orders]
GROUP BY CustomerID
ORDER BY AverageOrderTotal DESC;
---The top 5 customers with the highest average order total. 

SELECT OrderID, OrderDate, CustomerID, OrderTotal
FROM [KCC].[dbo].[Orders]
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-06-30';
---zero



SELECT O.OrderID, O.OrderDate, O.CustomerID, O.OrderTotal, C.CustomerName, C.Address, C.City, C.State, C.Zip, C.Country, C.Notes
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID;
---This query has joined the two tables

SELECT COUNT(OrderID) AS TotalOrders FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID;
---Total number of orders:


SELECT O.OrderID, O.OrderDate, O.CustomerID, O.OrderTotal, C.CustomerName, C.Address, C.City, C.State, C.Zip, C.Country, C.Notes
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
WHERE C.City = 'Oslo';

SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS NumOrders
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CustomerName;
---Number of orders per customer


SELECT O.OrderID, O.OrderDate, O.CustomerID, O.OrderTotal, C.CustomerName, C.Address, C.City, C.State, C.Zip, C.Country, C.Notes
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
WHERE O.OrderDate BETWEEN '2022-02-09' AND '2022-03-14'
---Orders placed between '2022-02-09' AND '2022-03-14'

SELECT SUM(O.OrderTotal) AS TotalOrderAmount
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
WHERE O.OrderDate BETWEEN '2022-02-09' AND '2022-03-14';

SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS NumOrders
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(O.OrderID) > 1;
---Customers with multiple orders:


SELECT DATEPART(MONTH, O.OrderDate) AS OrderMonth, COUNT(O.OrderID) AS NumOrders
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY DATEPART(MONTH, O.OrderDate);


SELECT DATEPART(MONTH, O.OrderDate) AS OrderMonth, AVG(O.OrderTotal) AS AverageOrderTotal
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY DATEPART(MONTH, O.OrderDate);

SELECT TOP 1 DATEPART(MONTH, O.OrderDate) AS OrderMonth, SUM(O.OrderTotal) AS TotalOrderAmount
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY DATEPART(MONTH, O.OrderDate)
ORDER BY TotalOrderAmount ASC;
---month with the least order total 

SELECT
    YEAR(O.OrderDate) AS OrderYear,
    COUNT(DISTINCT O.CustomerID) AS NumCustomers,
    LAG(COUNT(DISTINCT O.CustomerID)) OVER (ORDER BY YEAR(O.OrderDate)) AS PreviousYearCustomers,
    COUNT(DISTINCT O.CustomerID) / LAG(COUNT(DISTINCT O.CustomerID)) OVER (ORDER BY YEAR(O.OrderDate)) * 100 AS RetentionRate
FROM
    [KCC].[dbo].[Orders] O
    JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY
    YEAR(O.OrderDate);
	---Customer retention rate:


	SELECT TOP 3
    C.Country,
    AVG(O.OrderTotal) AS AverageOrderTotal
FROM
    [KCC].[dbo].[Orders] O
    JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY
    C.Country
HAVING
    AVG(O.OrderTotal) > 0
ORDER BY
    AverageOrderTotal DESC;
	---Top 3 countries with the highest average order total per customer:


	SELECT COUNT(*) AS NumCustomersWithNotes
FROM [KCC].[dbo].[Customers]
WHERE Notes IS NOT NULL;
---This query counts the number of customers where the Notes column is not null, indicating the presence of notes.


SELECT TOP 5 O.OrderID, O.OrderDate, O.CustomerID, O.OrderTotal, C.CustomerName, C.Notes
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
WHERE C.Notes IS NOT NULL
ORDER BY LEN(C.Notes) DESC;
---The query you provided retrieves the top 5 orders with the longest notes from the merged [KCC].[dbo].[Orders] and [KCC].[dbo].[Customers] tables.



SELECT O.OrderID, O.OrderDate, O.CustomerID
FROM [KCC].[dbo].[Orders] O
WHERE EXISTS (
    SELECT 1
    FROM [KCC].[dbo].[Customers] C
    WHERE O.CustomerID = C.CustomerID
    AND C.City = 'Oslo'
);
---The query I provided checks if there are any orders in the [KCC].[dbo].[Orders] table where the corresponding customer has the city 'Oslo' in the [KCC].[dbo].[Customers] table.

SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS NumOrders
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
WHERE C.City = 'Oslo'
GROUP BY C.CustomerID, C.CustomerName;
---This displays the count of orders for each customer from the city of Oslo

SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS NumOrders
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(O.OrderID) > 10;
---The query retrieves the customer details along with the count of orders for each customer who has more than 10 orders


SELECT O.OrderID, O.OrderDate, O.CustomerID, O.OrderTotal, C.CustomerName,
       CASE
           WHEN O.OrderTotal > 1000 THEN 'High Value'
           WHEN O.OrderTotal > 500 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS OrderCategory
FROM [KCC].[dbo].[Orders] O
JOIN [KCC].[dbo].[Customers] C ON O.CustomerID = C.CustomerID;
---In, the query selects the OrderID, OrderDate, CustomerID, OrderTotal, and CustomerName from the combined [KCC].[dbo].[Orders] 
---and [KCC].[dbo].[Customers] tables. The CASE clause is then used 
---to categorize the orders based on their OrderTotal into 'High Value', 'Medium Value', or 'Low Value' based on the specified conditions.








