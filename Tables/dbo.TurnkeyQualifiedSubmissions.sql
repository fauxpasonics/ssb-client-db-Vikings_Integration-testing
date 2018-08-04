CREATE TABLE [dbo].[TurnkeyQualifiedSubmissions]
(
[TC_ID] [int] NULL,
[CustomerID] [varchar] (5000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ClientName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmitDate] [datetime] NULL,
[ReceiveDate] [date] NULL,
[ReSubmitDate] [date] NULL,
[LastModifiedDate] [datetime] NULL,
[FILENAME] [nvarchar] (225) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[TurnkeyQualifiedSubmissions] ADD CONSTRAINT [PK_turnkey_submission] PRIMARY KEY CLUSTERED  ([CustomerID], [FILENAME])
GO
