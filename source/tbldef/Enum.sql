CREATE TABLE [Enum] (
  [ID] AUTOINCREMENT CONSTRAINT [PrimaryKey] PRIMARY KEY  UNIQUE  NOT NULL ,
  [EnumType] VARCHAR (25),
  [Label] VARCHAR (255),
  [Summary] VARCHAR (255),
  [Sequence] SHORT 
)
