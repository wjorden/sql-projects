SELECT *
  FROM [SBA_Proj].[dbo].[sba_public_data];

-- All approved loans for 2020 and 2021
SELECT 
	year(DateApproved) [Year Approved],
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2020  
GROUP BY year(DateApproved)

UNION

SELECT 
	year(DateApproved) [Year Approved],
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2021
GROUP BY year(DateApproved);

-- Unique Lender Loans (2020 v. 2021)
SELECT 
	count(DISTINCT OriginatingLender) [Unique Lenders],
	year(DateApproved) [Year Approved],
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2020  
GROUP BY year(DateApproved)

UNION

SELECT 
	count(DISTINCT OriginatingLender) [Unique Lenders],
	year(DateApproved) [Year Approved],
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2021
GROUP BY year(DateApproved);

-- Top 10 Originating Lenders by Loan Count, Total Loan Amount, and Average
-- 2021
SELECT TOP 10
	OriginatingLender,
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2021
GROUP BY OriginatingLender
ORDER BY 3 DESC;

-- 2020
SELECT TOP 10
	OriginatingLender,
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2020
GROUP BY OriginatingLender
ORDER BY 3 DESC;

-- Top 15 Industries to receive PPP Loans
-- 2020
SELECT TOP 15 d.Sector,
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data] p
INNER JOIN [dbo].[sba_naics_sector_code_description] d
	ON LEFT(p.NAICSCode, 2) = d.[Lookup Codes]
WHERE year(DateApproved) = 2020
GROUP BY d.Sector
ORDER BY 3 DESC;

-- 2021
SELECT TOP 15 d.Sector,
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data] p
INNER JOIN [dbo].[sba_naics_sector_code_description] d
	ON LEFT(p.NAICSCode, 2) = d.[Lookup Codes]
WHERE year(DateApproved) = 2021
GROUP BY d.Sector
ORDER BY 3 DESC;

-- CTE
;WITH cte as
(
SELECT TOP 15 d.Sector,
	count(LoanNumber) [Number Approved],
	SUM(InitialApprovalAmount) [Approved Amount],
	AVG(InitialApprovalAmount) [Average Loan]
FROM [SBA_Proj].[dbo].[sba_public_data] p
INNER JOIN [dbo].[sba_naics_sector_code_description] d
	ON LEFT(p.NAICSCode, 2) = d.[Lookup Codes]
WHERE year(DateApproved) = 2021
GROUP BY d.Sector
)

SELECT Sector, [Number Approved], [Approved Amount], [Average Loan],
	[Approved Amount]/SUM([Approved Amount]) OVER() * 100 [Percent By Borrowed Amount]
FROM cte
ORDER BY 3 desc;

-- Amount Forgiven By Year
-- 2020
SELECT
	count(LoanNumber) [Number Approved],
	SUM(CurrentApprovalAmount) [Approved Amount],
	AVG(CurrentApprovalAmount) [Average Loan],
	SUM(ForgivenessAmount) [Amount Forgiven],
	SUM(ForgivenessAmount)/SUM(CurrentApprovalAmount) * 100 [Percent Forgiven]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2020
ORDER BY 3 DESC;

-- 2021
SELECT
	count(LoanNumber) [Number Approved],
	SUM(CurrentApprovalAmount) [Approved Amount],
	AVG(CurrentApprovalAmount) [Average Loan],
	SUM(ForgivenessAmount) [Amount Forgiven],
	SUM(ForgivenessAmount)/SUM(CurrentApprovalAmount) * 100 [Percent Forgiven]
FROM [SBA_Proj].[dbo].[sba_public_data]
WHERE year(DateApproved) = 2021
ORDER BY 3 DESC;

-- Year and Month with the highest approvals
SELECT
	year(DateApproved) [Year Approved],
	month(DateApproved) [Month Approved],
	count(LoanNumber) [Number of Approve Loans],
	sum(InitialApprovalAmount) [Total Net Approved],
	avg(InitialApprovalAmount) [Average Loan Amount]
FROM [dbo].[sba_public_data]
group by 
	year(DateApproved),
	month(DateApproved)
ORDER BY
	4 desc