--Question 1
--Write a SQL query to find all unique values of countries that are in the Orders table.
SELECT DISTINCT ShipCountry
FROM Orders;

--Question 2
--Write a SQL query to generate all orders from USA and Sweden from the Orders table
SELECT *
FROM Orders
WHERE ShipCountry IN ('USA', 'Sweden');

--Question 3
--Write a SQL query to print details of all products with productname like ‘Queso’ from the 
--Products table.
SELECT *
FROM Products
WHERE ProductName LIKE 'Queso%'

--Question 4
--Write a SQL query to select all orders from the Orders table with freight between 100 and 500.
SELECT *
FROM Orders
WHERE Freight BETWEEN 100 AND 500;

--Question 5
--Write a SQL query to show the ‘shipcity’ with its corresponding count of orders. Please sort the 
--order counts from the highest to the lowest.
SELECT ShipCity, COUNT(*) AS OrderCount
FROM Orders
GROUP BY ShipCity
ORDER BY OrderCount DESC;

--Question 6
--Give me the number of orders that were never shipped. 
SELECT COUNT(*) AS UnshippedOrders
FROM Orders
WHERE ShippedDate IS NULL;

--Question 7 
--Generate a table that shows the total Freight from each country between the dates ‘1996-12-
--31' and '1998-12-31'. Do not include Countries that have a total freight weight of 1000 and the 
--list should start from the highest total freight to the lowest.
SELECT ShipCountry, SUM(Freight) AS Freight_Sum
FROM Orders
WHERE OrderDate BETWEEN '1996-12-31' AND '1998-12-31'
GROUP BY ShipCountry
HAVING SUM(Freight) < 1000
ORDER BY Freight_Sum DESC;


--Question 8
--Select all records from the orders table where ‘shippeddate’ is between the month of October 
--and December.
SELECT *
FROM Orders
WHERE MONTH(ShippedDate) BETWEEN 10 AND 12;

--Question 9
--Select all records from the orders table where shippeddate is between the month of January
--and June, and the year required for the order to arrive (requireddate) is greater than or equal 
--1996
SELECT *
FROM Orders
WHERE MONTH(ShippedDate) BETWEEN 1 AND 6
AND YEAR(RequiredDate) >= 1996;


--Question 10
--Write a SQL query to find all employees with Homephone starting with (206).
SELECT *
FROM Employees
WHERE HomePhone LIKE '206%';


--Question 11
--Write a SQL query to find all employees with Homephone not starting with (206).
SELECT *
FROM Employees
WHERE HomePhone NOT LIKE '206%';


--Question 12
--Select all records from the employees table where the shipregion is null
SELECT *
FROM Employees
WHERE ShipRegion IS NULL;


--Question 13
--Write a SQL query to find all records in the Orders table where ship name starts with ‘Hi’ or ‘Ha’
--and freight is less or equal to 20.
SELECT *
FROM Orders
WHERE ShipName LIKE 'Hi%' OR ShipName LIKE 'Ha%'
AND Freight <= 20;


--Question 14
--Mr. Obama from the Logistics department has tasked you to produce a report that shows the 
--difference between the Orderdate and Shippeddate for all orders in the Orders table. Mr.
--Obama wants you to rename the calculated column as Shipped Deficiency. Please sort Shipped 
--Deficiency in ascending order. Shipped deficiency should be reported in ‘days.
SELECT *,
       DATEDIFF(DAY, OrderDate, ShippedDate) AS Shipped_Deficiency
FROM Orders
ORDER BY Shipped_Deficiency ASC;


--Question 15
--Generate a report showing the total number of all orders based on ‘ShipCountry’ and ‘ShipCity’
--from the Orders table. Please make sure that you have arranged your result set in alphabetical 
--order based on ‘ShipCountry’ and ‘ShipCity’.
SELECT ShipCountry, ShipCity, COUNT(*) AS OrderCount
FROM Orders
GROUP BY ShipCountry, ShipCity
ORDER BY ShipCountry ASC, ShipCity ASC;


--Question 16
--Write a SQL query to find the age of all employees and the month they were born.
--NB: Month should be reported in Nvarchar. E.g.: September and not 09.
SELECT EmployeeID,
       DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age,
       DATENAME(MONTH, BirthDate) AS BirthMonth
FROM Employees;


--Question 17
--In the customers table, the Contact name shows both the firstname and the lastname. Write a
--SQL query to split the contact name into first name and last name.
SELECT 
    LEFT(ContactName, CHARINDEX(' ', ContactName) - 1) AS FirstName,
    RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName)) AS LastName
