--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #8              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
--You are required to use OUTER JOINSs to solve each problem. Even if you know another method that will produce 
--the result, this module is practice in OUTER JOINs.

-- Submit your .sql file named with your last name, first name and assignment # (i.e. FreebergCarlAssignment8.sql). 
-- Submit your file to the instructor using through the course site. 

-- Ideas for consideration: Run the statement in stages: Write the SELECT and FROM clauses first and run the 
-- statement. Add the ORDER BY clause. Then add the WHERE clause; if it is a compound WHERE clause, add piece 
-- at a time. Remember that the order in which the joins are processed does make a difference with OUTER JOINs.
-- You will NOT use Cross-Joins, Full Outer Joins, or Unions in the required exercises. All are to be 
-- accomplished with outer joins or a combination of outer and inner joins using standard ANSI join syntax.

-- In OUTER JOINS, when checking for NULL values in the WHERE clause, use the joining field of the table where you
-- expect to see the NULLs. The joining field is what you used in the ON clause. 
-- For example:

--		LEFT OUTER JOIN [dbo].[DimOrganization] AS ORG
--		ON ORG.CurrencyKey = CURR.CurrencyKey
--	WHERE ORG.CurrencyKey IS NULL 
--
-- When there are multiple versions of a field, such as EnglishCountryRegionName, SpanishCountryRegionName, 
-- FrenchCountryRegionName, use the English version of the field. When asked to show 'only once', 'unique', 
-- or 'one time only', use the DISTINCT keyword. Recall that it is the row that is unique in the result set.  

-- If no sort order is specified, assume it is in ascending order. 
--------------------------------------------------------------------------------------------------------------------
-- Answer Summary:
-- Question		YOUR ANSWER
--	1.			EURO			
--	2.			Bahamian Dollar			
--  3.			Demo Event
--	4.			SO43700			
--	5.			Winnipeg			
--	6.			Gold Coast			
--	7.			Mountain Tire Sale						
--	8.			Road-650 Overstock			
--	9a.			Central Discount Store			
--	9b.			Extended Bike Sales		
--	9c.			11-29-11			
--	10.			Mountain-100 Clearance Sale		
--	11a.		Road-450 Red, 44
--  11b.		95.40	
--  12.		    35.994
-------------------------------------------------------------------------------------------------------------------
USE AdventureWorksDW2014; 
--1.	List the name of all currencies and the name of each organization that uses that currency. 
--		You will use an Outer Join to list the name of each currency in the Currency table regardless if 
--		it has a matching value in the Organization table. You will see NULL in many rows. Sort ascending on currency name. 
--      Hint: Use DimCurrency and DimOrganization. 
--      4 points
--      I got 115 rows
--		QUESTION:		What is the currency name in row 38?
--		YOUR ANSWER==>	EURO
SELECT dc.[CurrencyName], do.[OrganizationName]
FROM DBO.DimCurrency AS dc
LEFT OUTER JOIN [dbo].[DimOrganization] AS do
ON dc.[CurrencyKey] = do.[CurrencyKey]
ORDER BY dc.[CurrencyName] ASC
--2.	List the name of all currencies that are NOT used by any organization. In this situation 
--		we are using the statement from 1.a. and making a few modifications. We want to find the 
--		currencies that do not have a match in the common field in the Organization table. We do 
--		that by filtering for NULL in the matching field. Sort ascending on currency name. 
--      4 points
--		QUESTION:		What is the currency name in row 7?
--		YOUR ANSWER==>	Bahamian Dollar
SELECT dc.[CurrencyName], do.[OrganizationName]
FROM DBO.DimCurrency AS dc
LEFT OUTER JOIN [dbo].[DimOrganization] AS do
ON dc.[CurrencyKey] = do.[CurrencyKey]
WHERE  do.[OrganizationName] IS NULL 
ORDER BY dc.[CurrencyName] ASC
--3.	List the name of all Sales Reasons that have not been associated with a sale. Sort ascending on sales reason name. 
--		Hint:  Use DimSalesReason and FactInternetSalesReason.
--      4 points
--      I got 3 rows.
--		QUESTION:		What is the sales reason name in row 1?
--		YOUR ANSWER==>	Demo Event
SELECT dsr.[SalesReasonName]
FROM [dbo].[DimSalesReason] AS dsr
LEFT OUTER JOIN [dbo].[FactInternetSalesReason] AS fisr
ON dsr.[SalesReasonKey] = fisr.[SalesReasonKey]
WHERE fisr.[SalesOrderNumber] IS NULL
ORDER BY dsr.[SalesReasonName]
--4.	List all internet sales that do not have a sales reason associated. List SalesOrderNumber, SalesOrderLineNumber 
--		and the order date. Do not show the time with the order date. Sort by sales order number ascending 
--      and sales order line number ascending. 
--		Now we are looking at which sales do not have a reason associated with the sale. Since we are looking at the sales, 
--		we don't need the reason name and the corresponding link to that table. 
--		Hint: Use FactInternetSales and FactInternetSalesReason. 
--      4 points
--      I got 6429 rows.
--		QUESTION:		What is the sales order number in row 3?
--		YOUR ANSWER==>	SO43700
SELECT fis.[SalesOrderNumber], fis.[SalesOrderLineNumber], CAST(fis.[OrderDate] AS DATE) AS 'OrderDate'
FROM [dbo].[FactInternetSales] AS fis
LEFT OUTER JOIN [dbo].[FactInternetSalesReason] AS fisr
ON  fis.[SalesOrderNumber] = fisr.[SalesOrderNumber]
WHERE fisr.[SalesReasonKey] IS NULL
ORDER BY fis.[SalesOrderNumber] ASC, fis.[SalesOrderLineNumber] ASC
/* AdventureWorks is looking to expand its market share. AdventureWorks has a list of target locations stored 
in the Geography table. In the next set of questions you want to find locations in which there are no Internet 
customers (individuals) and no business customers (resellers).  */

