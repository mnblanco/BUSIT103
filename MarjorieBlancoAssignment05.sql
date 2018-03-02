-- List the product ID, product name, standard cost, and list price in descending order by list price
-- for Products whose list price is greater than $2000
USE AdventureWorksLT2012;
SELECT [ProductID], [Name], [StandardCost], [ListPrice]
FROM [SalesLT].[Product]
WHERE [ListPrice] > 2000
ORDER BY [ListPrice] ASC;

