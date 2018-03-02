--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #7              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
--You are required to use INNER JOINs to solve each problem. Even if you know another method that will produce 
--the result, this module is practice in INNER JOINs.

-- Submit your .sql file named with your last name, first name and assignment # (e.g., FreebergCarlAssignment7.sql). 
-- Submit your file to the instructor using through the course site. 
--
-- REMINDERS: Run the statement in stages-- Write the SELECT and FROM clauses first and run 
-- the statement. Add the ORDER BY clause. Then add the WHERE clause; if it is a compound WHERE clause, 
-- add a piece at a time. Lastly perform the CAST or CONVERT. When the statement is created in steps, it 
-- is easier to isolate any errors. 

-- When there are multiple versions of a field, such as EnglishCountryRegionName, SpanishCountryRegionName, 
-- FrenchCountryRegionName, use the English version of the field. When asked to show 'only once', 'unique', 
-- or 'one time only', use the DISTINCT keyword. Recall that it is the row that is unique in the result set.  

-- 'Customers' generally refers only to individuals that purchase over the Internet and are stored in the 
-- DimCustomers table. For example, if the request is for customers in the UK city of York, be sure to include 
-- the UK portion of the filter. The city of York exists in other countries.

-- If no sort order is specified, assume it is in ascending order. 

--------------------------------------------------------------------------------------------------------------------
-- Answer Summary:
-- Question		YOUR ANSWER
--	1a.			Brandi			
--	1b.			Kyle			
--  1c.			Sebastian
--	2a.			225			
--	2b.			606			
--	2c.			504			
--	2d.			Hitch Rack - 4-Bike						
--	3a.			486			
--	3b.			Bike Wash - Dissolver		
--	4.			Classic Vest, S			
--	5a.			Hunter		
--	5b.		    6852
--  5c.			There are customers with same first and last name that purchase clothing items with different customerkey.
--  6.		    Patch Kit/8 Patches
--  7.			Fender Set - Mountain
--  8.			Sport-100 Helmet, Black
-------------------------------------------------------------------------------------------------------------------
--NOTE: We are now using a different database. 
USE AdventureWorksDW2014; 
--1.a.	List the names and locations of AdventureWorks customers who identify as female (Gender field). 
--		Show customer key, first name, last name, state name, and country name. Order the list 
--		by country name, state name, last name, and first name in alphabetical order. 
--      4 points
--		QUESTION:		What is the first name in record 3?
--		YOUR ANSWER==>	Brandi
--
SELECT c.[CustomerKey], c.[FirstName],  c.[LastName], g.[StateProvinceName], g.[EnglishCountryRegionName]
FROM [dbo].[DimCustomer] AS c
INNER JOIN [dbo].[DimGeography] AS g ON
c.[GeographyKey] = g.[GeographyKey]
WHERE c.[Gender]= 'F'
ORDER BY g.[EnglishCountryRegionName] ASC, g.[StateProvinceName] ASC, c.[LastName] ASC, c.[FirstName] ASC;
--1.b.	Copy/paste the statement from 1.a to 1.b. Modify the WHERE clause in 1.b to show only 
--		those AdventureWorks customers who identify as  male and from the US City of Kirkland. 
--		Show customer key, first name, last name, and city name. 
--		Change the sort order to list by last name, then first name in alphabetical order. 
--      2 points
--      I got 46 rows
--		QUESTION:		What is the first name in record 3?
--		YOUR ANSWER==>	Kyle
SELECT c.[CustomerKey], c.[FirstName],  c.[LastName], g.[City]
FROM [dbo].[DimCustomer] AS c
INNER JOIN [dbo].[DimGeography] AS g ON
c.[GeographyKey] = g.[GeographyKey]
WHERE c.[Gender]= 'M' and g.City = 'Kirkland'
ORDER BY  c.[LastName] ASC, c.[FirstName] ASC;
--1.c.	Copy/paste statement from 1.b to 1.c. Modify the WHERE clause in 1.c to list only 
--		AdventureWorks customers from the US city of Seattle who identify as male and have 1 or more cars. 
--		Show customer key, first name, last name, and total number of cars. 
--		Order the list by number of cars in descending order, then by last name and first name 
--		in alphabetical order.
--      2 points
--      I got 39 rows
--		QUESTION:		What is the first name in record 3?
--		YOUR ANSWER==>	Sebastian
SELECT c.[CustomerKey], c.[FirstName],  c.[LastName], c.[NumberCarsOwned]
FROM [dbo].[DimCustomer] AS c
INNER JOIN [dbo].[DimGeography] AS g ON
c.[GeographyKey] = g.[GeographyKey]
WHERE c.[Gender]= 'M' and g.City = 'Seattle' and c.[NumberCarsOwned] > 0
ORDER BY  c.[NumberCarsOwned] DESC, c.[LastName] ASC, c.[FirstName] ASC;
--2.a.	Explore the data warehouse using only the DimProduct table. No joins are required. 
--		Show the English product name, product key, product alternate key, standard cost, list price, 
--		and status. Sort on English product name. Notice that some of the products appear to be duplicates. 
--		The name and the alternate key remain the same but the product is added again with a new product 
--		key to track the history of changes to the product attributes. For example, look at AWC Logo Cap. 
--		Notice the history of changes to StandardCost and ListPrice and to the value in the Status field. 
--      2 points
--      I got 606 rows
--		QUESTION:		What is the ProductKey for the AWC Logo Cap that is currently being sold?
--		YOUR ANSWER==>	225
SELECT [EnglishProductName], [ProductKey], [ProductAlternateKey], [StandardCost], [ListPrice], [Status]
FROM [dbo].[DimProduct]
ORDER BY [EnglishProductName] ASC;
--2.b.  Using the DimProduct table, list the product key, English product name, and product alternate key 
--      for each product only once. Sort on English product name.  
--      1 point
--		QUESTION:		How many rows did your query return?
--		YOUR ANSWER==>	606
SELECT DISTINCT [ProductKey], [EnglishProductName], [ProductAlternateKey]
FROM [dbo].[DimProduct]
GROUP BY [ProductKey], [EnglishProductName], [ProductAlternateKey]
ORDER BY [EnglishProductName] ASC;
--2.c.  Using the DimProduct table, list the English product name and product alternate key for each product only once. 
--      Sort on English product name. Recall terms like “only once”, “one time”, and "unique" all indicate the need for the DISTINCT keyword. 
--      1 point
--		QUESTION:		How many rows did your query return?
--		YOUR ANSWER==>	504
SELECT DISTINCT [EnglishProductName], [ProductAlternateKey]
FROM [dbo].[DimProduct]
GROUP BY  [EnglishProductName], [ProductAlternateKey]
ORDER BY [EnglishProductName] ASC;
--2.d.	Join tables to the product table to also show the category and subcategory name for each product. 
--		Show the English category name, English subcategory name, English product name, and product alternate key 
--		only once. Sort the results by the English category name, English subcategory name, and English product 
--		name. 
--      I got 295 rows
--      4 points
--		QUESTION:		English product name in record 1?
--		YOUR ANSWER==>	Hitch Rack - 4-Bike
SELECT DISTINCT [EnglishProductCategoryName], [EnglishProductSubcategoryName], [EnglishProductName], [ProductAlternateKey]
FROM [dbo].[DimProduct] as p
INNER JOIN [dbo].[DimProductSubcategory] AS ps ON
p.[ProductSubcategoryKey] = ps.[ProductSubcategoryKey]
INNER JOIN [dbo].[DimProductCategory] AS pc ON
ps.[ProductCategoryKey] = pc.[ProductCategoryKey]
GROUP BY [EnglishProductCategoryName], [EnglishProductSubcategoryName], [EnglishProductName], [ProductAlternateKey]
ORDER BY [EnglishProductCategoryName] ASC, [EnglishProductSubcategoryName] ASC, [EnglishProductName] ASC;
--3.a.	List the English name for products purchased over the Internet by customers who indicate education  
--		as high school or partial high school. Show Product key and English Product Name and English Education. 
--		Order the list by English Product name. Show a product only once for each education level 
--      even if it has been purchased several times. Hint 1: SELECT DISTINCT
--      Hint 2: Use FactInternetSales, DimCustomer, DimProduct tables.
--      5 points
--      I got 310 rows
--		QUESTION:		What is the ProductKey in row 1?
--		YOUR ANSWER==>	486
SELECT DISTINCT dp.[ProductKey], dp.[EnglishProductName], dc.[EnglishEducation]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimCustomer] AS dc ON
fis.[CustomerKey] = dc.[CustomerKey]
WHERE dc.[EnglishEducation] in ('High School','Partial High School')
ORDER BY dp.[EnglishProductName] ASC;
--3.b.	List the English name for products purchased over the Internet by customers who indicate 
--		partial high school or partial college. Show Product key and English Product Name 
--		and English Education. Order the list by English Product name and then by English Education. 
--		Show a product only once for each education level even if it has been purchased several times. 
--      3 points
--      I got 311 rows
--		QUESTION:		What is the English product name in row 5?
--		YOUR ANSWER==>	Bike Wash - Dissolver
SELECT DISTINCT dp.[ProductKey], dp.[EnglishProductName], dc.[EnglishEducation]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimCustomer] AS dc ON
fis.[CustomerKey] = dc.[CustomerKey]
WHERE dc.[EnglishEducation] in ('Partial College','Partial High School')
ORDER BY dp.[EnglishProductName] ASC, dc.[EnglishEducation] ASC;
--4.	List the English name for products purchased over the Internet by customers who list their occupation as 
--      professional or management.. Show Product key and English Product Name and English Occupation. 
--		Sort by English product name and occupation in alphabetical order. 
--      Show a product only once for each occupation even if it has been purchased several times.
--      5 points
--      I got 314 rows
--		QUESTION:		What is the English product name in row 12?
--		YOUR ANSWER==>	Classic Vest, S
SELECT DISTINCT dp.[ProductKey], dp.[EnglishProductName], dc.[EnglishOccupation]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimCustomer] AS dc ON
fis.[CustomerKey] = dc.[CustomerKey]
WHERE dc.[EnglishOccupation] in ('Professional','Management')
ORDER BY dp.[EnglishProductName] ASC, dc.[EnglishOccupation] ASC;

