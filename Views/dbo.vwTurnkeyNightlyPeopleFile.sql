SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


CREATE VIEW [dbo].[vwTurnkeyNightlyPeopleFile] 

AS

SELECT  
ts.CustomerID AS TicketingAccountID,
DC.SSB_CRMSYSTEM_CONTACT_ID AS PersonID,
DC.Firstname AS FirstName,
DC.LastName AS LastName,
DC.[AddressPrimaryStreet] AS Address1,
NULL AS Address2,
DC.[AddressPrimaryCity] AS City,
DC.[AddressPrimaryState] AS [STATE],
DC.[AddressPrimaryZip] AS PostalCode,
DC.[AddressPrimaryCountry] AS Country,
COALESCE(DC.EmailOne, DC.EmailTwo) AS Email,
DC.[PhoneHome] AS HomePhone,
DC.[PhoneCell] AS MobilePhone
FROM dbo.vwDimCustomer_ModAcctId DC
INNER JOIN dbo.TurnkeyQualifiedSubmissions ts
ON dc.ssid = ts.CustomerID AND ts.ClientName = dc.sourcesystem
WHERE dc.isbusiness = 0
AND ts.SubmitDate >= (SELECT MAX(SubmitDate) FROM dbo.TurnkeyQualifiedSubmissions)





GO
