CREATE TABLE [src].[Turnkey_Score]
(
[PersonID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FootballPriority] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FootballPriorityDate] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketingSystemAccountID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClientName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CopyLoadDate] [datetime] NULL CONSTRAINT [DF__Turnkey_S__CopyL__164452B1] DEFAULT (getdate())
)
GO
