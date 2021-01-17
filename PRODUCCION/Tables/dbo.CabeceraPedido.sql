CREATE TABLE [dbo].[CabeceraPedido] (
  [idCabeceraPedido] [int] NOT NULL,
  [idCliente] [int] NULL,
  [idEmpleado] [int] NULL,
  [idTienda] [int] NULL,
  [fechaPedido] [date] NULL,
  [totalFactura] [money] NULL CONSTRAINT [DF_CabeceraPedido_totalFactura] DEFAULT (0.00),
  CONSTRAINT [PK_CabeceraPedido] PRIMARY KEY CLUSTERED ([idCabeceraPedido])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship11]
  ON [dbo].[CabeceraPedido] ([idCliente])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship14]
  ON [dbo].[CabeceraPedido] ([idEmpleado])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship22]
  ON [dbo].[CabeceraPedido] ([idTienda])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_EliminarCabecera]
	ON [CabeceraPedido] INSTEAD OF DELETE
	AS
	DECLARE
	@idCabeceraPedido INT,
	@contador INT,
	@bandera INT
	SELECT
	@idCabeceraPedido=idCabeceraPedido
	FROM DELETED
	SELECT 
	@contador=COUNT(idCabeceraPedido)
	FROM dbo.CuerpoPedido
	WHERE @idCabeceraPedido=@idCabeceraPedido
	SET @bandera=1
	WHILE(@bandera<=@contador)
	BEGIN
	DELETE 
	FROM
	CuerpoPedido
	WHERE
	idCabeceraPedido=@idCabeceraPedido
	SET @contador=@contador-1
	END
	DELETE FROM dbo.CabeceraPedido
	WHERE idCabeceraPedido=@idCabeceraPedido
GO

ALTER TABLE [dbo].[CabeceraPedido] WITH NOCHECK
  ADD CONSTRAINT [Relationship11] FOREIGN KEY ([idCliente]) REFERENCES [dbo].[Cliente] ([idCliente]) NOT FOR REPLICATION
GO

ALTER TABLE [dbo].[CabeceraPedido]
  ADD CONSTRAINT [Relationship14] FOREIGN KEY ([idEmpleado]) REFERENCES [dbo].[Empleado] ([idEmpleado])
GO

ALTER TABLE [dbo].[CabeceraPedido] WITH NOCHECK
  ADD CONSTRAINT [Relationship22] FOREIGN KEY ([idTienda]) REFERENCES [dbo].[Tienda] ([idTienda]) NOT FOR REPLICATION
GO