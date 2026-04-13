-- ================================================
-- FILE 1: Database setup & exploratory analysis
-- IBM HR Attrition Analysis
-- Author: Duncan Chicho (NC-Dan)
-- ================================================

USE MpesaAgents;
GO
-- Check row count
SELECT COUNT(*) AS TotalEmployees 
FROM HRAttrition;
GO
-- Preview first 10 rows
SELECT TOP 10 * 
FROM HRAttrition;
GO
--Exploratory Data Analysis

--ANALYSIS 1: How many employees left vs stayed?
SELECT 
    Attrition,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS Percentage
FROM HRAttrition
GROUP BY Attrition;
GO

--ANALYSIS 2: Attrition by Department
SELECT 
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CAST(Attrition AS INT)) AS EmployeesLeft,
    CAST(SUM(CAST(Attrition AS INT)) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS AttritionRate
FROM HRAttrition
GROUP BY Department
ORDER BY AttritionRate DESC;
GO

--ANALYSIS 3: Average Age and Salary by Attrition
SELECT 
    Attrition,
    AVG(Age) AS AvgAge,
    AVG(MonthlyIncome) AS AvgMonthlyIncome
FROM HRAttrition
GROUP BY Attrition;
GO