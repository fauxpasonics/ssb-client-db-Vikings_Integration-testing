SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [MERGEPROCESS_New].[UpdateContact_MergedFlag]

AS

--	update winning record
UPDATE A
SET A.MergeComplete = 1,
	A.MergeComment = CASE WHEN c.ErrorMessage IS NULL THEN CONCAT('Merge completed on ',C.ProcessDate,' by SSB.')
						WHEN C.ErrorMessage LIKE '%Does Not Exist%' OR C.ErrorMessage LIKE '%is deactive%'
									THEN CONCAT('Merge not possible, entity is deleted. Attempted on: ',C.ProcessDate,'') END
FROM MERGEPROCESS_New.DetectedMerges A
JOIN MERGEPROCESS_New.[Queue] B
	ON A.PK_MergeID = B.FK_MergeID
	AND A.MergeType = B.ObjectType
	AND A.MergeType = 'Contact'
JOIN MERGEPROCESS_New.ContactMerge_ProcessLog C
	ON C.contactid = B.Loser_ID 

;

----	update losing record
--UPDATE A
--SET A.MergeComplete = 1,
--	A.MergeComment = CONCAT('Merge completed on ',C.ProcessDate,' by SSB.')
--FROM MERGEPROCESS_New.DetectedMerges A
--JOIN MERGEPROCESS_New.[Queue] B
--	ON A.PK_MergeID = B.FK_MergeID
--	AND A.MergeType = B.ObjectType
--	AND A.MergeType = 'Contact'
--JOIN MERGEPROCESS_New.ContactMerge_ProcessLog C
--	ON C.losing_contactid = B.Loser_ID
--WHERE C.ErrorMessage IS NULL
--OR (C.ErrorMessage LIKE '%CRM service call returned an error: sub-entity%'
--	AND C.ErrorMessage LIKE '%is deactive%')
--;










GO
