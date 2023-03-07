USE AdventureWorks2008R2

2. 
SELECT BusinessEntityID, NationalIDNumber, BirthDate, HireDate FROM HumanResources.Employee
WHERE JobTitle = 'Marketing Specialist'
ORDER BY HireDate ASC;

3. 
SELECT TOP 1 Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.LastName, Person.EmailAddress.EmailAddress
FROM Person.Person
INNER JOIN Person.EmailAddress ON Person.Person. BusinessEntityID = Person.EmailAddress.BusinessEntityID
WHERE (Person.Person.FirstName LIKE 'M%') OR (Person.Person.FirstName LIKE 'S%')
ORDER BY Person.Person.FirstName DESC;


4.
SELECT TerritoryID, COUNT(SubTotal) AS Ordenesinferioresa1000$
FROM Sales.SalesOrderHeader 
WHERE SubTotal < 1000
GROUP BY TerritoryID
ORDER BY COUNT(SubTotal);

5.
SELECT TOP 5 ProductID, Name AS Nombre, Style AS Estilo, Size AS Tamaño, Color, Weight AS Peso FROM Production.Product
WHERE (Style IS NOT NULL) AND (Size IS NOT NULL) AND (Color IS NOT NULL) AND (Weight IS NOT NULL)
ORDER BY ProductID;

6.
SELECT COUNT(LastName) FROM Person.Person
WHERE LastName LIKE 'D%' AND LastName LIKE '%a%';


7.
SELECT CONCAT (FirstName, MiddleName, LastName) FROM Person.Person;

SELECT FirstName||' '||MiddleName||' '||LastName FROM Person.Person;

SELECT FirstName+''+MiddleName+''+LastName FROM Person.Person;

10.

select  SalesOrderID,EmployeeDepartmentHistory.DepartmentID,Department.Name, sum(SubTotal)as sales from Sales.SalesOrderHeader
Join HumanResources.Employee on SalesPersonID = BusinessEntityID
join HumanResources.EmployeeDepartmentHistory on EmployeeDepartmentHistory.BusinessEntityID = Employee.BusinessEntityID
join HumanResources.Department on Department.DepartmentID = EmployeeDepartmentHistory.DepartmentID
where TerritoryID % 2 != 0 AND CurrencyRateID IS NOT NULL
group by TerritoryID,SalesOrderID, EmployeeDepartmentHistory.DepartmentID, Department.Name
order by sales desc


11.
SELECT DISTINCT COUNT(CustomerID) FROM Sales.SalesOrderHeader
WHERE (DATEPART(MONTH, OrderDate) =4) AND (DATEPART(DAY,OrderDate) BETWEEN 1 AND 7) AND (DATEPART(YEAR,OrderDate) = 2008) AND TerritoryID =8
GROUP BY DAY(OrderDate)
;
select COUNT(CustomerID) from sales.SalesOrderHeader
where  OrderDate >= CAST('2008-04-01 00:00:00.000' AS DATE) AND OrderDate < CAST('2008-04-08 00:00:00.000' AS DATE)
AND TerritoryID = 8
Group by DAY(OrderDate);

12.

SELECT DISTINCT Size FROM Production.Product; 
SELECT TOP 5 * FROM Production.Product;

SELECT COUNT(Sales.ShoppingCartItem.ProductID) FROM Production.Product
FULL OUTER JOIN Sales.ShoppingCartItem ON Sales.ShoppingCartItem.ProductID = Production.Product.ProductID
WHERE (ISNUMERIC(Size) = 0) AND (Color <> 'Blue') AND (Color <> 'Yellow');

13.

SELECT Person.Person.FirstName, Person.Person.LastName, HumanResources.Employee.BirthDate,
HumanResources.Employee.JobTitle, Person.EmailAddress.EmailAddress, Person.PersonPhone.PhoneNumber
FROM (((((Person.Person
INNER JOIN HumanResources.Employee ON HumanResources.Employee.BusinessEntityID= Person.Person.BusinessEntityID)
INNER JOIN Person.EmailAddress ON Person.EmailAddress.BusinessEntityID =Person.Person.BusinessEntityID)
INNER JOIN Person.PersonPhone ON Person.PersonPhone.BusinessEntityID =Person.Person.BusinessEntityID)
INNER JOIN HumanResources.EmployeeDepartmentHistory ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID)
INNER JOIN HumanResources.Department ON HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID)
WHERE HumanResources.Department.Name LIKE '%Production%';


SELECT TOP 10 * FROM HumanResources.Department;


16.
SELECT Sales.Customer.CustomerID,  SUM(Sales.SalesOrderHeader.SubTotal)
FROM Sales.Customer
INNER JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
GROUP BY Sales.Customer.CustomerID
;

18.

select FirstName, sum(SubTotal),Year(OrderDate) as year
FROM ((Sales.SalesOrderHeader 
INNER JOIN Person.Person ON SalesOrderHeader.SalesPersonID = Person.BusinessEntityID)
INNER JOIN Person.StateProvince ON Sales.SalesOrderHeader.TerritoryID = Person.StateProvince.TerritoryID)
WHERE Person.StateProvince.Name = 'Washington'
Group by Year(OrderDate),FirstName;


SELECT * FROM Person.StateProvince WHERE Name = 'Washington';

19.
SELECT Name, SUM(SalesYTD), (SUM(SalesYTD)-SUM(SalesLastYear)) / SUM(SalesLastYear) AS perc FROM Sales.SalesTerritory
GROUP BY Name
ORDER BY perc DESC;

20.
select Name, (ScrappedQty / OrderQty * 100), (Product.ListPrice*ScrappedQty) as total from Production.Product
JOIN Production.WorkOrder
ON Product.ProductID = WorkOrder.ProductID
WHERE ScrappedQty != 0
group by  Product.ProductID, Name, ScrappedQty, OrderQty, ListPrice
Order by total desc;

15.
SELECT TOP 10 * FROM Sales.SalesOrderHeader;

SELECT SalesOrderID, OrderDate
FROM (Sales.SalesOrderHeader
INNER JOIN Sales.CurrencyRate ON Sales.CurrencyRate. = Sales.SalesOrderHeader.SalesOrderID)
ORDER BY Sales.SalesOrderHeader.SalesOrderID ;