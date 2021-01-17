CREATE TABLE [dbo].[Cliente] (
  [idCliente] [int] NOT NULL,
  [cedulaCliente] [varchar](15) NULL,
  [nombreCliente] [varchar](50) NULL,
  [apellidoCliente] [varchar](50) NULL,
  [telefonoCliente] [varchar](15) NULL,
  [direccionCliente] [varchar](250) NULL,
  [fechaNacimientoCliente] [date] NULL,
  [idTienda] [int] NULL,
  CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED ([idCliente])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship4]
  ON [dbo].[Cliente] ([idTienda])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cliente] WITH NOCHECK
  ADD CONSTRAINT [Relationship4] FOREIGN KEY ([idTienda]) REFERENCES [dbo].[Tienda] ([idTienda]) NOT FOR REPLICATION
GO