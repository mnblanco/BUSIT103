--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #3              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
-- Submit your .sql file named with your last name, first name and assignment # (e.g., FreebergAssignment3.sql). 
-- Submit your file to the instructor using through the course site.  
--
-- Answer Summary:
-- Question		Points		YOUR ANSWER
--	1.			3			Ms. Kim Abercrombie
--	2.			3			29492 Mr. Jay Adams
--	3.			3			Customer ID 235 is Ms. Mary Alexander
--	4.			4			15: Headsets
--	5a.			5			12568.96
--	5b.			4			12873.98
--	6a.			5			1419.95
--	6b.			4			1341.84
--	7a.			6			PO19372114749 2004-06-08
--	7b.			4			PO7946145876 2004-06-01
--	7c.			5			5
--	7d.			2			5
--	8.			2			2017-04-26
--------------------------------------------------------------------------------------------------------------------

USE AdventureWorksLT2012;
--1.	List the customer id and the name for each customer using two columns. The customer id will 
--		be in the first column. Create a concatenation for the second column that combines the title,
--		first name, and last name for each customer. For example, the name for customer ID 29485 will  
--		display in one column as 
--					Ms. Catherine Abel
--		Don't forget to include a space between each part of the name. Assign CustomerName as the alias
--		for the derived column. Order the results in alphabetical order by last name then by first name.
--      3 points
--      I got 847 rows.
--		QUESTION:		What is the name in row 3?
--		YOUR ANSWER: Ms. Kim Abercrombie	
--
SELECT [CustomerID],[Title] + ' ' + [FirstName] + '  ' +  [LastName] as CustomerName
FROM [SalesLT].[Customer]
ORDER BY [LastName] ASC, [FirstName] ASC;
--2.	Using the CAST function, list the customer ID and the name for each customer in one column. 
--		Create a concatenation of the customer id, title, first name and last name for each customer. For 
--		example, the record for customer id 29485 will display in one column as 
--					29485 Ms. Catherine Abel
--		Assign CustomerInfo as the alias for the derived column. 
--		Order the results in alphabetical order by last name then by first name.
--		HINT: Look at the data type of the fields to which you are concatenating the customer id and cast 
--		customer id to match.
--      3 points
--      I got 847 rows.
--		QUESTION:		What is the value for CustomerInfo in row 7?
--		YOUR ANSWER:	29492 Mr. Jay Adams
SELECT CAST([CustomerID] AS nvarchar(5)) + ' ' + [Title] + ' '  + [FirstName] + ' ' + [LastName] AS CustomerInfo
FROM [SalesLT].[Customer]
ORDER BY [LastName] ASC, [FirstName] ASC;
--3.	Using the CAST function, rewrite the SELECT statement created in #2 to add the descriptive text  
--		"Customer ID" and "is". The record for customer id 29485 will display in one column as 
--					Customer ID 29485 is Ms. Catherine Abel
--		Use the same alias and sort order as #2.
--      3 points
--      I got 847 rows.
--		QUESTION:		What is the value for CustomerInfo in row 21?
--		YOUR ANSWER: Customer ID 235 is Ms. Mary Alexander
SELECT 'Customer ID ' + CAST([CustomerID] AS nvarchar(5)) + ' is ' + [Title] + ' '  + [FirstName] + ' ' + [LastName] AS CustomerInfo
FROM [SalesLT].[Customer]
ORDER BY [LastName] ASC, [FirstName] ASC;
--4.	Using the CAST function and the ProductCategory table, create a list of the product category  
--		and the category name in one column. Product category 1 will display in one column as 
--					Product Category 1: Bikes 
--		Give the derived column a meaningful alias (column name) and sort by the derived column in ascending order.
--      4 points
--      I got 41 rows.
--		QUESTION:		What is the value in row 7?
--		YOUR ANSWER:	15: Headsets
SELECT CAST([ProductCategoryID] AS nvarchar(5)) + ': ' +  [Name] AS ProductCategoryInfo
FROM [SalesLT].[ProductCategory]
ORDER BY ProductCategoryInfo ASC;
--5.	For a and b below, use the SalesLT.SalesOrderDetail table to list all product sales. 
--		Show SalesOrderID, TotalCost and LineTotal for each sale. Compute TotalCost as
--		UnitPrice * (1-UnitPriceDiscount)* OrderQty. Change the data type of LineTotal to money.
--      Display money values to exactly 2 decimal places (hint - use the ROUND function).
--		TotalCost and LineTotal should show the same amount. LineTotal is included to double check 
--		your calculation; the two amounts should match. Sort by TotalCost in descending order.   

