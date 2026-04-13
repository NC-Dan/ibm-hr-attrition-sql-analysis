-- ================================================
-- FILE 3: WINDOW FUNCTIONS ANALYSIS
-- IBM HR Attrition Analysis ← Rankings, dept comparisons, running totals
-- Author: Duncan Chicho (NC-Dan)
-- ================================================

USE MpesaAgents;
GO

-- ANALYSIS 1: Rank employees by income within each department
SELECT 
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    Attrition,
    RANK() OVER (
        PARTITION BY Department 
        ORDER BY MonthlyIncome DESC
    ) AS IncomeRankInDept
FROM HRAttrition
ORDER BY Department, IncomeRankInDept;
GO

-- ANALYSIS 2: Compare each employee income to their department average
WITH DeptStats AS (
    SELECT 
        Department,
        AVG(MonthlyIncome) AS DeptAvgIncome
    FROM HRAttrition
    GROUP BY Department
)
SELECT 
    h.EmployeeNumber,
    h.Department,
    h.JobRole,
    h.MonthlyIncome,
    h.Attrition,
    d.DeptAvgIncome,
    h.MonthlyIncome - d.DeptAvgIncome AS GapFromDeptAverage
FROM HRAttrition h
INNER JOIN DeptStats d ON h.Department = d.Department
ORDER BY Department, GapFromDeptAverage ASC;
GO

-- ANALYSIS 3: Running headcount and attrition by age
SELECT 
    Age,
    COUNT(*) AS EmployeesAtThisAge,
    SUM(CAST(Attrition AS INT)) AS LeaversAtThisAge,
    SUM(COUNT(*)) OVER (ORDER BY Age) AS RunningHeadcount,
    SUM(SUM(CAST(Attrition AS INT))) OVER (ORDER BY Age) AS RunningLeavers
FROM HRAttrition
GROUP BY Age
ORDER BY Age;
GO