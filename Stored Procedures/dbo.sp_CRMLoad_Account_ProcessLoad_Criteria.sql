SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[sp_CRMLoad_Account_ProcessLoad_Criteria]
AS 

-- Assign CRM IDs in dbo.Account
--EXEC dbo.sp_CRMProcess_CRMID_Assign_Account

TRUNCATE TABLE dbo.[CRMLoad_Account_ProcessLoad_Criteria]

INSERT INTO dbo.[CRMLoad_Account_ProcessLoad_Criteria]
        ( [SSB_CRMSYSTEM_ACCT_ID] ,
          LoadType
        )
SELECT DISTINCT a.[SSB_CRMSYSTEM_ACCT_ID]
, CASE WHEN 1=1 --b.accountid IS NULL 
AND a.[SSB_CRMSYSTEM_ACCT_ID] = b.[crm_id] THEN 'Upsert' ELSE 'Update' END LoadType
FROM wrk.[customerWorkingList] a 
INNER JOIN dbo.Account b ON a.[SSB_CRMSYSTEM_ACCT_ID] = b.[SSB_CRMSYSTEM_ACCT_ID]
--LEFT JOIN ProdCopy.[vw_Account] b ON a.[SSB_CRMSYSTEM_ACCT_ID] = b.[new_ssbcrmsystemacctid]
--WHERE [a].[IsBusinessAccount] = 1


GO
