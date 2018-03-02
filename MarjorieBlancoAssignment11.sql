--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #11                 DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
-- Submit your .sql file named with your last name, first name and assignment # (e.g., FreebergAssignment11.sql). 
-- Submit your file to the instructor using through the course site.  
--
-- Answer Summary:
-- Question		Points		YOUR ANSWER
--	1a.			2			0
--	1b.			4			114
--	1c.			4			Bellevue
--	2a.			2			0
--	2b.			2			101
--	2c.			2			19
--	2d.			2			76
--	2e.			4			62815.126
--	3a.			3			Bike Universe
--	3b.			4			Brakes and Gears
--	3c.			3			853849.18
--	3d.			5			Futuristic Sport Distributors
--	4a.			2			5064
--	4b.			3			64395.07
--	5.			6			Caitlin C Morgan
--	6.			2			Vigorous Exercise Company

USE AdventureWorksDW2014;


-- 1.	AdventureWorks management wants geographic information about their resellers. 
--		Be sure to add a meaningful sort as appropriate and give each derived column an alias.

-- 1.a.	First check to determine if there are resellers without geography info.
--      2 points
--		QUESTION:	How many resellers are there with no geography info?	
--		YOUR ANSWER==> 0
SELECT *
FROM [dbo].[DimReseller]
WHERE [GeographyKey] = NULL;
-- 1b.	Display a count of resellers in each country.
--		Show country name and the count of resellers. Sort by country name in ascending order.
--      4 points
--		I got 6 rows
--		QUESTION:	How many resellers are there in the record 2?	
--		YOUR ANSWER==> 114
SELECT [CountryRegionCode], COUNT(*) AS 'Resellers Count'
FROM [dbo].[DimReseller] AS dr
INNER JOIN [dbo].[DimGeography] AS dg
ON dr.[GeographyKey] = dg.[GeographyKey]
GROUP BY [CountryRegionCode]
ORDER BY [CountryRegionCode] ASC;
-- 1c.	Display a count of resellers in each City. 
--		Show count of resellers, City name, State name, and Country name. Sort by City name in ascending order.
--      4 points
--		I got 468 rows
--		QUESTION:	What is the city name in record 26?	
--		YOUR ANSWER==>	Bellevue
SELECT COUNT(*) AS 'Resellers Count',[City], [StateProvinceName], [StateProvinceName]
FROM [dbo].[DimReseller] AS dr
INNER JOIN [dbo].[DimGeography] AS dg
ON dr.[GeographyKey] = dg.[GeographyKey]
GROUP BY [City], [StateProvinceName], [StateProvinceName]
ORDER BY [City] ASC;
-- 2a. 	Check to see if there are any resellers without a value in the bank name field. 
--      2 points
--		QUESTION:	How many resellers are without a value in the bank name field?
--		YOUR ANSWER==> 0
SELECT *
FROM [dbo].[DimReseller]
WHERE [BankName] = NULL;
-- 2b.	List the name of each bank and the number of resellers using that bank.
--		Sort by bank name in ascending order. 
--      2 points
--      I got 7 rows
--		QUESTION:	How many resellers use the bank identified in record 1?	
--		YOUR ANSWER==> 101
SELECT [BankName], COUNT(*) AS 'Resellers Count'
FROM [dbo].[DimReseller]
GROUP BY [BankName]
ORDER BY [BankName] ASC;
--2c.	List the year opened and the number of resellers opening in that year. 
--      2 points
--      I got 32 rows
--		QUESTION:	How many resellers opened in 1976?
--		YOUR ANSWER==>  19
SELECT [YearOpened], COUNT(*) AS 'Resellers Count'
FROM [dbo].[DimReseller]
GROUP BY [YearOpened];
-- 2d.	List the average number of employees in each of the three business types. Sort by business type in ascending order.
--      2 points
--      I got 3 rows
--		QUESTION:	What is the Business Type in record 3?
--		YOUR ANSWER==> 76
SELECT [BusinessType], AVG([NumberEmployees]) AS 'Average Employees'
FROM [dbo].[DimReseller]
GROUP BY [BusinessType]
ORDER BY [BusinessType] ASC;
-- 2e.	List business type, the count of resellers in that type, and average of Annual Revenue 
--		in that business type. Sort by business type in ascending order.
--      4 points
--      I got 3 rows
--		QUESTION:	What is the average average annual revenue in record 2?
--		YOUR ANSWER==> 62815.126
SELECT [BusinessType],COUNT([BusinessType]) AS 'Resellers Count', AVG([AnnualRevenue]) AS 'Average Annual Revenue'
FROM [dbo].[DimReseller]
GROUP BY [BusinessType]
ORDER BY [BusinessType] ASC;
-- 3.	AdventureWorks wants information about sales to its resellers. Remember that Annual Revenue 
--		is a measure of the size of the business and is NOT the total of the AdventureWorks 
--		products sold to the reseller. Be sure to use SalesAmount when total sales are 
--		requested.

