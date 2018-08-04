SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vwCRMLoad_Contact_Std_Upsert] AS
SELECT a.new_ssbcrmsystemacctid, a.new_ssbcrmsystemcontactid, a.Prefix, a.FirstName, a.LastName, a.Suffix, a.address1_line1, a.address1_city, a.address1_stateorprovince, a.address1_postalcode, a.address1_country
, a.telephone1, LoadType, a.emailaddress1
FROM [dbo].[vwCRMLoad_Contact_Std_Prep] a
JOIN dbo.contact_custom b ON a.new_ssbcrmsystemcontactid = b.ssb_Crmsystem_Contact_ID
--left join prodcopy.vw_contact c on b.account_id = c.Str_number
--left join prodcopy.vw_contact d on a.new_ssbcrmsystemcontactid = d.new_ssbcrmsystemcontactid
WHERE LoadType = 'Upsert'
--and c.contactid is null
--AND d.contactid is null





GO