--a.	CAST is the ANSI standard. Write the statement using CAST.
--      5 points
--      I got 542 rows.
--		QUESTION:		What is the TotalCost in record 6?
--		YOUR ANSWER:	12568.96
SELECT  CAST(ROUND([UnitPrice]  * (1 - [UnitPriceDiscount]) * [OrderQty],2) AS money) AS TotalCost, CAST(ROUND([LineTotal],2) AS money) as LineTotal
FROM [SalesLT].[SalesOrderDetail]
ORDER BY TotalCost DESC;
--b.	Write the statement again using CONVERT instead of CAST. CONVERT is also commonly used. 
--      4 points
--      I got 542 rows.
--		QUESTION:		What is the TotalCost in record 5?
--		YOUR ANSWER:	12873.98
SELECT  CONVERT(money,ROUND([UnitPrice]  * (1 - [UnitPriceDiscount]) * [OrderQty],2)) AS TotalCost, CONVERT(money, ROUND([LineTotal],2)) as LineTotal
FROM [SalesLT].[SalesOrderDetail]
ORDER BY TotalCost DESC;
--6.	For a. and b. below, AdventureWorks predicts a 3% increase in production costs for all their 
--		products. They wish to see how the increase will affect their profit margins. To help them 
--		understand the impact of this increase in production costs (StandardCost), you will create 
--		a list of all products showing ProductID, Name, ListPrice, FutureCost (use StandardCost * 1.03  
--		to compute FutureCost), and Profit (use ListPrice minus the calculation for FutureCost to find Profit). 
--		All money values are to show exactly 2 decimal places. Order the results descending by Profit. 
--      Hint: Use the DECIMAL or NUMERIC data type.

--a.	First write the requested statement using CAST. CAST is the ANSI standard. There will be five 
--		fields (columns). There will be one row for each product in the Product table. 
--      5 points
--      I got 295 rows.
--		QUESTION:		What is the Profit number in row 5?
--		YOUR ANSWER:	1419.95
SELECT [ProductID], [Name], ROUND([ListPrice],2) AS ListPrice, CAST(StandardCost * 1.03 AS decimal(10,2)) AS FutureCost, CAST([ListPrice] - StandardCost * 1.03 AS decimal(10,2)) as Profit
FROM [SalesLT].[Product]
ORDER BY Profit DESC;
--b.	Next write the statement from 6a again using CONVERT. There will be five 
--		fields (columns). There will be one row for each product in the Product table. 
--      4 points
--      I got 295 rows.
--		QUESTION:		What is the Profit number in row 10?
--		YOUR ANSWER:	1341.84	
SELECT [ProductID], [Name], ROUND([ListPrice],2) AS ListPrice, CONVERT(decimal(10,2),[StandardCost] * 1.03) AS FutureCost, CONVERT(decimal(10,2),[ListPrice] - StandardCost * 1.03) as Profit
FROM [SalesLT].[Product]
ORDER BY Profit DESC;
--7.	For a. and b. below, list all sales orders showing PurchaseOrderNumber, SalesOrderID, CustomerID, OrderDate, 
--		DueDate, and ShipDate. Format the datetime fields so that no time is displayed. Be sure to give each derived 
--		column an alias and order by CustomerID in ascending order. 

