SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [MERGEPROCESS_New].[vwMergeAccountRanks]

AS

SELECT a.SSBID
	, c.Accountid ID
	--Add in custom ranking here
	,ROW_NUMBER() OVER(PARTITION BY SSBID ORDER BY CASE WHEN owneridname = 'SSB Vendor' THEN 0 
		WHEN owneridname = 'CRM Admin' THEN 1  ELSE 99 END DESC, c.createdon, c.Modifiedon DESC) xRank
FROM MERGEPROCESS_New.DetectedMerges a
JOIN dbo.vwDimCustomer_ModAcctID b 
	ON a.SSBID = b.SSB_CRMSYSTEM_ACCT_ID
	AND a.MergeType = 'Account'
JOIN Prodcopy.vw_Account c
	ON b.SSID = CAST(c.accountid AS NVARCHAR(100))
	--AND c.statuscodename = 'Active'
WHERE MergeComplete = 0;






GO