--5.	Find any locations in which AdventureWorks has no internet customers. List the English country/region 
--		name, state/province, city, and postal code. List each location only one time. Sort by country, state, 
--		and city.
--      4 points
--      I got 319 rows.
--		QUESTION:		What is the city in row 11?
--		YOUR ANSWER==>	Winnipeg
SELECT DISTINCT dg.[EnglishCountryRegionName], dg.[StateProvinceName], dg.[City], dg.[PostalCode]
FROM [dbo].[DimGeography] AS dg
LEFT OUTER JOIN [dbo].[DimCustomer] AS dc
ON dg.[GeographyKey] = dc.[GeographyKey]
WHERE dc.[CustomerKey] IS NULL
ORDER BY dg.[EnglishCountryRegionName] ASC, dg.[StateProvinceName] ASC, dg.[City] ASC
--6. 	Find any locations in which AdventureWorks has no resellers. List the English country/region 
--		name, state/province, city, and postal code. List each location only one time. Sort by country, 
--		state, and city.
--      4 points
--      I got 145 rows.
--		QUESTION:		What is the city in row 7?
--		YOUR ANSWER==>	Gold Coast
SELECT DISTINCT dg.[EnglishCountryRegionName], dg.[StateProvinceName], dg.[City], dg.[PostalCode]
FROM [dbo].[DimGeography] AS dg
LEFT OUTER JOIN [dbo].[DimReseller] AS dr
ON dg.[GeographyKey] = dr.[GeographyKey]
WHERE dr.[ResellerKey] IS NULL
ORDER BY dg.[EnglishCountryRegionName] ASC, dg.[StateProvinceName] ASC, dg.[City] ASC
--7.	List all promotions that have not been associated with a reseller sale. Show only the English 
--		promotion name in alphabetical order. 
--		Hint: Recall that details about sales to resellers are recorded in the FactResellerSales table.
--      4 points
--      I got 4 rows.
--		QUESTION:		What is the promotion in row 3?
--		YOUR ANSWER==>	Mountain Tire Sale
SELECT dp.[EnglishPromotionName]
FROM [dbo].[DimPromotion] AS dp
LEFT OUTER JOIN  [dbo].[FactResellerSales] AS frs
ON dp.[PromotionKey] = frs.[PromotionKey]
WHERE  frs.[ResellerKey] IS NULL
ORDER BY dp.[EnglishPromotionName] ASC
--8.	List all promotions that have not been associated with an Internet sale. Show only the 
--		English promotion name in alphabetical order. 
--		Hint: Recall that details about sales to customers are recorded in the FactInternetSales table.
--      4 points
--      I got 12 rows.
--		QUESTION:		What is the promotion in row 6?
--		YOUR ANSWER==>	Road-650 Overstock
SELECT dp.[EnglishPromotionName]
FROM [dbo].[DimPromotion] AS dp
LEFT OUTER JOIN  [dbo].[FactInternetSales] AS fis
ON dp.[PromotionKey] = fis.[PromotionKey]
WHERE fis.[SalesOrderNumber]  IS NULL
ORDER BY dp.[EnglishPromotionName] ASC 
--		Read 9.a. and 9.b. before beginning the syntax. There are several ways to write this statement. 
--		One method is to refer to the Outer Joins Demo and look at the example where a query is used in place 
--		of table for one possible method of answering these two questions. Another way is to write a series of 
--		outer!!! joins. You will need three tables to create the lists requested. 

