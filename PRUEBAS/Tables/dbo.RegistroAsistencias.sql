CREATE TABLE [dbo].[RegistroAsistencias] (
  [idRegistroAsistencia] [int] NOT NULL,
  [fechaHoraAsistencia] [datetime] NULL,
  [idEmpleado] [int] NULL,
  [detalleAsistencia] [varchar](1) NULL,
  CONSTRAINT [PK_RegistroAsistencias] PRIMARY KEY CLUSTERED ([idRegistroAsistencia])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship27]
  ON [dbo].[RegistroAsistencias] ([idEmpleado])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_ActualizarTablaMulta]
	ON [RegistroAsistencias] FOR UPDATE
	AS
	DECLARE 	
	@idRegistroAsistencia INT,
	@idEmpleado INT,
	@detalleAsistencia VARCHAR
	SELECT
	@idRegistroAsistencia=idRegistroAsistencia,
	@idEmpleado = idEmpleado,
	@detalleAsistencia = detalleAsistencia
	FROM INSERTED
	DECLARE
	@idSalario INT,
	@salarioNominal MONEY
	SELECT TOP 1
	@idSalario=idSalario,
	@salarioNominal=salarioNominal
	FROM Salario
	WHERE idEmpleado = @idEmpleado
	ORDER BY fechaPago DESC
BEGIN
	DECLARE
	@valorMulta MONEY
	IF @detalleAsistencia = 'R'
			BEGIN
				SET @valorMulta = 0.05*@salarioNominal;
				DELETE FROM multasAsistencia
				WHERE idRegistroAsistencia=@idRegistroAsistencia

				INSERT INTO multasAsistencia
				VALUES(@valorMulta,@idRegistroAsistencia,@idSalario)
			END
	IF @detalleAsistencia = 'F'
			BEGIN
				SET @valorMulta = 0.10*@salarioNominal;
				DELETE FROM multasAsistencia
				WHERE idRegistroAsistencia=@idRegistroAsistencia

				INSERT INTO multasAsistencia
				VALUES(@valorMulta,@idRegistroAsistencia,@idSalario)
			END
	IF @detalleAsistencia = 'A'
			BEGIN
				DELETE FROM multasAsistencia
				WHERE idRegistroAsistencia=@idRegistroAsistencia
			END
END
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_EliminarTablaMulta]
	ON [RegistroAsistencias] INSTEAD OF DELETE
	AS
	DECLARE 	
	@idRegistroAsistencia INT
	SELECT
	@idRegistroAsistencia=idRegistroAsistencia
	FROM Deleted
	DELETE FROM multasAsistencia
	WHERE idRegistroAsistencia=@idRegistroAsistencia
	DELETE FROM dbo.RegistroAsistencias
	WHERE idRegistroAsistencia=@idRegistroAsistencia

-------SALARIO
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[TR_LlenarTablaMulta]
	ON [RegistroAsistencias] FOR INSERT
	AS
	DECLARE 	
	@idRegistroAsistencia INT,
	@idEmpleado INT,
	@detalleAsistencia VARCHAR
	SELECT
	@idRegistroAsistencia=idRegistroAsistencia,
	@idEmpleado = idEmpleado,
	@detalleAsistencia = detalleAsistencia
	FROM INSERTED
	DECLARE
	@idSalario INT,
	@salarioNominal MONEY
	SELECT TOP 1
	@idSalario=idSalario,
	@salarioNominal=salarioNominal
	FROM Salario
	WHERE idEmpleado = @idEmpleado
	ORDER BY fechaPago DESC
BEGIN
	DECLARE
	@valorMulta MONEY
	IF @detalleAsistencia = 'R'
			BEGIN
				SET @valorMulta = 0.05*@salarioNominal;
				INSERT INTO multasAsistencia
				VALUES(@valorMulta,@idRegistroAsistencia,@idSalario)
			END
	IF @detalleAsistencia = 'F'
			BEGIN
				SET @valorMulta = 0.10*@salarioNominal;
				INSERT INTO multasAsistencia
				VALUES(@valorMulta,@idRegistroAsistencia,@idSalario)
			END
END
GO

ALTER TABLE [dbo].[RegistroAsistencias]
  ADD CONSTRAINT [Relationship27] FOREIGN KEY ([idEmpleado]) REFERENCES [dbo].[Empleado] ([idEmpleado])
GO