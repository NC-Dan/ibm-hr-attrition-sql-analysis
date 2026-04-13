-- ================================================
-- FILE 2: ATTRITION DEEP DIVE
-- IBM HR Attrition Analysis ← Age band, job role, travel analysis
-- Author: Duncan Chicho (NC-Dan)
-- ================================================

USE MpesaAgents;
GO

-- ANALYSIS 1: Attrition by Age Band --
WITH CTE AS(
	SELECT
			Attrition,
			Age,
	CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS AgeGroup
FROM HRAttrition
)
SELECT
	AgeGroup,
	COUNT(*) AS TotalEmployees,
	SUM(CAST(Attrition AS INT)) AS EmployeesLeft,
	CAST(SUM(CAST(Attrition AS INT))*100.0/ COUNT(*) AS decimal(5,2)) AS AttritionRate
FROM CTE
GROUP BY AgeGroup
ORDER BY AttritionRate DESC
GO

-- ANALYSIS 2: Attrition by Job Role --
SELECT 
    JobRole,
    COUNT(*) AS TotalEmployees,
    SUM(CAST(Attrition AS INT)) AS EmployeesLeft,
    CAST(SUM(CAST(Attrition AS INT)) * 100.0 / COUNT(*) 
        AS DECIMAL(5,2)) AS AttritionRate,
    AVG(MonthlyIncome) AS AvgMonthlyIncome
FROM HRAttrition
GROUP BY JobRole
ORDER BY AttritionRate DESC;
GO

-- ANALYSIS 3: Attrition by Business Travel --
SELECT 
    BusinessTravel,
    COUNT(*) AS TotalEmployees,
    SUM(CAST(Attrition AS INT)) AS EmployeesLeft,
    CAST(SUM(CAST(Attrition AS INT)) * 100.0 / COUNT(*) 
        AS DECIMAL(5,2)) AS AttritionRate
FROM HRAttrition
GROUP BY BusinessTravel
ORDER BY AttritionRate DESC;
GO