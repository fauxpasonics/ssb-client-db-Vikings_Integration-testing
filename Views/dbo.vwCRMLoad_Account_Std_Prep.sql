SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[vwCRMLoad_Account_Std_Prep]
AS 
SELECT
	  a.[SSB_CRMSYSTEM_ACCT_ID] new_ssbcrmsystemacctid
      ,[FullName] Name
      ,[AddressPrimaryStreet] address1_line1
      ,[AddressPrimaryCity] address1_city
      ,[AddressPrimaryState] address1_stateorprovince
      ,[AddressPrimaryZip] address1_postalcode
      ,[AddressPrimaryCountry] address1_country
      ,[Phone] telephone1
      ,[crm_id] accountid
	  ,c.[LoadType]
  FROM [dbo].[Account] a 
INNER JOIN dbo.[CRMLoad_Account_ProcessLoad_Criteria] c ON [c].[SSB_CRMSYSTEM_ACCT_ID] = [a].[SSB_CRMSYSTEM_ACCT_ID]
WHERE [c].[ObjectType] = 'Account_Std'




GO
