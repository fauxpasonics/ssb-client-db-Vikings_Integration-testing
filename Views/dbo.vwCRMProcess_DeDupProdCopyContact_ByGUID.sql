SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vwCRMProcess_DeDupProdCopyContact_ByGUID]
AS

SELECT 'Test' Test

/*
SELECT SSB_CRMSYSTEM_CONTACT_ID__c, id, CreatedDate, CreatedById, RANK() OVER (PARTITION BY SSB_CRMSYSTEM_CONTACT_ID__c ORDER BY CreatedDate ASC) Rank
FROM prodcopy.[vw_Contact]
WHERE SSB_CRMSYSTEM_CONTACT_ID__c IS NOT NULL
*/

GO
