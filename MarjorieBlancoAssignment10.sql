--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #10              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
-- Submit your .sql file named with your last name, first name and assignment # (e.g., FreebergCarlAssignment10.sql). 
-- Submit your file to the instructor using through the course site.  
--
-- Answer Summary:
-- Question		YOUR ANSWER
--	1a.			8473
--	1b.			Select all query and checked how many rows were returned	
--	1c.			3987	1435
--	1d.			3987	1435	65041.5368
--	2a.			80450596.98
--	2b.			1897139.03
--	3a.			29358677.22
--	3b.			4339443.38
--	4.			1774.25
--	5.			Touring-2000 Blue, 50
--	6.			539.99	1742.8745	3399.99	38
--	7.			Road-150 Red, 44
--	8a.			1476.90
--	8b.			902.13 Assumption: [FinishedGoodsFlag] = 1 is for product intended for sale
--	8c.			Mountain-200 Silver, 38
--	9.			3578.27

--------------------------------------------------------------------------------------------------------------------
--
-- GUIDELINES:
-- Unless specified that it is okay, don't hardcode values - use subqueries instead.
-- 
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--
-- Recall that sales to resellers are stored in the FactResellerSales table and sales to individual customers 
-- are stored in the FactInternetSales table. When asked to find Internet sales or sales to 'customers', you 
-- will be using the FactInternetSales table. 
--
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

