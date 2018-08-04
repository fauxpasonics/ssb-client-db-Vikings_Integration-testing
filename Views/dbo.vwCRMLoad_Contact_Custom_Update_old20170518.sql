SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[vwCRMLoad_Contact_Custom_Update_old20170518]
AS
SELECT  z.[crm_id] contactid
, SSID_Winner [new_ssbcrmsystemssidwinner]
--, TM_Ids [new_ssbcrmsystemarchticsids]
, DimCustIDs [new_ssbcrmsystemdimcustomerids]
--, b.[Archtics_Account_Winner] [new_TMaccountid]
, b.AccountId str_number
, b.new_legacycontactid AS new_legacycontactid
-- SELECT *
-- SELECT COUNT(*) 
FROM dbo.[Contact_Custom] b 
INNER JOIN dbo.Contact z ON b.SSB_CRMSYSTEM_CONTACT_ID = z.[SSB_CRMSYSTEM_CONTACT_ID]
LEFT JOIN  prodcopy.vw_contact c ON z.[crm_id] = c.contactID
LEFT JOIN vikings.dbo.vw_KeyAccounts k
ON k.SSBID = b.SSB_CRMSYSTEM_CONTACT_ID
--INNER JOIN dbo.CRMLoad_Contact_ProcessLoad_Criteria pl ON b.SSB_CRMSYSTEM_CONTACT_ID = pl.SSB_CRMSYSTEM_CONTACT_ID
WHERE z.[SSB_CRMSYSTEM_CONTACT_ID] <> z.[crm_id]
AND k.ssid IS null
AND  (HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(  b.SSID_Winner AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( c.[new_ssbcrmsystemssidwinner] AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.DimCustIDs AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(  c.[new_ssbcrmsystemdimcustomerids] AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( b.AccountId AS VARCHAR(MAX)))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST( c.str_number AS VARCHAR(MAX)))),''))
	)
--	--AND z.crm_ID = '11C16ADB-75A1-E611-80E8-FC15B428DA60'





GO
