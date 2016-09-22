CREATE TABLE [tsys_Logins] (
  [TimeStamp] DATETIME ,
  [UserName] VARCHAR (50),
  [ActionTaken] VARCHAR (50),
  [ReleaseNumber] VARCHAR (20),
  [AccessLevel] VARCHAR (25),
   CONSTRAINT [pk_tsys_Logins] PRIMARY KEY ([UserName], [TimeStamp])
)
