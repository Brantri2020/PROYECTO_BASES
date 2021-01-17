CREATE TABLE [dbo].[multasAsistencia] (
  [valorMulta] [money] NULL,
  [idRegistroAsistencia] [int] NULL,
  [idSalario] [int] NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship30]
  ON [dbo].[multasAsistencia] ([idRegistroAsistencia])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship31]
  ON [dbo].[multasAsistencia] ([idSalario])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [TR_SalarioDELETE]
	ON [dbo].[multasAsistencia] FOR DELETE
	AS
	DECLARE 
	@idSalario INT,
	@valorMulta MONEY
	SELECT
	@valorMulta=valorMulta,
	@idSalario=idSalario
	FROM Deleted
	UPDATE 
	dbo.Salario
	SET
	salarioReal=salarioReal+@valorMulta
	WHERE
	idSalario=@idSalario
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [TR_SalarioInsert]
	ON [dbo].[multasAsistencia] FOR INSERT
	AS
	DECLARE 
	@idSalario INT,
	@valorMulta MONEY
	SELECT
	@valorMulta=valorMulta,
	@idSalario=idSalario
	FROM INSERTED
	UPDATE 
	dbo.Salario
	SET
	salarioReal=salarioReal-@valorMulta
	WHERE
	idSalario=@idSalario
GO

ALTER TABLE [dbo].[multasAsistencia]
  ADD CONSTRAINT [Relationship30] FOREIGN KEY ([idRegistroAsistencia]) REFERENCES [dbo].[RegistroAsistencias] ([idRegistroAsistencia])
GO

ALTER TABLE [dbo].[multasAsistencia]
  ADD CONSTRAINT [Relationship31] FOREIGN KEY ([idSalario]) REFERENCES [dbo].[Salario] ([idSalario])
GO