USE AdventureWorksDW2014;
--------------------------------------------------------------------------------------------------------------------
-- 1.a.	Find the count of customers who are single. Be sure give each derived field an 
--		appropriate alias.
--      3 points
--		QUESTION:		How many customers are there who are single?	
--		YOUR ANSWER==>	8473
SELECT COUNT(*) AS 'Single Customers Count'
FROM [dbo].[DimCustomer]
WHERE [MaritalStatus] = 'S'; 
--1.b.	Check your result. Write queries to determine if the answer to 1.a. is correct. 
--		You should be doing proofs for all of your statements. This is a reminder to check our work.
--      2 points
--		QUESTION:		How did you check your answer?	
--		YOUR ANSWER==>	Select all query and checked how many rows were returned
SELECT *
FROM [dbo].[DimCustomer]
WHERE [MaritalStatus] = 'S'; 
--1.c.	Find the total children (sum) and the total cars owned (sum) for customers who are 
--		married and list their education level as Graduate Degree (use EnglishEducation).
--      4 points
--		QUESTION:		
--		YOUR ANSWER==>	3987	1435
SELECT SUM([TotalChildren]) AS 'Sun of Total Children', SUM([NumberCarsOwned]) AS  'Sum of Number of Cars'
FROM [dbo].[DimCustomer] 
WHERE [MaritalStatus] = 'M' AND [EnglishEducation] ='Graduate Degree'; 
--1.d.	Find the total children, total cars owned, and average yearly income for customers who are 
--		married and list their education level as Graduate Degree (use EnglishEducation).
--      2 points
--		QUESTION:		How many children, how many cars owned, and what average yearly income did you get?		
--		YOUR ANSWER==>	3987	1435	65041.5368
SELECT SUM([TotalChildren]) AS 'Sun of Total Children', SUM([NumberCarsOwned]) AS  'Sum of Number of Cars', AVG([YearlyIncome]) AS 'Average Yearly Income'
FROM [dbo].[DimCustomer]
WHERE [MaritalStatus] = 'M' AND [EnglishEducation] ='Graduate Degree';
--------------------------------------------------------------------------------------------------------------------
--
-- In the next set of questions you are looking for sales to resellers and sales to individual customers. 
---We will look at the information by total sales and then for sales by geographic locations for specific time 
---frames. Recall that sales to business customers (Resellers) is stored in the FactResellerSales table and sales 
---to individuals (Customers) is stored in the FactInternetSales table.*/
--
--------------------------------------------------------------------------------------------------------------------
--2.a.	List the total dollar amount (SalesAmount) for sales to Resellers. Round to two decimal places.
--      2 points
--		QUESTION:		What is the total dollar amount for sales to Resellers?	
--		YOUR ANSWER==>	80450596.98
SELECT ROUND(SUM([SalesAmount]),2) AS ' Total Sales Amount'
FROM [dbo].[FactResellerSales];
--2.b.	List the total dollar amount (SalesAmount) for 2013 sales to resellers who have an address in 
--		the state/province of Ontario in Canada. Show only the total sales--one row, one column--rounded 
--		to two decimal places. Hint: Use the FactResellerSales and DimGeography tables 
--      3 points
--		QUESTION:		What is the total dollar amount for 2013 sales to resellers who have an address in 
--						the state province of Ontario in Canada?	
--		YOUR ANSWER==>	1897139.03
SELECT ROUND(SUM([SalesAmount]),2) AS ' Total Sales Amount'
FROM [dbo].[FactResellerSales] AS frs
INNER JOIN [dbo].[DimReseller] AS dr
ON frs.[ResellerKey] = dr.[ResellerKey]
INNER JOIN [dbo].[DimGeography] AS dg
ON dr.[GeographyKey] = dg.[GeographyKey]
WHERE YEAR(frs.[OrderDate]) = '2013' AND dg.[StateProvinceName] = 'Ontario' AND dg.[CountryRegionCode] = 'CA';
--3.a.	List the total dollar amount (SalesAmount) for sales to customers. Round to two decimal places.
--      2 points
--		QUESTION:		What is the total dollar amount for sales to customers?	
--		YOUR ANSWER==>	29358677.22
SELECT ROUND(SUM([SalesAmount]),2) AS 'Total Customer Sales Amount'
FROM [dbo].[FactInternetSales];
--3.b.	List the total dollar amount (SalesAmount) for 2013 sales to customers located in 
--		Victoria, Australia. Show only the total sales--one row, one column--rounded to two decimal places. 
--      3 points
--		QUESTION:		What is the total dollar amount for 2013 sales to customers located in Victoria, Australia?
--		YOUR ANSWER==>	4339443.38
SELECT ROUND(SUM([SalesAmount]),2) AS 'Total Customer Sales Amount'
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimSalesTerritory] AS dst 
ON fis.[SalesTerritoryKey] = dst.[SalesTerritoryKey]
WHERE [SalesTerritoryRegion] in ('Australia') 
AND YEAR(fis.[OrderDate]) = '2013' 
--------------------------------------------------------------------------------------------------------------------
--
--  In the next group of requests we are answering questions about bikes. We are asked to create
--  information about bikes either by a specific subcategory or in total.  It is important here that 
--  you recall how to find bikes and subcategories of bikes within the tables. 
--
--------------------------------------------------------------------------------------------------------------------
--4.	List the average unit price for a touring bike sold to customers. Round to two 
--		decimal places.
--      4 points
--		QUESTION:		What is the average unit price for a touring bike sold to customers?	
--		YOUR ANSWER==>	1774.25
SELECT ROUND(AVG([UnitPrice]),2) AS 'Average Unit Price for Touring Bikes'
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimProduct] AS dp
ON fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimProductSubcategory] AS dps
ON dp.[ProductSubcategoryKey] = dps.[ProductSubcategoryKey]
WHERE  [EnglishProductSubcategoryName]= 'Touring Bikes';
--5.	List bikes that have a list price less than the average list price for all bikes. Show 
--		product alternate key, English product name, and list price. Order by list price descending
--		and English product name ascending.
--      5 points
--      I got 75 rows.
--		QUESTION:		What is the name of the bike in record 7?	
--		YOUR ANSWER==>	Touring-2000 Blue, 50
SELECT dp.[ProductAlternateKey], dp.[EnglishProductName], dp.[ListPrice]
FROM [dbo].[DimProduct] AS dp
INNER JOIN [dbo].[DimProductSubcategory] AS dpsc
ON dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
INNER JOIN [dbo].[DimProductCategory] AS dpc
ON dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
WHERE dpc.[EnglishProductCategoryName] = 'Bikes' AND dp.[ListPrice] < (SELECT AVG(dp.[ListPrice])
                                                                       FROM [dbo].[DimProduct] AS dp
					                                                   INNER JOIN [dbo].[DimProductSubcategory] AS dpsc
					                                                   ON dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
					                                                   INNER JOIN [dbo].[DimProductCategory] AS dpc
		                                                  			   ON dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
			                                                  		  WHERE dpc.[EnglishProductCategoryName] = 'Bikes')
ORDER BY [ListPrice] DESC, [EnglishProductName] ASC;
--6.	List the lowest list price, the average list price, the highest list price, and product count 
--		for mountain bikes. 
--      4 points
--		QUESTION:		What is the lowest list price, the average list price, the highest list price, and product count for mountain bikes?	
--		YOUR ANSWER==>	539.99	1742.8745	3399.99	38
SELECT MIN([ListPrice]) AS 'Min List Price', AVG([ListPrice]) AS 'Average List Price', MAX([ListPrice]) AS 'Max List Price', COUNT(*) AS 'Mountain Bikes Count'
FROM [dbo].[DimProduct] AS dp
INNER JOIN [dbo].[DimProductSubcategory] AS dpsc
ON dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
WHERE dpsc.[EnglishProductSubcategoryName] = 'Mountain Bikes'
--------------------------------------------------------------------------------------------------------------------
--
--  In the next requests we are digging into the products sold by AdventureWorks by finding the highest 
--  priced products, the profit or loss on products sold to dealers, and the products with the largest   
--  profit on dealer price.
--
--------------------------------------------------------------------------------------------------------------------
-- 7.	List the product alternate key, product name, and list price for the product(s) 
--		with the highest List Price. There can be multiple products with the highest list price.
--      Sort by Product Alternate Key ascending. 
--      4 points
--		QUESTION:		What is the English Product Name record 1?
--		YOUR ANSWER==>	Road-150 Red, 44
SELECT [ProductAlternateKey], [EnglishProductName], [ListPrice]
FROM [dbo].[DimProduct]
WHERE [ListPrice] = (SELECT MAX([ListPrice]) 
                     FROM [dbo].[DimProduct])