--9.a.	Find all promotions and any related sales to resellers. List unique instances of the 
--		English promotion name, reseller name, and the order date.
--		Sort by the promotion name and reseller name in alphabetical order. 
--      Be sure to list all promotions even if there is no related sale.
--      4 points
--      I got 5174 rows.
--		QUESTION:		What is the reseller name in row 4?
--		YOUR ANSWER==>	Central Discount Store
SELECT DISTINCT dp.[EnglishPromotionName], dr.[ResellerName], CONVERT(NVARCHAR,frs.[OrderDate],101) AS 'OrderDate'
FROM [dbo].[DimPromotion] AS dp
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dp.[PromotionKey] = frs.[PromotionKey]
LEFT OUTER JOIN [dbo].[DimReseller] AS dr
ON frs.[ResellerKey] = dr.[ResellerKey]
ORDER BY dp.[EnglishPromotionName] ASC, dr.[ResellerName] ASC
--9.b.	Copy, paste, and modify 9.a. "No Discount" is not a promotion, so eliminate those sales 
--		without a promotion from your results set. Show the OrderDate as mm/dd/yyyy (CONVERT(nvarchar,OrderDate,101)). 
--      2 points
--      I got 1408 rows.
--		QUESTION:		What is the reseller name in row 7?
--		YOUR ANSWER==>	Extended Bike Sales
SELECT DISTINCT dp.[EnglishPromotionName], dr.[ResellerName], CONVERT(NVARCHAR,frs.[OrderDate],101) AS 'OrderDate'
FROM [dbo].[DimPromotion] AS dp
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dp.[PromotionKey] = frs.[PromotionKey]
LEFT OUTER JOIN [dbo].[DimReseller] AS dr
ON frs.[ResellerKey] = dr.[ResellerKey]
WHERE dp.[EnglishPromotionName] <> 'No Discount'
ORDER BY dp.[EnglishPromotionName] ASC, dr.[ResellerName] ASC
--9.c.	(Bonus +5) In 9b. You used CONVERT(nvarchar,OrderDate,101) to change a date field to mm/dd/yyyy.
--		Use Microsoft Books Online (you should be able to access it via SSMS Help). Find the CONVERT style code 
--		for a date format of mm-dd-yy. Copy and paste your 9b answer and change the style code.
--      Bonus 5 points
--      I got 1408 rows.
--		QUESTION:		What is the date in row 4?
--		YOUR ANSWER==>	11-29-11
SELECT DISTINCT dp.[EnglishPromotionName], dr.[ResellerName], CONVERT(NVARCHAR,frs.[OrderDate],10) AS 'OrderDate'
FROM [dbo].[DimPromotion] AS dp
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dp.[PromotionKey] = frs.[PromotionKey]
LEFT OUTER JOIN [dbo].[DimReseller] AS dr
ON frs.[ResellerKey] = dr.[ResellerKey]
WHERE dp.[EnglishPromotionName] <> 'No Discount'
ORDER BY dp.[EnglishPromotionName] ASC, dr.[ResellerName] ASC
--10.	Find all promotions and any related customer sales over the Internet. List unique instances 
--		of the English promotion name, customer first name, customer last name, and the order date. Eliminate 
--		sales that show No Discount. Sort by the promotion name. Be sure to list all promotions even if there 
--		is no related sale. Show the OrderDate as mm/dd/yyyy. You just did this in 9b. Now you are investigating 
--		Internet customers. Use similar syntax and different tables. 
--      4 points
--      I got 2120 rows.
--		QUESTION:		What is the promotion name in row 1?
--		YOUR ANSWER==>	Mountain-100 Clearance Sale
SELECT DISTINCT dp.[EnglishPromotionName], [FirstName], [LastName], CONVERT(VARCHAR,[OrderDate],101) AS 'OrderDate'
FROM [dbo].[DimPromotion] AS dp
LEFT OUTER JOIN [dbo].[FactInternetSales] AS fis
ON dp.[PromotionKey] = fis.[PromotionKey]
LEFT OUTER JOIN  [dbo].[DimCustomer] AS dc
ON fis.[CustomerKey] = dc.[CustomerKey]
WHERE dp.[EnglishPromotionName] <> 'No Discount'
/* AdventureWorks wants to know if there are any particular bikes that are not selling. It is important that we 
look at both types of buyers (individual and reseller) to see if there are bikes that should be promoted or 
discontinued. We will look at each type separately. You will need four tables to create the lists requested. */

