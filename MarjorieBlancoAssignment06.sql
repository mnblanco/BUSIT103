--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #6              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
--You are required to use INNER JOINs to solve each problem. Even if you know another method that will produce 
--the result, this module is practice in INNER JOINs.

-- Submit your .sql file named with your last name, first name and assignment # (e.g., FreebergAssignment6.sql). 
-- Submit your file to the instructor using through the course site. 
--
-- If no sort order is specified, assume it is in ascending order. 
--
-- Answer Summary:
-- Question		YOUR ANSWER
--	1a.			jill@margiestravel.com		
--	1b.			798			
--	2a.			H			
--	2b.			343.65		
--	2c.			680	
--	3a.			Bottles and Cages
--	3b.			Bib-Shorts
--	3c.			No
--	4a.			Classic Vest, S
--	4b.			ML Road Frame - Red, 48
--	5a.			Full-Finger Gloves, L
--	5b.			20
--  6.			45270
--  7.			49181
--NOTE: We are now using a different database. 
USE AdventureWorks2014;
--1.a.	List any products that have product reviews.  Show product name, product ID, comments, 
--		email address. Sort alphabetically on the product name. Don’t over complicate this. 
--		A correctly written INNER JOIN will return only those products that have product 
--		reviews; i.e., matching values in the linking field. Hint:  Use the Production.Product 
--		and Production.ProductReview tables.
--      4 points
--      I got 4 rows.
--		QUESTION:		What is the email address in the row 2?
--		YOUR ANSWER:	jill@margiestravel.com
--
SELECT [Production].[Product].[Name], [Production].[Product].[ProductID], [Production].[ProductReview].[Comments], [Production].[ProductReview].[EmailAddress]
FROM [Production].[Product]
INNER JOIN [Production].[ProductReview]
ON [Production].[Product].[ProductID] = [Production].[ProductReview].[ProductID]
ORDER BY [Production].[Product].[Name] ASC;
--1.b.	Copy 1.a. and paste below. Modify the pasted statement to show only records in which 
--		the word 'mountain' is found in the Comments field. Show product ID, product name, and comments. 
--		Sort on ProductID. 
--      2 points
--      I got 2 rows.
--		QUESTION:		What is the product id in the first row?
--		YOUR ANSWER:	798
--
SELECT [Production].[Product].[Name], [Production].[Product].[ProductID], [Production].[ProductReview].[Comments]
FROM [Production].[Product]
INNER JOIN [Production].[ProductReview]
ON [Production].[Product].[ProductID] = [Production].[ProductReview].[ProductID]
WHERE [Production].[ProductReview].[Comments] like '%mountain%'
ORDER BY [Production].[Product].[ProductID] ASC;
--2.a.	List product models with products. Show the product model ID, model name, product ID, 
--		product name, standard cost, and class. Round all money values to exactly two decimal places. 
--		Be sure to give any derived fields an alias. Sort by ProductID from lowest to highest.
--		Hint: You know you need to use the Product table. Now look for a related table that contains 
--		the information about the product model and inner join it to Product on the linking field.  
--      5 points
--      I got 295 rows.
--		QUESTION:		What is the Class in the first row?
--		YOUR ANSWER:	H
--
SELECT [Production].[ProductModel].[ProductModelID], [Production].[ProductModel].[Name] AS 'ModelName', [Production].[Product].[ProductID], [Production].[Product].[Name] AS 'ProductName',
ROUND([Production].[Product].[StandardCost],2) AS StandardCost, [Production].[Product].[Class]
FROM [Production].[Product]
INNER JOIN [Production].[ProductModel]  ON
[Production].[Product].[ProductModelID] = [Production].[ProductModel].[ProductModelID]
ORDER BY [Production].[Product].[ProductID] ASC;
--2.b.	Copy/paste 2.a. to 2.b. then modify 2.b. to list only products with a value in the  
--		class field. Do this using NULL appropriately in the WHERE clause. Hint: Remember 
--		that nothing is ever equal (on not equal) to NULL; it either is or it isn't NULL.
--      2 points
--      I got 229 rows.
--		QUESTION:		What is the standard cost in the last row?
--		YOUR ANSWER:	343.65
SELECT [Production].[ProductModel].[ProductModelID], [Production].[ProductModel].[Name] AS 'ModelName', [Production].[Product].[ProductID], [Production].[Product].[Name] AS 'ProductName',
ROUND([Production].[Product].[StandardCost],2) AS StandardCost, [Production].[Product].[Class]
FROM [Production].[Product]
INNER JOIN [Production].[ProductModel]  ON
[Production].[Product].[ProductModelID] = [Production].[ProductModel].[ProductModelID]
WHERE [Production].[Product].[Class] is not NULL
ORDER BY [Production].[Product].[ProductID] ASC;
--2.c.	Copy/paste 2.b. to 2.c. then modify 2.c. to list only products that contain a value in 
--		the class field AND contain 'frame' or 'fork' in the product model name. Be sure that NULL 
--		does not appear in the Class field by using parentheses appropriately.
--      2 points
--      I got 82 rows.
--		QUESTION:		What is the ProductID in the first row?
--		YOUR ANSWER:	680
SELECT [Production].[ProductModel].[ProductModelID], [Production].[ProductModel].[Name] AS 'ModelName', [Production].[Product].[ProductID], [Production].[Product].[Name] AS 'ProductName',
ROUND([Production].[Product].[StandardCost],2) AS StandardCost, [Production].[Product].[Class]
FROM [Production].[Product]
INNER JOIN [Production].[ProductModel]  ON
[Production].[Product].[ProductModelID] = [Production].[ProductModel].[ProductModelID]
WHERE [Production].[Product].[Class] is not NULL AND 
(lOWER([Production].[ProductModel].[Name]) LIKE '%frame%' OR
LOWER([Production].[ProductModel].[Name]) LIKE '%fork%')
ORDER BY [Production].[Product].[ProductID] ASC;
--3.a.	List Product categories, their subcategories and their products.  Show the category name, 
--		subcategory name, product ID, and product name, in this order. Sort in alphabetical order on 
---		category name, then subcategory name, and then product name. Give each Name field a descriptive 
--		alias. For example, the Name field in the Product table will have the alias ProductName. 
--		Hint:  To understand the relationships, create a database diagram with the following tables: 
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product
--      6 points
--      I got 295 rows.
--		QUESTION:		What is the product subcategory name in row 3?
--		YOUR ANSWER:	Bottles and Cages
SELECT [Production].[ProductCategory].[Name] AS 'CategoryName', [Production].[ProductSubcategory].[Name] AS 'SubCategory Name', [Production].[Product].[ProductID], [Production].[Product].[Name] AS 'Product Name'
FROM [Production].[Product]
INNER JOIN [Production].[ProductSubcategory] 
ON [Production].[Product].[ProductSubcategoryID] =  [Production].[ProductSubcategory].[ProductSubcategoryID]
INNER JOIN [Production].[ProductCategory]
ON [Production].[ProductSubcategory].[ProductCategoryID] = [Production].[ProductCategory].[ProductCategoryID]
ORDER BY [Production].[ProductCategory].[Name] ASC, [Production].[ProductSubcategory].[Name] ASC, [Production].[Product].[Name] ASC;
--3.b.	Copy 3.a. and paste below. Modify to list only Products in product category 3.  
--		Show the category name, subcategory name, product ID, and product name, in this order. 
--		Sort in alphabetical order on product name, then subcategory name, and then by category name. 
--		Hint: Add product category id field to SELECT clause, make sure your results are correct, then 
--		remove or comment out the field.  		
--      3 points
--      I got 35 rows.
--		QUESTION:		What is the product subcategory name in row 1?
--		YOUR ANSWER:	Bib-Shorts
SELECT [Production].[ProductCategory].[Name] AS 'CategoryName', [Production].[ProductSubcategory].[Name] AS 'SubCategory Name', [Production].[Product].[ProductID], [Production].[Product].[Name] AS 'Product Name'
FROM [Production].[Product]
INNER JOIN [Production].[ProductSubcategory] 
ON [Production].[Product].[ProductSubcategoryID] =  [Production].[ProductSubcategory].[ProductSubcategoryID]
INNER JOIN [Production].[ProductCategory]
ON [Production].[ProductSubcategory].[ProductCategoryID] = [Production].[ProductCategory].[ProductCategoryID]
WHERE [Production].[ProductSubcategory].[ProductCategoryID] = 3
ORDER BY [Production].[ProductCategory].[Name] ASC, [Production].[ProductSubcategory].[Name] ASC, [Production].[Product].[Name] ASC;
--3.c.	Copy 3.b. and paste below. Modify the pasted statement to list Products in product category 1. 
--		Make no other changes to the statement. 
--		Hint: Add product category id field to SELECT clause, make sure your results are correct, then 
--		remove or comment out the field.  Something to consider: Look at the data in the ProductName field. 
--      2 points
--      I got 97 rows.
--		QUESTION:		Could we find bikes by searching for 'bike' in the ProductName field?
--		YOUR ANSWER:	No
SELECT [Production].[ProductCategory].[Name] AS 'CategoryName', [Production].[ProductSubcategory].[Name] AS 'SubCategory Name', [Production].[Product].[ProductID], [Production].[Product].[Name] AS 'Product Name'
FROM [Production].[Product]
INNER JOIN [Production].[ProductSubcategory] 
ON [Production].[Product].[ProductSubcategoryID] =  [Production].[ProductSubcategory].[ProductSubcategoryID]
INNER JOIN [Production].[ProductCategory]
ON [Production].[ProductSubcategory].[ProductCategoryID] = [Production].[ProductCategory].[ProductCategoryID]
WHERE [Production].[ProductSubcategory].[ProductCategoryID] = 1
ORDER BY [Production].[ProductCategory].[Name] ASC, [Production].[ProductSubcategory].[Name] ASC, [Production].[Product].[Name] ASC;
--4.a.	List Product models, the categories, the subcategories, and the products.  Show the model name, 
--		category name, subcategory name, product ID, and product name in this order. Give each Name field a  
--		descriptive alias. For example, the Name field in the ProductModel table will have the alias ModelName. 
--		Sort in alphabetical order by model name. 
--		Hint:  To understand the relationships, refer to a database diagram and the following tables:
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product
--		Production.ProductModel
--		Choose a path from one table to the next and follow it in a logical order to create the inner joins.
--      5 points
--      I got 295 rows.
--		QUESTION:		What is the product name in the record 5?
--		YOUR ANSWER:	Classic Vest, S
SELECT [Production].[ProductModel].[Name] AS 'ModelName', [Production].[ProductCategory].[Name] AS 'Product Category',
[Production].[ProductSubcategory].[Name] 'Product SubCategory', 
[Production].[Product].[ProductID], [Production].[Product].[Name] AS ' Product Name'
FROM [Production].[ProductModel] 
INNER JOIN  [Production].[Product]
ON [Production].[ProductModel].[ProductModelID] = 
[Production].[Product].[ProductModelID]
INNER JOIN [Production].[ProductSubcategory]
ON [Production].[Product].[ProductSubcategoryID]
= [Production].[ProductSubcategory].[ProductSubcategoryID] 
INNER JOIN [Production].[ProductCategory]
ON [Production].[ProductSubcategory].[ProductCategoryID] =
[Production].[ProductCategory].[ProductCategoryID]  
ORDER BY [Production].[ProductModel].[Name] ASC;		
--4.b.	Copy 4.a. and paste below. Modify the pasted statement to list those products in model ID 16 that 
--		contain red in the product name. Modify the sort to order only on Product ID. Hint: Add the 
--		product model id field to the select clause to check your results and then remove or comment it out.
--      3 points
--      I got 5 rows.
--		QUESTION:		What is the product name in the record 2?
--		YOUR ANSWER:	ML Road Frame - Red, 48
SELECT [Production].[ProductModel].[Name] AS 'ModelName', [Production].[ProductCategory].[Name] AS 'Product Category',
[Production].[ProductSubcategory].[Name] 'Product SubCategory',
[Production].[Product].[ProductID], [Production].[Product].[Name] AS ' Product Name'
FROM [Production].[ProductModel] 
INNER JOIN  [Production].[Product]
ON [Production].[ProductModel].[ProductModelID] = 
[Production].[Product].[ProductModelID]
INNER JOIN [Production].[ProductSubcategory]
ON [Production].[Product].[ProductSubcategoryID]
= [Production].[ProductSubcategory].[ProductSubcategoryID] 
INNER JOIN [Production].[ProductCategory]
ON [Production].[ProductSubcategory].[ProductCategoryID] =
[Production].[ProductCategory].[ProductCategoryID]
WHERE [Production].[ProductModel].[ProductModelID] = 16 
ORDER BY [Production].[ProductModel].[Name] ASC;		
--5.a.	List products ordered by customer id 30067.  Show product name, product number, order quantity, 
--		and sales order id.  Sort on product name and sales order id.  If you add customer id to check your results, 
--		be sure to remove or comment it out. Hint:  First create a database diagram with the following tables: 
--		Production.Product
--		Sales.SalesOrderHeader
--		Sales.SalesOrderDetail
--      4 points
--      I got 220 rows.
--		QUESTION:		What is the product name in the third record?
--		YOUR ANSWER:	Full-Finger Gloves, L
SELECT [Production].[Product].[Name] AS 'ProductName',
[Production].[Product].[ProductNumber], 
[Sales].[SalesOrderDetail].[OrderQty],
[Sales].[SalesOrderHeader].[SalesOrderID]
FROM [Sales].[SalesOrderHeader]
INNER JOIN [Sales].[SalesOrderDetail]
ON [Sales].[SalesOrderHeader].[SalesOrderID] =
[Sales].[SalesOrderDetail].[SalesOrderID]
INNER JOIN [Production].[Product] ON
[Sales].[SalesOrderDetail].[ProductID] =
[Production].[Product].[ProductID]
WHERE [Sales].[SalesOrderHeader].[CustomerID] = 30067
ORDER BY [Production].[Product].[Name] ASC,
[Sales].[SalesOrderHeader].[SalesOrderID] ASC;
--5.b.  List the orders and the shipping method for customer id 30067. Show product name, product number, 
--		order quantity, sales order id, and the name of the shipping method. Sort on product name and sales 
--		order id. Hint:  You will need to join an additional table. Add it to your database diagram first. 
--      4 points
--      I got 220 rows.
--		QUESTION:		What is the order quantity in row 2? 
--		YOUR ANSWER:	20
SELECT [Production].[Product].[Name] AS 'ProductName',
[Production].[Product].[ProductNumber], 
[Sales].[SalesOrderDetail].[OrderQty],
[Sales].[SalesOrderHeader].[SalesOrderID],
[Purchasing].[ShipMethod].[Name] AS 'ShippingMethod'
FROM [Sales].[SalesOrderHeader]
INNER JOIN [Sales].[SalesOrderDetail]
ON [Sales].[SalesOrderHeader].[SalesOrderID] =
[Sales].[SalesOrderDetail].[SalesOrderID]
INNER JOIN [Purchasing].[ShipMethod] ON
[Sales].[SalesOrderHeader].ShipMethodID =
[Purchasing].[ShipMethod].[ShipMethodID]
INNER JOIN [Production].[Product] ON
[Sales].[SalesOrderDetail].[ProductID] =
[Production].[Product].[ProductID]
WHERE [Sales].[SalesOrderHeader].[CustomerID] = 30067
ORDER BY [Production].[Product].[Name] ASC,
[Sales].[SalesOrderHeader].[SalesOrderID] ASC;
--6.	List all sales for clothing that was ordered during 2012.  Show sales order id, product ID, 
--		product name, order quantity, and line total for each line item sale. Make certain you are retrieving 
--		only clothing. There are multiple ways to find clothing items. Sort the list by sales order id in ascending order. 
--      Hints: Create a database diagram before beginning the statement. Consider using the YEAR(date) function.
--      6 points
--      I got 4045 rows.
--		QUESTION:		What IS THE SalesOrderID in row 1?
--		YOUR ANSWER:	45270
SELECT [Sales].[SalesOrderHeader].[SalesOrderID],
[Production].[Product].[ProductID],
[Production].[Product].[Name] AS 'ProductName',
[Sales].[SalesOrderDetail].[OrderQty],
[Sales].[SalesOrderHeader].[TotalDue]
FROM [Sales].[SalesOrderHeader]
INNER JOIN [Sales].[SalesOrderDetail]
ON [Sales].[SalesOrderHeader].[SalesOrderID] =
[Sales].[SalesOrderDetail].[SalesOrderID]
INNER JOIN [Production].[Product] ON
[Sales].[SalesOrderDetail].[ProductID] =
[Production].[Product].[ProductID]
INNER JOIN [Production].[ProductSubcategory] ON
[Production].[Product].[ProductSubcategoryID] =
[Production].[ProductSubcategory].[ProductSubcategoryID]
INNER JOIN [Production].[ProductCategory] ON
[Production].[ProductSubcategory].[ProductCategoryID] =
[Production].[ProductCategory].[ProductCategoryID]
WHERE [Production].[ProductCategory].[Name] = 'Clothing' AND
YEAR([Sales].[SalesOrderHeader].[OrderDate])  = '2012'
ORDER BY [Sales].[SalesOrderHeader].[SalesOrderID] ASC;
/* You will see this last question appear in different forms in many assignments. You have had the opportunity to explore the data. Now, what would you like to know about it? You are required to use a concept that was introduced 
in the module. In this case, you are to create a statement that requires at least one inner join. */

