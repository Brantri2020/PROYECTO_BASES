CREATE TABLE [dbo].[CuerpoPedido] (
  [idCabeceraPedido] [int] NULL,
  [idElectrodomestico] [int] NULL,
  [cantidadProducto] [int] NULL,
  [precioUnitario] [money] NULL,
  [totalProducto] [money] NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship12]
  ON [dbo].[CuerpoPedido] ([idElectrodomestico])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship9]
  ON [dbo].[CuerpoPedido] ([idCabeceraPedido])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_StockDelete]
	ON [CuerpoPedido] FOR DELETE
	AS
	DECLARE 	
	@idElectrodomestico INT,
	@cantidadProducto INT
	SELECT
	@idElectrodomestico=idElectrodomestico,
	@cantidadProducto=cantidadProducto
	FROM DELETED
	UPDATE
	Electrodomestico
	SET
	stockElectrodomestico= stockElectrodomestico + @cantidadProducto
	WHERE
	idElectrodomestico=@idElectrodomestico
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_StockInsert]
	ON [CuerpoPedido] FOR INSERT
	AS
	DECLARE 	
	@idElectrodomestico INT,
	@cantidadProducto INT
	SELECT
	@idElectrodomestico=idElectrodomestico,
	@cantidadProducto=cantidadProducto
	FROM INSERTED
	UPDATE 
	Electrodomestico
	SET
	stockElectrodomestico= stockElectrodomestico-@cantidadProducto
	WHERE
	idElectrodomestico=@idElectrodomestico
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_StockUpdate]
	ON [CuerpoPedido] FOR UPDATE
	AS
	DECLARE 	
	@idElectrodomestico INT,
	@cantidadProducto INT
	SELECT
	@idElectrodomestico=idElectrodomestico,
	@cantidadProducto=cantidadProducto
	FROM DELETED
	DECLARE
	@cantidadPro INT
	SELECT
	@cantidadPro=cantidadProducto
	FROM INSERTED
	UPDATE 
	Electrodomestico
	SET
	stockElectrodomestico= stockElectrodomestico + @cantidadProducto -@cantidadPro
	WHERE
	idElectrodomestico=@idElectrodomestico
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_SumarTotal]
	ON [CuerpoPedido] FOR INSERT
	AS
	DECLARE 
	@idCabeceraPedido INT,
	@idElectrodomestico INT,
	@cantidadProducto INT,
	@precioUnitario MONEY,
	@totalUnDetalle MONEY
	SELECT
	@idCabeceraPedido=idCabeceraPedido,
	@idElectrodomestico=idElectrodomestico,
	@cantidadProducto=cantidadProducto,
	@precioUnitario=precioUnitario,
	@totalUnDetalle=cantidadProducto*precioUnitario
	FROM INSERTED
	UPDATE 
	CabeceraPedido
	SET
	totalFactura= totalFactura + @totalUnDetalle
	WHERE
	idCabeceraPedido=@idCabeceraPedido
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_SumarTotalCabeceraDelete]
	ON [CuerpoPedido] INSTEAD OF DELETE
	AS
	DECLARE 
	@idCabeceraPedido INT,
	@totalProducto MONEY,
	@idElectrodomestico INT
	SELECT
	@idCabeceraPedido=idCabeceraPedido,
	@totalProducto=totalProducto,
	@idElectrodomestico=Deleted.idElectrodomestico
	FROM DELETED
	UPDATE 
	CabeceraPedido
	SET
	totalFactura= totalFactura - @totalProducto
	WHERE
	idCabeceraPedido=@idCabeceraPedido
	DELETE FROM dbo.CuerpoPedido
	WHERE idCabeceraPedido=@idCabeceraPedido
	AND idElectrodomestico=@idElectrodomestico
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
----Actualizar

	CREATE TRIGGER [dbo].[TR_SumarTotalCabeceraUpdate]
	ON [CuerpoPedido] INSTEAD OF UPDATE
	AS
	DECLARE 
	@idCabeceraPedido INT,
	@cantidadProducto INT,
	@precioUnitario MONEY,
	@totalUnDetalle MONEY,
	@totalProducto MONEY,
	@totalFactura MONEY,
	@idElectrodomestico INT
	
	SELECT
	@idCabeceraPedido=idCabeceraPedido,
	@cantidadProducto=cantidadProducto,
	@precioUnitario=precioUnitario,
	@totalUnDetalle=@cantidadProducto*@precioUnitario,
	@idElectrodomestico=idElectrodomestico
	FROM INSERTED
	PRINT'Nuevo '+ CAST(@totalUnDetalle AS VARCHAR)

	SELECT 
	@totalProducto=totalProducto
	FROM DELETED
	PRINT'Viejo '+ CAST(@totalProducto AS VARCHAR)

	SELECT
	@totalFactura = totalFactura
	FROM dbo.CabeceraPedido
	WHERE idCabeceraPedido = @idCabeceraPedido
	PRINT 'Factura Vieja' + CAST(@totalFactura AS VARCHAR)
	UPDATE 
	CabeceraPedido
	SET
	totalFactura= (@totalFactura - @totalProducto) + @totalUnDetalle
	WHERE
	idCabeceraPedido=@idCabeceraPedido
	UPDATE
	dbo.CuerpoPedido
	SET
	idCabeceraPedido=@idCabeceraPedido,
	idElectrodomestico=@idElectrodomestico,
	cantidadProducto=@cantidadProducto,
	precioUnitario=@precioUnitario
	WHERE
	idCabeceraPedido=@idCabeceraPedido
	AND idElectrodomestico=@idElectrodomestico
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_SumarTotalCuerpo]
	ON [CuerpoPedido] FOR INSERT
	AS
	DECLARE 
	@idCabeceraPedido INT,
	@idElectrodomestico INT,
	@cantidadProducto INT,
	@precioUnitario MONEY,
	@totalUnDetalle MONEY
	SELECT
	@idCabeceraPedido=idCabeceraPedido,
	@idElectrodomestico=idElectrodomestico,
	@cantidadProducto=cantidadProducto,
	@precioUnitario=precioUnitario,
	@totalUnDetalle=cantidadProducto*precioUnitario
	FROM INSERTED
	UPDATE
	CuerpoPedido
	SET
	totalProducto= @totalUnDetalle
	WHERE
	idCabeceraPedido=@idCabeceraPedido AND
	idElectrodomestico=@idElectrodomestico
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_SumarTotalCuerpoUpdate]
	ON [CuerpoPedido] FOR UPDATE
	AS
	DECLARE
	@idCabeceraPedido INT,
	@idElectrodomestico INT,
	@cantidadProducto INT,
	@precioUnitario MONEY,
	@totalUnDetalle MONEY
	SELECT
	@idCabeceraPedido=idCabeceraPedido,
	@idElectrodomestico=idElectrodomestico,
	@cantidadProducto=cantidadProducto,
	@precioUnitario=precioUnitario,
	@totalUnDetalle=cantidadProducto*precioUnitario
	FROM INSERTED
	UPDATE 
	CuerpoPedido
	SET
	totalProducto= @totalUnDetalle
	WHERE
	idCabeceraPedido=@idCabeceraPedido AND
	idElectrodomestico=@idElectrodomestico
GO

ALTER TABLE [dbo].[CuerpoPedido]
  ADD CONSTRAINT [Relationship12] FOREIGN KEY ([idElectrodomestico]) REFERENCES [dbo].[Electrodomestico] ([idElectrodomestico])
GO

ALTER TABLE [dbo].[CuerpoPedido]
  ADD CONSTRAINT [Relationship9] FOREIGN KEY ([idCabeceraPedido]) REFERENCES [dbo].[CabeceraPedido] ([idCabeceraPedido])
GO