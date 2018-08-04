SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[sp_CRMLoad__ProcessLoad_Criteria_Main]
AS 

EXEC [dbo].[sp_CRMLoad_Account_ProcessLoad_Criteria]

EXEC [dbo].[sp_CRMLoad_Contact_ProcessLoad_Criteria]

GO
