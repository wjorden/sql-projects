/* Duplicate NAICS Code table */
-- Check db
SELECT * FROM [dbo].[sba_naics_sector_code_description] ORDER BY [Lookup Codes];

-- Add missing codes
INSERT INTO [dbo].[sba_naics_sector_code_description]
	VALUES	('Sector 31 - 33 - Manufacturing', 32, 'Manufacturing'),
			('Sector 31 - 33 - Manufacturing', 33, 'Manufacturing'),
			('Sector 44 - 45 - Retail Trade', 45, 'Retail Trade'),
			('Sector 48 - 49 - Transportation and Warehousing', 49, 'Transportation and Warehousing');

-- General fixes for Sector
update [dbo].[sba_naics_sector_code_description]
SET Sector = 'Manufacturing'
WHERE [Lookup Codes]= 31;

update [dbo].[sba_naics_sector_code_description]
SET Sector = 'Retail Trade'
WHERE [Lookup Codes]= 44;

update [dbo].[sba_naics_sector_code_description]
SET Sector = 'Transportation and Warehousing'
WHERE [Lookup Codes]= 48;


