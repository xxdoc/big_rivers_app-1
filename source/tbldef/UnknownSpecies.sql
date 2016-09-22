CREATE TABLE [UnknownSpecies] (
  [ID] AUTOINCREMENT,
  [UnknownCode] VARCHAR (15) CONSTRAINT [UnknownCode] UNIQUE ,
  [CollectedBy_ID] LONG ,
  [Method] VARCHAR (50),
  [Location_ID] LONG ,
  [PlantType] VARCHAR (15),
  [PlantDescription] LONGTEXT ,
  [SalientFeature] VARCHAR (255),
  [LeafType] VARCHAR (50),
  [LeafMargin] VARCHAR (50),
  [LeafCharacteristics] VARCHAR (255),
  [StemCharacteristics] VARCHAR (255),
  [FlowerCharacteristics] VARCHAR (255),
  [GeneralCharacteristics] VARCHAR (255),
  [Collected] BYTE ,
  [BestGuess] VARCHAR (50),
  [ConfirmedCode] VARCHAR (50),
  [HasPhotos] BYTE ,
  [ForbGrassType] VARCHAR (10),
  [PerennialGrasses] VARCHAR (15),
  [IdentifiedBy_ID] LONG ,
  [IdentifiedDate] DATETIME ,
  [Position] SHORT 
)
