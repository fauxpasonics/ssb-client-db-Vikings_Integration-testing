SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[vwCRMLoad_Contact_Std_Update] AS

SELECT a.new_ssbcrmsystemacctid, a.new_ssbcrmsystemcontactid, a.Prefix, a.FirstName, a.LastName, a.Suffix, a.address1_line1, a.address1_city, a.address1_stateorprovince, a.address1_postalcode, a.address1_country
, a.telephone1, a.contactid, LoadType, a.emailaddress1
FROM [dbo].[vwCRMLoad_Contact_Std_Prep] a
LEFT JOIN prodcopy.vw_contact b ON cast(a.contactid as varchar(50)) = cast(b.contactID as varchar(50))
Left join vikings.[dbo].[vw_KeyAccounts] k
		ON cast(a.contactid as varchar(50)) = cast(k.SSID as varchar(500))
WHERE LoadType = 'Update'
AND k.SSID is NULL
AND  (HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.FirstName AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.FirstName AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.LastName AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.LastName AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.Suffix AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.Suffix AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.address1_line1 AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.address1_line1 AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.address1_city AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.address1_city AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.address1_stateorprovince AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.address1_stateorprovince AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.address1_postalcode AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.address1_postalcode AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.address1_country AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.address1_country AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.telephone1 AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.telephone1 AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( a.emailaddress1 AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.emailaddress1 AS VARCHAR(MAX)))),'')) 
	)



GO
