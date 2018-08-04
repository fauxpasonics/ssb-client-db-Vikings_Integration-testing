SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [wrk].[sp_Account_Custom]
AS 

MERGE INTO dbo.Account_Custom Target
USING dbo.[Account] source
ON source.[SSB_CRMSYSTEM_ACCT_ID] = target.[SSB_CRMSYSTEM_ACCT_ID]
WHEN NOT MATCHED THEN
INSERT ([SSB_CRMSYSTEM_ACCT_ID]) VALUES (Source.[SSB_CRMSYSTEM_ACCT_ID]);

EXEC dbo.sp_CRMProcess_ConcatIDs 'Account'

UPDATE a
SET SeasonTicket_Years = recent.SeasonTicket_Years
--SELECT *
FROM dbo.[Account_Custom] a
INNER JOIN dbo.CRMProcess_DistinctAccounts recent ON a.SSB_CRMSYSTEM_ACCT_ID = recent.SSB_CRMSYSTEM_ACCT_ID

UPDATE a
SET [Birthday] = b.[Birthday]
      ,[AddressOneStreet] = b.[AddressOneStreet] + ' ' + b.[AddressOneSuite]
      ,[AddressOneCity] = b.[AddressOneCity]
      ,[AddressOneState] = b.[AddressOneState]
      ,[AddressOneZip] = b.[AddressOneZip]
      ,[AddressOneCountry] = b.[AddressOneCountry]
FROM [dbo].[Account_Custom] a
INNER JOIN dbo.[vwCompositeRecord_ModAcctID] b ON ISNULL([b].[SSB_CRMSYSTEM_ACCT_ID],b.[SSB_CRMSYSTEM_CONTACT_ID]) = [a].[SSB_CRMSYSTEM_ACCT_ID]
INNER JOIN dbo.[vwDimCustomer_ModAcctId] c ON b.[DimCustomerId] = c.[DimCustomerId] AND c.[SSB_CRMSYSTEM_ACCT_PRIMARY_FLAG] = 1
GO
