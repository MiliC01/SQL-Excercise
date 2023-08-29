-- Creating two data tables, one with Employee Demographics and another one with Employee Salary data
CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName Varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int
)
-- Inserting data to both data tables
INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male')

-- Note that there is duplicate data we have to delete 
INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

-- Delete duplicate rows
WITH CTE AS(
	SELECT [EmployeeID], [FirstName], [LastName], [Age], [Gender],
		RN = ROW_NUMBER()OVER(PARTITION BY EmployeeID ORDER BY EmployeeID)
  FROM EmployeeDemographics
)
DELETE FROM CTE WHERE RN > 1

WITH CTE AS(
	SELECT [EmployeeID], [JobTitle], [Salary],
		RN = ROW_NUMBER()OVER(PARTITION BY EmployeeID ORDER BY EmployeeID)
	FROM EmployeeSalary
)
DELETE FROM CTE WHERE RN > 1

/*
Basic Functions
Select Statement
*, Top, Distinct, Count, As, Max, Min, Avg
*/

-- Selecting all the table 
SELECT *
FROM EmployeeDemographics
-- Selecting the first five rows of the table
SELECT TOP 5 *
FROM EmployeeDemographics

SELECT DISTINCT(Gender)
FROM EmployeeDemographics

SELECT COUNT(LastName)AS LastNameCount
FROM EmployeeDemographics

SELECT MAX(Salary)
FROM EmployeeSalary

SELECT MIN(Salary)
FROM EmployeeSalary

SELECT AVG(Salary)
FROM EmployeeSalary

/*
Basic Functions
Where Statement (limits the amount of data, and specifies what data you want returned)
=, <>, <, >, And, Or, Like, Null, Not Null, In
*/

-- = -> equals
SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim'

-- <> -> does not equal
SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'

-- greater than
SELECT *
FROM EmployeeDemographics
WHERE Age > 30

-- Greater than or equal
SELECT *
FROM EmployeeDemographics
WHERE Age >= 30

SELECT *
FROM EmployeeDemographics
WHERE Age < 32

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32
-- Use the AND statement
SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender = 'Male'

-- find the last names that start with S
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'

-- find the last names that start with S and has o
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%o%'

-- Null and Not Null
SELECT *
FROM EmployeeDemographics
WHERE FirstName is NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL

-- Using In statement

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael')

/*
Basic Functions
Group By, Order By
*/
-- Similar to Distinct in this case
SELECT Gender
FROM EmployeeDemographics
GROUP BY Gender

-- how to see the difference
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender

--Adding a WHERE clause
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender

---- Using Order By
SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC

