SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [MERGEPROCESS_New].[MergeDetect_MSCRM] --'Vikings'
	@Client VARCHAR(100) 
AS
Declare @Date Date = (select cast(getdate() as date));
DECLARE @Account VARCHAR(100) = (SELECT CASE WHEN @client = 'Vikings' THEN 'CRM_Account' ELSE CONCAT(@client,' PC_SFDC Account' ) END);
DECLARE @Contact VARCHAR(100) = (SELECT CASE WHEN @client = 'Vikings' THEN 'CRM_Contact' ELSE CONCAT(@client,' PC_SFDC Account' ) END);

WITH 
--MergeAccount AS (
--SELECT SSB_CRMSYSTEM_ACCT_ID, COUNT(1) CountAccounts, MAX(CASE WHEN b.SSID IS NOT NULL THEN 1 ELSE 0 END) Key_Related
--FROM dbo.vwDimCustomer_ModAcctID a
--LEFT JOIN dbo.vw_KeyAccounts b
--	ON a.dimcustomerid = b.dimcustomerid
--JOIN prodcopy.vw_account c							
--	ON a.SSID = c.accountid							
--	AND a.SourceSystem = @Account					
--WHERE a.SourceSystem = @Account
--AND c.merged = 0									
--AND c.statuscode = 1								
--GROUP BY SSB_CRMSYSTEM_ACCT_ID
--HAVING COUNT(1) > 1), 

 MergeContact AS (
SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(1) CountContacts, MAX(CASE WHEN b.ID IS NOT NULL THEN 1 ELSE 0 END) Key_Related
FROM Vikings.dbo.vwDimCustomer_ModAcctID a 
LEFT JOIN (
	SELECT CAST(cc.contactid AS VARCHAR(100)) ID
	FROM Vikings_Reporting.prodcopy.Contact cc (NOLOCK)
	JOIN Vikings.dbo.vw_KeyAccounts bb
		ON CAST(cc.contactid AS VARCHAR(100)) = CAST(bb.SSID AS VARCHAR(100))
	AND cc.merged = 0									
	AND cc.statuscode = 1								
	) b		
	ON a.SSID = b.ID
WHERE SourceSystem = @Contact
GROUP BY SSB_CRMSYSTEM_CONTACT_ID
HAVING COUNT(1) > 1)


MERGE  MERGEPROCESS_New.DetectedMerges  AS tar
USING ( 
		--SELECT 'Account' MergeType, SSB_CRMSYSTEM_ACCT_ID SSBID, CASE WHEN CountAccounts = 2 AND Key_Related = 0 THEN 1 ELSE 0 END AutoMerge, @Date DetectedDate, CountAccounts NumRecords FROM MergeAccount
		--UNION ALL
		SELECT 'Contact' MergeType, SSB_CRMSYSTEM_Contact_ID SSBID, CASE WHEN CountContacts = 2 AND Key_Related = 0 THEN 1 ELSE 0 END AutoMerge, @Date DetectedDate, CountContacts NumRecords FROM MergeContact) AS sour
	ON tar.MergeType = sour.MergeType
	AND tar.SSBID = sour.SSBID
WHEN MATCHED  AND (tar.DetectedDate <> sour.DetectedDate 
				OR sour.NumRecords <> tar.NumRecords
				OR sour.AutoMerge <> tar.AutoMerge) THEN UPDATE 
	SET DetectedDate = @Date
	,NumRecords = sour.NumRecords
	,AutoMerge = sour.AutoMerge
WHEN NOT MATCHED THEN INSERT
	(MergeType
	,SSBID
	,AutoMerge
	,DetectedDate
	,NumRecords)
VALUES(
	 sour.MergeType
	,sour.SSBID
	,sour.AutoMerge
	,sour.DetectedDate
	,sour.NumRecords)
WHEN NOT MATCHED BY SOURCE AND tar.MergeComment IS NULL AND tar.mergeComplete = 0 THEN UPDATE
	SET MergeComment = 'Merge Detection - Merge not completed, but not longer detected' 
	;



GO
