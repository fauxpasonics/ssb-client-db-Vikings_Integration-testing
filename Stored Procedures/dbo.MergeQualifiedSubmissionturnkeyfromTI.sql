SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


CREATE PROCEDURE [dbo].[MergeQualifiedSubmissionturnkeyfromTI] 


AS

BEGIN
	SET NOCOUNT ON;

SELECT vTF.SSID AS CustomerID,vTF.SourceSystem AS clientname INTO #Qualifiedturnkey
FROM dbo.vwTurnKey_Qualified vTF
LEFT OUTER JOIN dbo.TurnkeyQualifiedSubmissions qs
ON qs.CustomerID=vTF.SSID
WHERE qs.CustomerID IS NULL

MERGE INTO [dbo].[TurnkeyQualifiedSubmissions]  AS target
USING #Qualifiedturnkey  AS SOURCE 
ON  SOURCE.CustomerID=target.CustomerID 
WHEN NOT MATCHED
 THEN INSERT 
(
 TC_ID,
CustomerID,
ClientName,
[FileName],
SubmitDate,
ReceiveDate,
LastModifiedDate
)

VALUES
(
0,
source.CustomerID,
clientname,
'0',
GETDATE(),
NULL,
GETDATE()
);

END









GO
