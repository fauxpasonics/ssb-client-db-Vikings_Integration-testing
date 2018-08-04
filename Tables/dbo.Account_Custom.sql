CREATE TABLE [dbo].[Account_Custom]
(
[SSB_CRMSYSTEM_ACCT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SSID_Winner] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TM_Ids] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DimCustIDs] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountId] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birthday] [date] NULL,
[AddressOneStreet] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressOneCity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressOneState] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressOneZip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressOneCountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonTicket_Years] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CRMProcess_UpdatedDate] [datetime] NULL,
[GP_Ids] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[Account_Custom] ADD CONSTRAINT [PK_Account_Custom] PRIMARY KEY CLUSTERED  ([SSB_CRMSYSTEM_ACCT_ID])
GO
