CREATE TABLE [dbo].[Proveedor] (
  [idProveedor] [int] NOT NULL,
  [nombreProveedor] [varchar](50) NULL,
  [direccionProveedor] [varchar](250) NULL,
  [telefonoProveedor] [varchar](15) NULL,
  [idTienda] [int] NULL,
  CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED ([idProveedor])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship3]
  ON [dbo].[Proveedor] ([idTienda])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Proveedor] WITH NOCHECK
  ADD CONSTRAINT [Relationship3] FOREIGN KEY ([idTienda]) REFERENCES [dbo].[Tienda] ([idTienda]) NOT FOR REPLICATION
GO