/******************************************************************************************************************
Question 5 contains exploratory questions. You may wish to read all three questions before beginning. 
Seeing the purpose of the questions may help understand the requests. 
*******************************************************************************************************************/
--5.a.	List customers who have purchased clothing over the Internet.  Show customer first name, 
--		last name, and English product category. If a customer has purchased clothing items more than once, 
--		show only one row for that customer. 
--      Order the list by last name, then first name. Did you return 6,839 records in your results set?
--      6 points
--      I got 6839 rows
--		QUESTION:		What is first name in row 10?
--		YOUR ANSWER==>	Hunter
SELECT DISTINCT dc.[FirstName], dc.[LastName], dpc.[EnglishProductCategoryName]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimProductSubcategory] as dpsc ON
dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
INNER JOIN [dbo].[DimProductCategory] AS dpc ON
dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
INNER JOIN [dbo].[DimCustomer] AS dc ON
fis.[CustomerKey] = dc.[CustomerKey]
WHERE dpc.[EnglishProductCategoryName] = 'Clothing'
ORDER BY dc.[LastName] ASC, dc.[FirstName] ASC;
--5.b.	Copy/paste 5.a to 5.b and modify 5.b.  Show customer key, first name, last name, and English 
--		product category. If a customer has purchased clothing more than once, show only one row for that customer. 
--		Order the list by last name, then first name. 
--      2 points
--		QUESTION:		How many rows did you get?
--		YOUR ANSWER==>	6852
SELECT DISTINCT dc.[CustomerKey], dc.[FirstName], dc.[LastName], dpc.[EnglishProductCategoryName]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimProductSubcategory] as dpsc ON
dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
INNER JOIN [dbo].[DimProductCategory] AS dpc ON
dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
INNER JOIN [dbo].[DimCustomer] AS dc ON
fis.[CustomerKey] = dc.[CustomerKey]
WHERE dpc.[EnglishProductCategoryName] = 'Clothing'
ORDER BY dc.[LastName] ASC, dc.[FirstName] ASC;
--5.c.	Be brief and specific. This is actually a simple answer. 
--      2 bonus points
--		QUESTION==>		Why is there a difference between the number of records received in 5a and 5b?
--                      Be brief and specific. This is actually a simple answer. 
--		YOUR ANSWER:	There are customers with same first and last name that purchase clothing items with different customerkey.

