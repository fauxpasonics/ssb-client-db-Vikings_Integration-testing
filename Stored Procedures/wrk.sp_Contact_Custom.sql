SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [wrk].[sp_Contact_Custom]
AS 

MERGE INTO dbo.Contact_Custom Target
USING dbo.Contact source
ON source.[SSB_CRMSYSTEM_CONTACT_ID] = target.[SSB_CRMSYSTEM_CONTACT_ID]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([SSB_CRMSYSTEM_ACCT_ID], [SSB_CRMSYSTEM_CONTACT_ID]) VALUES (source.[SSB_CRMSYSTEM_ACCT_ID], Source.[SSB_CRMSYSTEM_CONTACT_ID])
WHEN NOT MATCHED BY SOURCE THEN
DELETE ;

EXEC dbo.sp_CRMProcess_ConcatIDs 'Contact'

UPDATE a
SET SSID_Winner = CASE WHEN SourceSystem LIKE '%CRM%' OR SourceSystem LIKE '%SFDC%' THEN '' ELSE c.[CRM_FriendlyName] + ' - ' + b.SSID END 
FROM dbo.[Contact_Custom] a 
INNER JOIN dbo.[vwCompositeRecord_ModAcctID] b ON a.[SSB_CRMSYSTEM_CONTACT_ID] = b.[SSB_CRMSYSTEM_CONTACT_ID]
LEFT JOIN dbo.[CRMProcess_SourceSystem_Translation] c ON b.[SourceSystem] = c.[MDM_SourceSystem]

--UPDATE a
--SET SeasonTicket_Years = recent.SeasonTicket_Years
----SELECT *
--FROM dbo.[Contact_Custom] a
--INNER JOIN dbo.CRMProcess_DistinctContacts recent ON [recent].[SSB_CRMSYSTEM_CONTACT_ID] = [a].[SSB_CRMSYSTEM_CONTACT_ID]

--UPDATE a
--SET SSID_Winner = b.[SSID]
--	  --,[Birthday] = b.[Birthday]
--   --   ,[MobilePhone] = b.[PhoneCell]
--   --   ,[HomePhone] = b.[PhoneHome]
--   --   ,[Other_Phone] = b.[PhoneOther]
--   --   ,[Fax] = b.[PhoneFax]
--   --   ,[EmailOne] = b.[EmailOne]
--      --,[EmailTwo] = b.[EmailTwo]
--FROM [dbo].Contact_Custom a
--INNER JOIN dbo.[vwCompositeRecord_ModAcctID] b ON b.[SSB_CRMSYSTEM_CONTACT_ID] = [a].[SSB_CRMSYSTEM_CONTACT_ID]

EXEC  [dbo].[sp_CRMLoad_Contact_ProcessLoad_Criteria]

GO