--7.	In your own words, write a business question for AdventureWorks that you will try to answer with a SQL query. 
--		Then try to develop the SQL to answer the question using at least one INNER JOIN. 
--		Just show your question and as much SQL as you were able to figure out. 
--      2 points

--7.	List all sales that were ordered during 2013 in the Australia region with ground truck shipping method.  Show sales order id 
--		and sales order date. Sort the list by sales order date in ascending order. 
--      I got 12584 rows.
--		QUESTION:		What IS THE SalesOrderID in row 1?
--		YOUR ANSWER:	49181
SELECT [Sales].[SalesOrderHeader].[SalesOrderID], 
[Sales].[SalesOrderHeader].[OrderDate]
FROM [Sales].[SalesOrderHeader]
INNER JOIN [Purchasing].[ShipMethod] ON
[Sales].[SalesOrderHeader].[ShipMethodID] = [Purchasing].[ShipMethod].[ShipMethodID]
INNER JOIN [Sales].[SalesTerritory] ON
[Sales].[SalesTerritory].[TerritoryID] = [Sales].[SalesTerritory].[TerritoryID]
WHERE [Purchasing].[ShipMethod].ShipMethodID = 1 AND
[Sales].[SalesTerritory].[Name] like '%Australia%' AND
YEAR([Sales].[SalesOrderHeader].[OrderDate]) = 2013
ORDER BY [Sales].[SalesOrderHeader].[OrderDate] ASC;