--11.a.	List the product category name, product subcategory name, class, product name, and list price for all bikes that have NOT 
--		been purchased by individual customers over the Internet. Sort by category name, subcategory name and product name. 
--      4 points
--      I got 9 rows.
--		QUESTION:		What is the product name in row 5?
--		YOUR ANSWER==>	Road-450 Red, 44
SELECT dpc.[EnglishProductCategoryName], dpsc.[EnglishProductSubcategoryName], dp.[Class], dp.[EnglishProductName], dp.[ListPrice]
FROM [dbo].[DimProduct] AS dp
LEFT OUTER JOIN [dbo].[DimProductSubcategory] AS dpsc
ON dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey] 
LEFT OUTER JOIN [dbo].[DimProductCategory] AS dpc
ON dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
LEFT OUTER JOIN [dbo].[FactInternetSales] AS fis
ON dp.[ProductKey] = fis.[ProductKey]
WHERE [EnglishProductCategoryName] = 'Bikes' AND [SalesOrderNumber] IS NULL
ORDER BY dpc.[EnglishProductCategoryName] ASC, dpsc.[EnglishProductSubcategoryName] ASC, dp.[EnglishProductName] ASC
--11.b.	List the product category name,product subcategory name, class, product name, 
--		and dealer price (!!!different from last question)
--		for all Accessories (!!!different from last question) that have not been purchased by resellers. 
--		Sort by category name, subcategory name and product name. 
--      2 points
--      I got 19 rows.
--		QUESTION:		What is the dealer price in row 1?
--		YOUR ANSWER==>	95.40
SELECT dpc.[EnglishProductCategoryName], dpsc.[EnglishProductSubcategoryName], dp.[Class], dp.[EnglishProductName], dp.[DealerPrice]
FROM [dbo].[DimProduct] AS dp
LEFT OUTER JOIN [dbo].[DimProductSubcategory] AS dpsc
ON dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey] 
LEFT OUTER JOIN [dbo].[DimProductCategory] AS dpc
ON dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
LEFT OUTER JOIN [dbo].[FactResellerSales] AS fss
ON dp.[ProductKey] = fss.[ProductKey]
WHERE dpc.[EnglishProductCategoryName] = 'Accessories' AND fss.[SalesOrderNumber] IS NULL
ORDER BY dpc.[EnglishProductCategoryName] ASC, dpsc.[EnglishProductSubcategoryName] ASC, dp.[EnglishProductName] ASC



--12.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an outer join.
--		Then write the SQL query that will provide the information that you are seeking.
--      2 points
--  	List the product category name,product subcategory name, product name, 
--		and dealer price for all Clothing  that have not been purchased by resellers. 
--		Sort by category name, subcategory name and product name. 
--      I got 5 rows.
--		QUESTION:		What is the dealer price in row 5?
--		YOUR ANSWER==>	35.994

SELECT dpc.[EnglishProductCategoryName], dpsc.[EnglishProductSubcategoryName], dp.[EnglishProductName], dp.[DealerPrice]
FROM [dbo].[DimProduct] AS dp
LEFT OUTER JOIN [dbo].[DimProductSubcategory] AS dpsc
ON dp.[ProductSubcategoryKey] = dpsc.[ProductSubcategoryKey] 
LEFT OUTER JOIN [dbo].[DimProductCategory] AS dpc
ON dpsc.[ProductCategoryKey] = dpc.[ProductCategoryKey]
LEFT OUTER JOIN [dbo].[FactResellerSales] AS fss
ON dp.[ProductKey] = fss.[ProductKey]
WHERE [EnglishProductCategoryName] = 'Clothing' AND [SalesOrderNumber] IS NULL
ORDER BY dpc.[EnglishProductCategoryName] ASC, dpsc.[EnglishProductSubcategoryName] ASC, dp.[EnglishProductName] ASC


