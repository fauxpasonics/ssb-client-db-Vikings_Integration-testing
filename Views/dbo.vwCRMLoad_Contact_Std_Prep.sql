SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vwCRMLoad_Contact_Std_Prep]
AS 
SELECT
	  a.[SSB_CRMSYSTEM_ACCT_ID] new_ssbcrmsystemacctid
	  , a.[SSB_CRMSYSTEM_CONTACT_ID] new_ssbcrmsystemcontactid
	  , a.[Prefix]
      , a.[FirstName]
	  , a.[LastName]
	  , LEFT(a.[Suffix],10)  [Suffix]
      ,a.[AddressPrimaryStreet] address1_line1
      ,a.[AddressPrimaryCity] address1_city
      ,a.[AddressPrimaryState] address1_stateorprovince
      ,a.[AddressPrimaryZip] address1_postalcode
      ,a.[AddressPrimaryCountry] address1_country
      ,a.[Phone] telephone1
      ,a.[crm_id] contactid
	  ,a.EmailPrimary emailaddress1
	  --,b.[crm_id] AccountId
	  ,c.[LoadType]
  FROM [dbo].Contact a 
  --INNER JOIN dbo.Account b ON [b].[SSB_CRMSYSTEM_ACCT_ID] = [a].[SSB_CRMSYSTEM_ACCT_ID] AND b.[SSB_CRMSYSTEM_ACCT_ID] <> b.[crm_id]
INNER JOIN dbo.[CRMLoad_Contact_ProcessLoad_Criteria] c ON [c].[SSB_CRMSYSTEM_CONTACT_ID] = [a].[SSB_CRMSYSTEM_CONTACT_ID]
--WHERE c.ObjectType = 'Contact_Std'
--WHERE crm_ID = '11C16ADB-75A1-E611-80E8-FC15B428DA60'
GO
