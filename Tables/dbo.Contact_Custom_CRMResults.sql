CREATE TABLE [dbo].[Contact_Custom_CRMResults]
(
[contactid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemssidwinner] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemdimcustids] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_number] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CrmRecordId] [uniqueidentifier] NULL,
[IsNew] [bit] NULL,
[ErrorCode] [int] NULL,
[ErrorColumn] [int] NULL,
[CrmErrorMessage] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResultDateTime] [datetime] NULL CONSTRAINT [DF__Contact_C__Resul__7F2BE32F] DEFAULT (getdate())
)
GO
