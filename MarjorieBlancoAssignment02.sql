--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #2              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
-- Submit your .sql file named with your last name, first name and assignment # (e.g., FreebergAssignment2.sql). 
-- Submit your file to the instructor using through the course site.  
--
-- Answer Summary:
-- Question		Points		YOUR ANSWER
--	1.			2			847
--	2.			4			A Typical Bike Shop
--	3.			4			Paint Supply
--	4.			3			adventure-works\michael9
--	5.			3			121
--	6.			4			711
--	7.			4			3399.9
--	8.			4			2294.99
--	9.			4			Silver
--	10.			4			Calgary
--	11.			3			England
--	12.			4			Victoria
--	13.			3			15
--	14.			4			29638
--------------------------------------------------------------------------------------------------------------------
--1.	(2) List all customers.  Include all the attributes in the table. Use * in this statement. 
--		NOTE: When exploring data in a table, we will often write a statement using *. In this statement 
--		your primary purpose is to see how * works. After executing the statement, explore the data.
--		QUESTION:	How many records did the query return?
--		YOUR ANSWER (remember to also record it at the beginning of this file): 847 
USE AdventureWorksLT2012;
SELECT count(*)
FROM SalesLT.Customer;
SELECT *
FROM SalesLT.Customer;
--2.	(4) List the company name, first name, last name, and email address of each customer in alphabetical order 
--		by company name. 
--		NOTE: In this statement you are limiting the fields that you are including in the results set. Additionally, 
--		you are sorting your results in a specific order. Recall that order is not guaranteed unless a sort order is 
--		specified in the statement. 
--		QUESTION:	What is the CompanyName in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): A Typical Bike Shop
SELECT c.CompanyName, c.FirstName, c.LastName, c.EmailAddress
FROM SalesLT.Customer as c
ORDER BY c.CompanyName ASC; 
--3.	(4) List the company name, first name, last name, and phone number for each customer in alphabetical 
--		order by last name, then by first name, and then by company.  Hint: There will be one SELECT statement 
--		with three fields in the ORDER BY clause. Do not change the order of the fields in the SELECT clause.
--		NOTE: In this statement, you are experimenting with ORDER BY. Scan the results and look for customers with 
--		the same last name. Notice how they are sorted by first name within the sort by last name. If there are 
--		customers with the same last and first name, they will also be sorted on company name. 
--		QUESTION:	What is the CompanyName in record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file):  Paint Supply	(Aidan	Delaney	358-555-0188)
SELECT c.CompanyName, c.FirstName, c.LastName, c.Phone
FROM SalesLT.Customer as c
ORDER BY c.FirstName ASC, c.LastName ASC, c.CompanyName ASC;
--4.	(3) List only the sales person and show each sales person only one time. Sort in alphabetical order. 
--		NOTE: When you are asked to show a field "one time" or "only once" or "unique", that the DISTINCT keyword 
--		is used (until we get to GROUP BY in later modules). Even if you know how to use GROUP BY, you will not 
--		use it in the assignments until it is covered in the class. 
--		QUESTION:	What is the SalesPerson in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): adventure-works\michael9
SELECT DISTINCT c.SalesPerson
FROM SalesLT.Customer AS c
ORDER BY c.SalesPerson ASC;
--5.	(3) List all product models by name.  Include all data about each product model. 
--		"All data" means to include all the fields. 
--		NOTE: When you see the phrase "by [field name]", such as "by name" above, a sort order 
--		is requested. In this case, sort by the model name. Since the order is not designated, 
--		ascending would be used. 
--		QUESTION:	What is the ProductModelID in record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): 121
SELECT *
FROM SalesLT.ProductModel as p
ORDER BY p.Name ASC; 
--6.	(4) List all products showing product ID, product name, product number, product model id, 
--		product category id. Sort by product category id descending and then by product number ascending. 
--		Do not change the order of the fields in the SELECT clause. 
--		QUESTION:	What is the ProductID in record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): 711
SELECT p.ProductID, p.Name, p.ProductNumber, p.ProductModelID, p.ProductCategoryID
FROM SalesLT.Product AS p
ORDER BY p.ProductID ASC, p.ProductNumber ASC, p.ProductModelID ASC, p.ProductCategoryID ASC; 
--7.	(4) List all products showing product ID, product name, color, standard cost and list price ordered by 
--		highest to lowest list price. 
--		QUESTION:	What is the ListPrice in record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): 3399.99
 SELECT p.ProductID, p.Name, p.Color, p.StandardCost, p.ListPrice
 FROM SalesLT.Product AS p
 ORDER BY p.ListPrice DESC; 
