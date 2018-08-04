CREATE TABLE [dbo].[Account_Custom_CRMResults]
(
[SSB_CRMSYSTEM_SSID_Winner__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_FullArchitcs_IDs__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_RaidersImg_IDs__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_DimCustomerIDs__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_Archtics_Acct_IDs__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birthday] [date] NULL,
[SSB_CRMSYSTEM_STH_Years__c] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ArchticsFlag__c] [int] NULL,
[SSB_CRMSYSTEM_RaidersImgFlag__c] [int] NULL,
[SSB_CRMSYSTEM_STH_Flag__c] [int] NULL,
[Update.Id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShippingStreet] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShippingCity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShippingState] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShippingPostalCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShippingCountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorCode] [int] NULL,
[ErrorColumn] [int] NULL,
[Update SF Dest.Id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorDescription] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResultDateTime] [datetime] NULL CONSTRAINT [DF__Account_C__Resul__6AEFE058] DEFAULT (getdate()),
[new_ssbcrmsystemssidwinner] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemdimcustomerids] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemarchticsids] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