--6.	List all Internet sales for accessories that occurred during 2013 (Order Date in 2013). 
--		Show Order date, product key, product name, and sales amount for each line item sale. 
--		Show the date as mm/dd/yyyy as DateOfOrder. Show the list in oldest to newest order by date 
--      and alphabetically by product name.
--      Hint: For the date, use the syntax similar to CONVERT(nvarchar, date, style code). 
--      Look up the appropriate style code.  
--      6 points
--      I got 34409 rows
--		QUESTION:		What is the product name in record 8?
--		YOUR ANSWER==>	Patch Kit/8 Patches
SELECT convert(varchar(10), cast(fis.[OrderDate] AS date),101) AS 'OrderDate' , dp.[ProductKey], dp.[EnglishProductName], fis.[SalesAmount]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimProductSubcategory] as dpsc ON
dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
INNER JOIN [dbo].[DimProductCategory] AS dpc ON
dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
WHERE dpc.[EnglishProductCategoryName] = 'Accessories' AND YEAR(fis.[OrderDate]) = '2013'
ORDER BY [OrderDate] ASC,dp.[EnglishProductName]  ASC;
--7.	List all Internet sales of Accessories to customers in Metz, France during 2013. 
--		Show product key, product name, order date as mm/dd/yyyy, SalesAmount, and City for each line item sale. 
--		Show the list by date in ascending order and product key in ascending order. 
--      5 points
--      I got 113 rows
--		QUESTION:		What is the product name in record 3?
--		YOUR ANSWER==>	Fender Set - Mountain
SELECT DISTINCT dp.[ProductKey], dp.[EnglishProductName], convert(varchar(10), cast(fis.[OrderDate] AS date),101) AS 'OrderDate', fis.[SalesAmount], dg.[City]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimCustomer] AS dc ON
fis.[CustomerKey] = dc.[CustomerKey]
INNER JOIN [dbo].[DimGeography] AS dg ON
dc.[GeographyKey] = dg.[GeographyKey]
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimProductSubcategory] as dpsc ON
dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
INNER JOIN [dbo].[DimProductCategory] AS dpc ON
dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
WHERE dpc.[EnglishProductCategoryName] = 'Accessories' AND YEAR(fis.[OrderDate]) = '2013' AND dg.[CountryRegionCode] = 'FR' AND dg.[City] = 'Metz'
ORDER BY [OrderDate] ASC, dp.[ProductKey]  ASC;
--8.	In your own words, write a business question that you can answer by querying the data warehouse. 
--		Then write the SQL query using at least one INNER JOIN that will provide the information that you are 
--		seeking. Try it. You get credit for writing a question and trying to answer it. 
--      2 points

