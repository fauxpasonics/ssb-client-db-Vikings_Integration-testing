SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


CREATE VIEW [dbo].[vwTurnkeyNightlyBusinessFile] 

AS

SELECT  
ts.CustomerID AS TicketingAccountID,
DC.SSB_CRMSYSTEM_CONTACT_ID AS PersonID,
DC.Firstname AS FirstName,
DC.LastName AS LastName,
COALESCE(DC.EmailOne, DC.EmailTwo) AS WorkEmailAddress,
COALESCE(FullName,DC.FirstName + ' ' + DC.Lastname) Business_Name,
DC.[AddressPrimaryStreet] AS BusinessAddress1,
DC.[AddressPrimaryCity] AS BusinessCity,
DC.[AddressPrimaryState] AS BusinessState,
DC.[AddressPrimaryZip] AS BusinessPostalCode,
DC.[AddressPrimaryCountry] AS BusinessCountry,
DC.[PhoneBusiness] AS Phone
FROM [dbo].[vwDimCustomer_ModAcctId] DC
INNER JOIN dbo.TurnkeyQualifiedSubmissions ts
ON dc.SSID = ts.CustomerID AND ts.ClientName=dc.SourceSystem
WHERE dc.isbusiness = 1
AND ts.SubmitDate >= (SELECT MAX(SubmitDate) FROM dbo.TurnkeyQualifiedSubmissions)
GO
