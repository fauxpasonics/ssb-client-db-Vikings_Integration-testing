SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/*****		Revision History

2017-05-18 by DCH:		created sproc to populate table dbo.Contact_Custom_Update, which replaces view dbo.vwCRMLoad_Contact_Custom_Update.


*****/



CREATE PROCEDURE [dbo].[Load_Contact_Custom_Update]
AS

BEGIN


TRUNCATE TABLE dbo.Contact_Custom_Update;


WITH FirstStep as (
	SELECT z.crm_id as contactid
		, b.SSID_Winner as new_ssbcrmsystemssidwinner
		, b.DimCustIDs as new_ssbcrmsystemdimcustomerids
		, b.AccountId as str_number
		, b.new_legacycontactid as new_legacycontactid
		, convert(binary(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(b.SSID_Winner)),'')))	as Hash_SSID_Winner
		, convert(binary(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(b.DimCustIDs)),'')))	as Hash_DimCustIDs
		, convert(binary(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(b.AccountId)),'')))	as Hash_AccountId
		, convert(binary(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(c.new_ssbcrmsystemssidwinner)),'')))		as Hash_new_ssbcrmsystemssidwinner
		, convert(binary(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(c.new_ssbcrmsystemdimcustomerids)),'')))	as Hash_new_ssbcrmsystemdimcustomerids
		, convert(binary(32),HASHBYTES('SHA2_256', ISNULL(LTRIM(RTRIM(c.str_number)),'')))						as Hash_str_number
	FROM dbo.Contact_Custom b 
	INNER JOIN dbo.Contact z
		ON b.SSB_CRMSYSTEM_CONTACT_ID = z.SSB_CRMSYSTEM_CONTACT_ID
	LEFT JOIN prodcopy.vw_contact c
		ON z.crm_id = c.contactID
	LEFT JOIN vikings.dbo.vw_KeyAccounts k
		ON k.SSBID = b.SSB_CRMSYSTEM_CONTACT_ID
	WHERE z.SSB_CRMSYSTEM_CONTACT_ID <> z.crm_id
	AND k.ssid IS NULL
)
INSERT dbo.Contact_Custom_Update (contactid, new_ssbcrmsystemssidwinner, new_ssbcrmsystemdimcustomerids, str_number, new_legacycontactid, CreatedDate)
SELECT contactid
		, new_ssbcrmsystemssidwinner
		, new_ssbcrmsystemdimcustomerids
		, str_number
		, new_legacycontactid
		, GETDATE()
FROM FirstStep
WHERE (Hash_SSID_Winner <> Hash_new_ssbcrmsystemssidwinner
	OR Hash_DimCustIDs <> Hash_new_ssbcrmsystemdimcustomerids
	OR Hash_AccountId <> Hash_str_number)



END

GO