--8.	List all Internet sales of Accessories to customers in Seattle, WA during 2014. 
--		Show product key, product name, order date as mm/dd/yyyy, SalesAmount, and City for each line item sale. 
--		Show the list by date in ascending order and product key in ascending order. 
--      5 points
--      I got 113 rows
--		QUESTION:		What is the product name in record 3?
--		YOUR ANSWER==>	Sport-100 Helmet, Black
SELECT DISTINCT dp.[ProductKey], dp.[EnglishProductName], convert(varchar(10), cast(fis.[OrderDate] AS date),101) AS 'OrderDate', fis.[SalesAmount], dg.[City]
FROM [dbo].[FactInternetSales] AS fis
INNER JOIN [dbo].[DimCustomer] AS dc ON
fis.[CustomerKey] = dc.[CustomerKey]
INNER JOIN [dbo].[DimGeography] AS dg ON
dc.[GeographyKey] = dg.[GeographyKey]
INNER JOIN [dbo].[DimProduct] AS dp ON
fis.[ProductKey] = dp.[ProductKey]
INNER JOIN [dbo].[DimProductSubcategory] as dpsc ON
dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey]
INNER JOIN [dbo].[DimProductCategory] AS dpc ON
dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
WHERE dpc.[EnglishProductCategoryName] = 'Accessories' AND YEAR(fis.[OrderDate]) = '2014' AND dg.[StateProvinceCode] = 'WA' AND dg.[City] = 'Seattle'
ORDER BY [OrderDate] ASC, dp.[ProductKey]  ASC;