ORDER BY [ProductAlternateKey];
-- 8.a.	List the product alternate key, product name, list price, standard cost and the 
--		difference (calculated field) between the list price and the standard cost for all product(s). 
--		Show all money values to 2 decimal places. Sort on difference from highest to lowest
--		and product alternate key in ascending order.
--      4 points
--      I got 606 rows.
--		QUESTION:		What is the difference between the list price and the standard cost in record 5?
--		YOUR ANSWER==>	1476.90
SELECT [ProductAlternateKey], [EnglishProductName], ROUND([ListPrice],2) AS 'ListPrice', ROUND([StandardCost],2) AS 'StandardCost', ROUND([ListPrice]-[StandardCost],2) AS 'Difference'
FROM [dbo].[DimProduct]
ORDER BY 'Difference' DESC, [ProductAlternateKey] ASC;
-- 8.b.	As we learned in prior modules, some products are not intended to be sold and some products in the 
--		table have been updated and are no longer sold. Follow the same specifications as 8.a. for this statement. 
--		Also eliminate from your list all products that are not intended for sale (i.e. not a finished good) 
--      and those no longer for sale.
--      Explore the data -- you have enough information to answer this. If you make assumptions, state them in comments.
--      3 points
--      I got 197 rows.
--		QUESTION:		Still sorting on the difference from highest to lowest, and on product alternate key ascending,
--						what is the difference between the list price and the standard cost in record 7?	
--		YOUR ANSWER==>	902.13 Assumption: [FinishedGoodsFlag] = 1 is for product intended for sale
SELECT [ProductAlternateKey], [EnglishProductName], ROUND([ListPrice],2) AS 'ListPrice', ROUND([StandardCost],2) AS 'StandardCost', ROUND([ListPrice]-[StandardCost],2) AS 'Difference'
FROM [dbo].[DimProduct]
WHERE [FinishedGoodsFlag] = 1 AND [Status] = 'Current'
ORDER BY 'Difference' DESC, [ProductAlternateKey] ASC;
-- 8.c.	Use the statement from 8.b. and modify to find the currently sold product(s) with the largest 
--		difference between the list price and the standard cost of all currently sold products. Show all 
--		money values to 2 decimal places. Hint: There will be records in the results set.
--      3 points
--		QUESTION:		What is the name of the product in the 1st record of the results set?
--		YOUR ANSWER==>	Mountain-200 Silver, 38
SELECT [ProductAlternateKey], [EnglishProductName], ROUND([ListPrice],2) AS 'ListPrice', ROUND([StandardCost],2) AS 'StandardCost', ROUND([ListPrice]-[StandardCost],2) AS Difference
FROM [dbo].[DimProduct]
WHERE [FinishedGoodsFlag] = 1 AND [Status] = 'Current' AND ROUND([ListPrice]-[StandardCost],2) >= (SELECT MAX(ROUND([ListPrice]-[StandardCost],2))
                                                                                                  FROM [dbo].[DimProduct]
																								  WHERE [FinishedGoodsFlag] = 1 AND [Status] = 'Current')
ORDER BY Difference DESC, [ProductAlternateKey] ASC;
--9.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an aggregate function. Be sure to write your question as a comment. 
--		Then write the complete SQL query that will provide the information that you are seeking.
--      2 points
--9.	List the fist name, middle name, last name, lowest sales amount, the highest sales amount, and the average sales amount for each customer.
--		Show all money values to 2 decimal places. Sort on average sales from highest to lowest
--		and custome name in ascending order.
--		QUESTION:	What is the average sales for 1st record?
--		YOUR ANSWER==>	3578.27
SELECT CONCAT([FirstName],' ',[MiddleName],' ',[LastName]) AS 'Customer Name', Round(MIN([SalesAmount]),2) AS 'Min', Round(MAX([SalesAmount]),2) AS 'Max', Round(AVG([SalesAmount]),2) AS AverageSales
FROM [dbo].[DimCustomer] AS dc
INNER JOIN [dbo].[FactInternetSales] AS fis
ON fis.[CustomerKey] = dc.[CustomerKey]
GROUP BY CONCAT([FirstName],' ',[MiddleName],' ',[LastName])
ORDER BY AverageSales DESC, 'Customer Name' ASC;


 

