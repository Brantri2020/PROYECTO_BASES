CREATE TABLE [dbo].[Tienda] (
  [idTienda] [int] NOT NULL,
  [tipoTienda] [varchar](50) NULL,
  [direccion] [varchar](250) NULL,
  [ciudad] [varchar](50) NULL,
  [telefono] [varchar](15) NULL,
  CONSTRAINT [PK_Tienda] PRIMARY KEY CLUSTERED ([idTienda])
)
ON [PRIMARY]
GO