FROM Customers;


--Question 18
--From the Employees table, generate a report having ‘EmployeeID’, ‘Employee_FullName’ 
--(Derived Column), ‘HireDate’ and ‘Address’. 
SELECT 
    EmployeeID,
    CONCAT_WS(' ', FirstName, LastName) AS Employee_FullName,
    HireDate,
    Address
FROM Employees;

--Question 19
--Write a SQL query to count all customers with ‘contacttitle’ as Owner and Sales Manager.
SELECT COUNT(*) AS CustomerCount
FROM Customers
WHERE ContactTitle IN ('Owner', 'Sales Manager');

--Question 20
--Select all records from the customers table with alphanumeric postal codes. The postal codes 
--should have a length of 6.
SELECT *
FROM Customers
WHERE PostalCode LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]';

--Question 21
--Select all records from the customers table with 5-digit postal codes and country in Germany, 
--France, Spain, and Mexico.
SELECT *
FROM Customers
WHERE PostalCode LIKE '[0-9][0-9][0-9][0-9][0-9]'
AND Country IN ('Germany', 'France', 'Spain', 'Mexico');


--Question 22
--From the result set you worked on in Question 18, your Lead asks you to make the 
--Employee_FullName column you generated and the Address column to be ALL CAPS. Edit your 
--query to take into account these changes and show the new result set.
SELECT 
    EmployeeID,
    UPPER(CONCAT_WS(' ', FirstName, LastName)) AS Employee_FullName,
    HireDate,
    UPPER(Address) AS Address
FROM Employees;

--Question 23
--In the customers table, you have been instructed by Human resource department to change the 
--Contact tile of Sales Representative to Sales Officer.
UPDATE Customers
SET ContactTitle = 'Sales Officer'
WHERE ContactTitle = 'Sales Representative';

--Question 24
--For security reasons, the Human resource departments has tasked you to mask the last four 
--digits of the Homephone number with *. Please write a SQL query to achieve this.
SELECT 
    LEFT(HomePhone, LEN(HomePhone) - 4) + '****' AS Masked_HomePhone
FROM Customers;

--Question 25
--Company HHH, is running a promo on all products and plans to reduce the unit price of some 
--selected products. Please reduce all products by 5 dollars where the productid is between 11 
--and 60 in the order details table. Rename the derived column as Discount2.
UPDATE OrderDetails
SET Discount2 = UnitPrice - 5
WHERE ProductID BETWEEN 11 AND 60;

--Question 26
--Generate a report for Suppliers by specifying the ‘SupplierID’, ‘CompanyName’, ‘Country’ and 
--‘Address’ for all Suppliers. Alias the table s and reference the columns in your select statement
SELECT 
    SupplierID,
    CompanyName,
    Country,
    Address AS Supplier_Address
FROM Suppliers s;

--Question 27 
--Select all records from the orders table where the orders were ‘shipped’ or ‘ordered’ in the 
--month of September and the shipped deficiency is greater than 4 days. Please refer to Question 
--14 for Sipped Deficiency calculation.
SELECT *,
       DATEDIFF(DAY, OrderDate, ShippedDate) AS Shipped_Deficiency
FROM Orders
WHERE (MONTH(OrderDate) = 9 OR MONTH(ShippedDate) = 9)
AND DATEDIFF(DAY, OrderDate, ShippedDate) > 4;

--Question 28
--Your Company’s finance department want to know the monetary value of all the products left in stock. 
--Produce a report that highlights the Total Monetary amount of per product.
--Total Monetary amount: (Unit Price * UnitsInStock) Rounded to the nearest highest Integer Value.
SELECT 
    ProductID,
    ROUND(UnitPrice * UnitsInStock, 0) AS Total_Monetary_Amount
FROM Products;

--Question 29
--Company HHH, wants to hold a long service award and would like to know the number of years 
--each employee has been working. Please write a query to generate a list for HR department.
--Please sort the number of years in ascending order.
SELECT 
    EmployeeID,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS Years_Worked
FROM Employees
ORDER BY Years_Worked ASC;

--Question 30
--Select all employees where the city ends with ‘n’ or ‘nd’ and postalcode is equal to 6-digit code.
SELECT *
FROM Employees
WHERE (RIGHT(City, 1) = 'n' OR RIGHT(City, 2) = 'nd')
AND PostalCode LIKE '[0-6][0-6][0-6][0-6][0-6][0-6]';
