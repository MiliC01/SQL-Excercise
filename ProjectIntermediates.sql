/*
Intermediate Functions
Inner Joins, Full/Left/Right/Outer Joins
*/

-- Inner Join Shows anything overlapping in table A and B
SELECT *
FROM EmployeeDemographics
Inner Join [SQL Tutorial].[dbo].[EmployeeSalary]
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM EmployeeDemographics
Outer Join [SQL Tutorial].[dbo].[EmployeeSalary]
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM EmployeeDemographics
FULL Outer Join [SQL Tutorial].[dbo].[EmployeeSalary]
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM EmployeeDemographics
Left Outer Join [SQL Tutorial].[dbo].[EmployeeSalary]
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM EmployeeDemographics
Right Outer Join [SQL Tutorial].[dbo].[EmployeeSalary]
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
FROM EmployeeDemographics
Inner Join [SQL Tutorial].[dbo].[EmployeeSalary]
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
Inner Join [SQL Tutorial].[dbo].[EmployeeSalary]
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

/*
Intermediate Functions
Union, Union All
*/

SELECT *
FROM EmployeeDemographics
UNION
SELECT *
FROM WarehouseEmployeeDemographics

SELECT *
FROM EmployeeDemographics
UNION ALL
SELECT *
FROM WarehouseEmployeeDemographics
ORDER BY EmployeeID


SELECT EmployeeID, FirstName, Age
FROM EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
ORDER BY EmployeeID

/*
Case Statements
*/

SELECT FirstName, LastName, Age
FROM EmployeeDemographics

SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	ELSE 'Young'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary*0.05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * 0.000001)
	ELSE Salary + (Salary*0.03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/*
Having Clause
*/

SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

/*
Updating and deleting data
*/

UPDATE EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Jim' AND LastName = 'Halpert'

UPDATE EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Jim' AND LastName = 'Halpert'

/*
Aliasing
*/
SELECT FirstName AS Fname
FROM EmployeeDemographics

SELECT FirstName + ' ' + LastName AS FullName
FROM EmployeeDemographics

/*
Partition By
*/

SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER (Partition BY Gender) AS TotalGender
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