-- 3a. 	List the name of ANY reseller to which AdventureWorks has not sold a product. Sort by reseller name in ascending order.
--		Hint: Use a join.
--      3 points
--      I got 66 rows
--		QUESTION:	What is the name of the reseller in record 4?	
--		YOUR ANSWER==> Bike Universe
SELECT [ResellerName]
FROM [dbo].[DimReseller] AS dr
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dr.[ResellerKey] = frs.[ResellerKey]
GROUP BY [ResellerName]
HAVING COUNT([ProductKey]) = 0
ORDER BY [ResellerName] ASC;
-- 3b.	List ALL resellers and total of sales amount to each reseller. Show Reseller 
--		name, business type, and total sales with the sales showing two decimal places. 
--		Be sure to include resellers for which there were no sales. Sort by the total 
--		of sales amount in DESCENDING order. NULL will appear. 
--      4 points
--      I got 701 rows
--		QUESTION:	Who has Adventure Works sold the most to?		
--		YOUR ANSWER==> Brakes and Gears
SELECT [ResellerName], [BusinessType], ROUND(SUM([SalesAmount]),2) AS 'Total Sales'
FROM [dbo].[DimReseller] AS dr
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dr.[ResellerKey] = frs.[ResellerKey]
GROUP BY [ResellerName], [BusinessType]
ORDER BY 'Total Sales' DESC;
-- 3c.	List resellers and total sales to each.  Show reseller name, business type, and total sales 
--		with the sales showing two decimal places. Limit the list to only those resellers to which 
--		total sales are less than $500 or more than $500,000. Sort by total sales in descending order.
--      3 points
--      I got 58 rows
--		QUESTION:	What is the dollar amount in the record 2?	
--		YOUR ANSWER==> 853849.18
SELECT [ResellerName], [BusinessType], ROUND(SUM([SalesAmount]),2) AS 'Total Sales'
FROM [dbo].[DimReseller] AS dr
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dr.[ResellerKey] = frs.[ResellerKey]
GROUP BY [ResellerName], [BusinessType]
HAVING SUM([SalesAmount]) < 500.00 OR SUM([SalesAmount]) > 500000.00
ORDER BY 'Total Sales' DESC;
-- 3d.	List resellers and total sales to each for 2013. Show Reseller name, business type, 
--		and total sales with the sales showing two decimal places. Limit the results to resellers to 
--		which the total sales are between $5,000 and $7,500 and between $40,000 and $75,000.
--		Sort by total sales in descending order.
--      5 points
--      I got 48 rows
--		QUESTION:	What is the name of the reseller in record 1?
--		YOUR ANSWER==> Futuristic Sport Distributors
SELECT [ResellerName], [BusinessType], ROUND(SUM([SalesAmount]),2) AS 'Total Sales'
FROM [dbo].[DimReseller] AS dr
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dr.[ResellerKey] = frs.[ResellerKey]
GROUP BY [ResellerName], [BusinessType], YEAR([OrderDate])
HAVING ((SUM([SalesAmount]) > 5000.00 AND SUM([SalesAmount]) < 7500.00) OR (SUM([SalesAmount]) > 40000.00 AND SUM([SalesAmount]) < 75000.00)) 
AND  YEAR([OrderDate]) = 2013
ORDER BY 'Total Sales' DESC;
--4a.	List customer education level (use EnglishEducation) and the number of customers reporting 
--		each level of education. Sort by EnglishEducation in ascending order.
--      2 points
--      I got 5 rows
--		QUESTION:	What is the customer count in record 4?
--		YOUR ANSWER==> 5064
SELECT [EnglishEducation], COUNT(*) AS 'Number of Customers'
FROM [dbo].[DimCustomer]
GROUP BY [EnglishEducation]
ORDER BY [EnglishEducation] ASC;
-- 4b.	List customer education level (use EnglishEducation), the number of customers reporting 
--		each level of education, and the average yearly income for each level of education. 
--		Show the average income rounded to two (2) decimal places. Sort by EnglishEducation in ascending order.
--      3 points
--      I got 5 rows
--		QUESTION:	What is the average yearly income of the customers who have completed a Bachelors degree?	
--		YOUR ANSWER==> 64395.07
SELECT [EnglishEducation], COUNT(*) AS 'Number of Customers', ROUND(AVG([YearlyIncome]),2)
FROM [dbo].[DimCustomer]
GROUP BY [EnglishEducation]
ORDER BY [EnglishEducation] ASC;
-- 5.	List all customers and the most recent date on which they placed an order (2 fields). Show the 
--		customer's first name and middle name and last name in one column with a space between each part of the 
--		name. NULL should not appear in the FullName field. That does not mean that you should filter it 
--		out; that means that your concatenation should not result in NULL. Show the date of the most recent 
--		order as mm/dd/yyyy. It is your responsibility to make sure you do not miss any customers. Sort by 
--		order date in ascending order.
--      6 points
--      I got 18,470 rows
--		QUESTION:	What is the name in record 3?
--		YOUR ANSWER==> Caitlin C Morgan
SELECT CONCAT([FirstName],' ',[MiddleName],' ', [LastName]) AS 'Customer Name', MAX(CONVERT (varchar(10),[OrderDate],101)) 'Most Recent Order Date'
FROM [dbo].[DimCustomer] as dc
INNER JOIN [dbo].[FactInternetSales] AS fis ON
dc.[CustomerKey] = fis.[CustomerKey]
GROUP BY CONCAT([FirstName],' ',[MiddleName],' ', [LastName])
ORDER BY MAX(CONVERT (varchar(10),[OrderDate],101)) ASC;
--6.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an aggregate function with the having clause. 
--		Then write the complete SQL query that will provide the information that you are seeking.
--      2 points
--  	Show Reseller name and total sales with the sales showing two decimal places. Limit the results to resellers to 
--		which the total sales are greater than $200,000.
--		Sort by total sales in descending order.
--		QUESTION:	What is the reseller in record 3?
--		YOUR ANSWER==> Vigorous Exercise Company
SELECT [ResellerName], ROUND(SUM([SalesAmount]),2) AS 'Total Sales'
FROM [dbo].[DimReseller] AS dr
LEFT OUTER JOIN [dbo].[FactResellerSales] AS frs
ON dr.[ResellerKey] = frs.[ResellerKey]
GROUP BY [ResellerName]
HAVING  ROUND(SUM([SalesAmount]),2) > 200000
ORDER BY 'Total Sales' DESC;

