SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE VIEW [dbo].[vwCRMLoad_Contact_Custom_Update]
AS

--WITH FirstStep AS (
--	SELECT z.crm_id AS contactid
--		, b.SSID_Winner AS new_ssbcrmsystemssidwinner
--		, b.DimCustIDs AS new_ssbcrmsystemdimcustomerids
--		, b.AccountId AS str_number
--		, b.new_legacycontactid AS new_legacycontactid
--		, CONVERT(BINARY(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(b.SSID_Winner)),'')))	AS Hash_SSID_Winner
--		, CONVERT(BINARY(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(b.DimCustIDs)),'')))	AS Hash_DimCustIDs
--		, CONVERT(BINARY(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(b.AccountId)),'')))	AS Hash_AccountId
--		, CONVERT(BINARY(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(c.new_ssbcrmsystemssidwinner)),'')))		AS Hash_new_ssbcrmsystemssidwinner
--		, CONVERT(BINARY(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(c.new_ssbcrmsystemdimcustomerids)),'')))	AS Hash_new_ssbcrmsystemdimcustomerids
--		, CONVERT(BINARY(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(c.str_number)),'')))						AS Hash_str_number
--	FROM dbo.Contact_Custom b 
--	INNER JOIN dbo.Contact z
--		ON b.SSB_CRMSYSTEM_CONTACT_ID = z.SSB_CRMSYSTEM_CONTACT_ID
--	LEFT JOIN prodcopy.vw_contact c
--		ON z.crm_id = c.contactID
--	LEFT JOIN vikings.dbo.vw_KeyAccounts k
--		ON k.SSBID = b.SSB_CRMSYSTEM_CONTACT_ID
--	WHERE z.SSB_CRMSYSTEM_CONTACT_ID <> z.crm_id
--	AND k.ssid IS NULL
--)
--SELECT contactid
--		, new_ssbcrmsystemssidwinner
--		, new_ssbcrmsystemdimcustomerids
--		, str_number
--		, new_legacycontactid
--FROM FirstStep
--WHERE (1 = 2
--	OR Hash_SSID_Winner <> Hash_new_ssbcrmsystemssidwinner
--	OR Hash_DimCustIDs <> Hash_new_ssbcrmsystemdimcustomerids
--	OR Hash_AccountId <> Hash_str_number)


SELECT z.crm_id AS contactid
		, b.SSID_Winner AS new_ssbcrmsystemssidwinner			--,c.new_ssbcrmsystemssidwinner
		, b.DimCustIDs AS new_ssbcrmsystemdimcustomerids		--,c.new_ssbcrmsystemdimcustomerids
		, b.AccountId AS str_number								--,c.str_number
		, b.new_legacycontactid AS new_legacycontactid			 
	FROM dbo.Contact_Custom b 
	INNER JOIN dbo.Contact z
		ON b.SSB_CRMSYSTEM_CONTACT_ID = z.SSB_CRMSYSTEM_CONTACT_ID
	LEFT JOIN prodcopy.vw_contact c
		ON z.crm_id = c.contactID
	LEFT JOIN vikings.dbo.vw_KeyAccounts k
		ON k.SSBID = b.SSB_CRMSYSTEM_CONTACT_ID
	WHERE z.SSB_CRMSYSTEM_CONTACT_ID <> z.crm_id
	AND k.ssid IS NULL
	AND (1=2
	OR ISNULL( b.SSID_Winner, '') != isnull(new_ssbcrmsystemssidwinner, '')	
	OR	ISNULL(b.DimCustIDs , '') != isnull(new_ssbcrmsystemdimcustomerids, '')
	OR	ISNULL(b.AccountId , '') != isnull(str_number, '')			
		
		
		)			


GO
