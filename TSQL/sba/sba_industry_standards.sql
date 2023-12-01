/* Cleaning Sector Codes */
-- Check db
SELECT *
FROM [dbo].[sba_industry_standards];

-- Fix encoding issue
UPDATE [dbo].[sba_industry_standards]
SET [NAICS_Industry_Description] = replace([NAICS_Industry_Description], '–', '-')

-- Move codes to a duplicate table
SELECT *
INTO sba_naics_sector_code_description
FROM(
	SELECT [NAICS_Industry_Description],
		iif([NAICS_Industry_Description] like '%-%', SUBSTRING([NAICS_Industry_Description], 8, 2), '') [Lookup Codes],
		iif([NAICS_Industry_Description] like '%-%', ltrim(SUBSTRING([NAICS_Industry_Description], CHARINDEX('-', [NAICS_Industry_Description]) + 1, LEN([NAICS_Industry_Description]))), '') [Sector]
	FROM [SBA_Proj].[dbo].[sba_industry_standards]
	WHERE [NAICS_Codes] = ''
) main
	WHERE
		[Lookup Codes] != ''