--8.	(4) List the list price of AdventureWorks products. List each list price only once and sort with highest list 
--		price at the top. 
--		Note: AdventureWorks is the name of the business for which we are creating these SELECT statements; 
--		AdventureWorks owns the data. 
--		QUESTION:	What is the ListPrice in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): 2294.99
SELECT DISTINCT p.ListPrice
FROM SalesLT.Product AS p
ORDER BY p.ListPrice DESC; 
--9.	(4) List the colors of AdventureWorks products.  List each color only once and in alphabetical order. 
--		NOTE: We will learn to deal with NULL in the next module, so NULL will show in the list of colors. Even 
--		if you know how to filter out NULL, it is not necessary to do so here.
--		QUESTION:	What is the Color in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): Silver
SELECT DISTINCT p.Color
FROM SalesLT.Product AS p
ORDER BY p.Color ASC; 
--10.	(4) List all addresses.  Include all data about each address. "All data" means to include all 
--		the fields. Order by country, state, and city in ascending order. 
--		NOTE: Wonder why this table does not contain the customer names? Because a customer can have many
--		different addresses and there can be more than one customer at the same address. To see this for 
--		yourself, create a database diagram with Customer, CustomerAddress, and Address. You will see that 
--		CustomerAddress is an intersection table that allows one customer to have many addresses and one 
--		address to belong to many customers. You will not create any joins in this statement and you do  
--		not need to submit the database diagram, but you should create it.
--		QUESTION:	What is the City in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): Calgary 
SELECT *
FROM SalesLT.Address AS a
ORDER BY a.CountryRegion ASC, a.StateProvince ASC, a.City ASC
--11.	(3) List the unique state/province, and country/region and order alphabetically by 
--		country/region and state/province. 
--		NOTE: Even though ascending is the default sort, to make your code self-documenting you should specify 
--		the sort order for each field in the ORDER BY statement. 
--		QUESTION:	What is the StateProvince in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): England
SELECT DISTINCT a.StateProvince, a.CountryRegion
FROM SalesLT.Address AS a
ORDER BY a.CountryRegion ASC, a.StateProvince ASC;
--12.	(4) List the unique city, state/province and country/region and order alphabetically by country/region and 
--		state/province.
--		NOTE: The statement is asking for the unique combination of city, state/province, and country/region. That means 
--		that state/province will not be unique and country/region will not be unique. However, the combination of city, 
--		state/province, and country/region will be unique. 
--		QUESTION:	What is the City in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): Victoria
SELECT DISTINCT a.City, a.StateProvince, a.CountryRegion
FROM SalesLT.Address AS a
ORDER BY a.CountryRegion ASC, a.StateProvince ASC;
--13.	(3) List all orders from the SalesLT.SalesOrderDetails table from highest to lowest on order quantity.  
--		Include all data related to each order. 
--		QUESTION:	What is the OrderQty in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): 15
SELECT *
FROM SalesLT.SalesOrderDetail as sod
ORDER BY SOD.OrderQty DESC;
--14.	(4) List customer IDs in ascending order for all customers that have placed orders with AdventureWorks. 
--		Use the SalesLT.SalesOrderHeader table and show each customer ID only once even if the customer 
--		has placed multiple orders. 
--		NOTE: If a customer has placed an order, that customer's CustomerID will appear in the SalesOrderHeader 
--		table. If the customer has not placed an order, the CustomerID will not be in the table. You will use 
--		only one table. We are only requesting the CustomerID and no other information about the customer.
--		QUESTION:	What is the CustomerID in the record 7?	
--		YOUR ANSWER (remember to also record it at the beginning of this file): 29638 
SELECT DISTINCT soh.CustomerID
FROM SalesLT.SalesOrderHeader AS soh
ORDER BY soh.CustomerID ASC;