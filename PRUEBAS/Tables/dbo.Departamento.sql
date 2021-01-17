CREATE TABLE [dbo].[Departamento] (
  [idDepartamento] [int] NOT NULL,
  [nombreDepartamento] [varchar](50) NULL,
  [telefonoDepartamento] [varchar](15) NULL,
  [idTienda] [int] NULL,
  CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED ([idDepartamento])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship1]
  ON [dbo].[Departamento] ([idTienda])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Departamento] WITH NOCHECK
  ADD CONSTRAINT [Relationship1] FOREIGN KEY ([idTienda]) REFERENCES [dbo].[Tienda] ([idTienda]) NOT FOR REPLICATION
GO