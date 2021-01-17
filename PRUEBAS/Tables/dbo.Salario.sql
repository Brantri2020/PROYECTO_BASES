CREATE TABLE [dbo].[Salario] (
  [idSalario] [int] NOT NULL,
  [idEmpleado] [int] NULL,
  [salarioNominal] [money] NULL,
  [salarioReal] [money] NULL,
  [fechaPago] [date] NULL,
  CONSTRAINT [PK_Salario] PRIMARY KEY CLUSTERED ([idSalario])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship26]
  ON [dbo].[Salario] ([idEmpleado])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Salario]
  ADD CONSTRAINT [Relationship26] FOREIGN KEY ([idEmpleado]) REFERENCES [dbo].[Empleado] ([idEmpleado])
GO