--a.	CAST is the ANSI standard. Write the statement using CAST. 
--      6 points
--      I got 32 rows.
--		QUESTION:		What is the PurchaseOrderNumber and ShipDate in the first record?
--		YOUR ANSWER:	PO19372114749 2004-06-08
SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CAST([OrderDate] AS DATE) AS OrderDate, CAST([DueDate] AS DATE) AS OrderDueDate, CAST([ShipDate] AS DATE) AS OrderShipDate
FROM [SalesLT].[SalesOrderHeader]
ORDER BY [CustomerID] ASC;
--b.	Write the statement again using CONVERT.
--      5 points
--      I got 32 rows.
--		QUESTION:		What is the SalesOrderID and OrderDate in the second record?
--		YOUR ANSWER:	PO7946145876 2004-06-01
SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CONVERT(DATE,[OrderDate]) AS OrderDate, CONVERT(DATE,[DueDate]) AS OrderDueDate, CONVERT(DATE,[ShipDate]) AS OrderShipDate
FROM [SalesLT].[SalesOrderHeader]
ORDER BY [CustomerID] ASC;
--c.	Write a statement using all of either 7a or 7b and add a field that calculates the 
--		difference between the ship date and the due date. Name the field ShipDays and show 
--		the result as a positive number. Be sure Datetime fields still show only the date. 
--		The DateDiff function is not an ANSI standard; don't use it in this statement. 
--      5 points
--      I got 32 rows.
--		QUESTION:		What is the value for ShipDays in all the records?
--		YOUR ANSWER:	5
SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CONVERT(DATE,[OrderDate]) AS OrderDate, CONVERT(DATE,[DueDate]) AS OrderDueDate, CONVERT(DATE,[ShipDate]) AS OrderShipDate, ABS(CONVERT(numeric,[ShipDate] - [DueDate])) AS ShipDays
FROM [SalesLT].[SalesOrderHeader]
ORDER BY [CustomerID] ASC;
--d.	Rewrite the statement from 7c to use the DateDiff function to find the 
--		difference between the ShipDate and the DueDate. Again, show only the date in datetime fields.
--      2 points
--      I got 32 rows.
--		QUESTION:		What is the value for ShipDays in all the records?
--		YOUR ANSWER:	5
SELECT [PurchaseOrderNumber], [SalesOrderID], [CustomerID], CONVERT(DATE,[OrderDate]) AS OrderDate, CONVERT(DATE,[DueDate]) AS OrderDueDate, CONVERT(DATE,[ShipDate]) AS OrderShipDate, DATEDIFF(DAY,[ShipDate],[DueDate]) AS ShipDays
FROM [SalesLT].[SalesOrderHeader]
ORDER BY [CustomerID] ASC;

--8.	EXPLORE: Research the following on the Web for an answer:
--		Find a date function that will return a datetime value that contains the date and time from the computer
--		on which the instance of SQL Server is running (this means it shows the date and time of the PC on which 
--		the function is executed). The time zone offset is not included. Write the statement so it will execute.
--		Format the result to show only the date portion of the field and give it the alias of MyPCDate.
--      2 points
SELECT CONVERT(DATE,SYSDATETIME()) as MyPCDate;  -- The time zone offset is not included.
SELECT CONVERT(DATE,SYSDATETIMEOFFSET()) as MyPCDate; -- The time zone offset is included.
SELECT CONVERT(DATE,SYSUTCDATETIME()) as MyPCDate;  -- The date and time is returned as UTC time (Coordinated Universal Time).




 
--8.	EXPLORE: Research the following on the Web for an answer:
--		Find a date function that will return a datetime value that contains the date and time from the computer
--		on which the instance of SQL Server is running (this means it shows the date and time of the PC on which 
--		the function is executed). The time zone offset is not included. Write the statement so it will execute.
--		Format the result to show only the date portion of the field and give it the alias of MyPCDate.
--      2 points
SELECT CONVERT(date,SYSDATETIME()) AS MyPCDate;


