/*
CTEs -> type of subquery
*/ 
WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary, 
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM EmployeeDemographics Emp
	JOIN EmployeeSalary Sal
		ON Emp.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee

/*
Temp Tables
*/

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES(
'1001', 'HR', '45000'
)

INSERT INTO #temp_Employee
SELECT *
FROM EmployeeSalary

CREATE TABLE #temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int, 
AvgSalary int)

INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics Dem
JOIN EmployeeSalary Sal
	ON Dem.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2

-- Use DROP TABLE IS EXISTS table  so things run smoothly

/*
String Functions - TRIM, LTRIM, RTRIM, REPLACE, SUNBSTRING, UPPER, LOWER
*/
CREATE TABLE EmplyeeErrors (
  EmployeeId varchar(50),
  FirstName varchar(50),
  LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES
('1001', 'Jimbo', 'Halbert'),
('1002', 'Pamela', 'Beasely'),
('1003', 'Toby', 'Flenderson - Fired') 

SELECT *
FROM EmployeeErrors

SELECT EmployeeID, TRIM(EmployeeId) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeId) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeId) AS IDTRIM
FROM EmployeeErrors

SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors

SELECT SUBSTRING(FirstName, 1, 3)
FROM EmployeeErrors

SELECT err.FirstName, dem.Firstname
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
  ON  err.FirstName = dem.FirstName

SELECT err.FirstName, dem.Firstname
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
  ON  SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(dem.FirstName, 1, 3)

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors

/*
Stred Procedure
*/

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST

CREATE PROCEDURE Temp_Employee
AS
CREATE TABLE #temp_employee (
JobTitle varchar(100),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_employee
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM [SQL Tutorial].[dbo].EmployeeDemographics emp
JOIN [SQL Tutorial].[dbo].EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee

EXEC Temp_Employee

/*
Subqueries
*/
SELECT EmployeeID, Salary, (Select AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary
  
SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1, 2

SELECT a.EmployeeID, AllAvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
	FROM EmployeeSalary) a

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID IN (
	SELECT EmployeeID
	FROM EmployeeDemographics
	WHERE Age > 30)
