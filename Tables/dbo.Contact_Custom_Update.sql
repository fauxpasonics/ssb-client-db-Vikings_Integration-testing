CREATE TABLE [dbo].[Contact_Custom_Update]
(
[contactid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemssidwinner] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemdimcustomerids] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_number] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_legacycontactid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL CONSTRAINT [DF__Contact_C__Creat__5A4F643B] DEFAULT (getdate())
)
GO
