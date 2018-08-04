SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[vwCRMLoad_Account_Std_Update] AS
SELECT new_ssbcrmsystemacctid, Name, address1_line1, address1_city, address1_stateorprovince, address1_postalcode, address1_country, 
telephone1, accountid, LoadType
FROM [dbo].[vwCRMLoad_Account_Std_Prep] p
LEFT JOIN vikings.dbo.vw_KeyAccounts k
ON k.SSBID = p.new_ssbcrmsystemacctid
WHERE LoadType = 'Update'
AND k.ssid IS null



GO
