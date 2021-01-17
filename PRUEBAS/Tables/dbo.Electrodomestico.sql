CREATE TABLE [dbo].[Electrodomestico] (
  [idElectrodomestico] [int] NOT NULL,
  [nombreElectrodomestico] [varchar](100) NULL,
  [stockElectrodomestico] [int] NULL,
  [idTienda] [int] NULL,
  [idProveedor] [int] NULL,
  CONSTRAINT [PK_Electrodomestico] PRIMARY KEY CLUSTERED ([idElectrodomestico])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship15]
  ON [dbo].[Electrodomestico] ([idTienda])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship25]
  ON [dbo].[Electrodomestico] ([idProveedor])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Electrodomestico] WITH NOCHECK
  ADD CONSTRAINT [Relationship15] FOREIGN KEY ([idTienda]) REFERENCES [dbo].[Tienda] ([idTienda]) NOT FOR REPLICATION
GO

ALTER TABLE [dbo].[Electrodomestico]
  ADD CONSTRAINT [Relationship25] FOREIGN KEY ([idProveedor]) REFERENCES [dbo].[Proveedor] ([idProveedor])
GO