SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_CRMLoad_ReadResults_XML]
@ResultCategory VARCHAR(50)
AS
--EXEC dbo.sp_CRMLoad_SaveResults 'Account_Custom'
DECLARE @RootDir VARCHAR(500)
SET @RootDir = '/Root/' + @ResultCategory
DECLARE @XML XML
DECLARE @docHandle int
DECLARE @xmlDocument nvarchar(4000)
SET @XML = (SELECT TOP 1 XML_Results FROM dbo.[CRMLoad_SaveResults_Archived] WHERE [ResultCategory] = @ResultCategory) -- FOR XML AUTO) --RAW('Account_Custom'), ELEMENTS, ROOT('Root'))
SELECT @XML
exec sp_xml_preparedocument @docHandle out, @xml, '<row xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>'

IF @ResultCategory = 'Account_Std'
SELECT * FROM OPENXML(@docHandle, @RootDir,2)
WITH dbo.[Account_CRMResults]

IF @ResultCategory = 'Account_Custom'
SELECT * FROM OPENXML(@docHandle, @RootDir,2)
WITH dbo.[Account_Custom_CRMResults]
--(
--[SSB_CRMSYSTEM_ACCT_ID__c] [varchar] (50) ,
--[Name] [nvarchar] (300) ,
--[BillingStreet] [nvarchar] (500) ,
--[BillingCity] [nvarchar] (200) ,
--[BillingState] [nvarchar] (200) ,
--[BillingCountry] [nvarchar] (200) ,
--[Phone] [nvarchar] (25) ,
--[BillingPostalCode] [nvarchar] (25) ,
--[SalesForceId] [nvarchar] (18) ,
--[RowResult] [nvarchar] (10) ,
--[ErrorCode] [int] ,
--[ErrorColumn] [int] ,
--[ErrorDescription] [nvarchar] (1024) ,
--[ResultDateTime] [datetime] 
--) 

EXEC sp_xml_removedocument @docHandle

GO
