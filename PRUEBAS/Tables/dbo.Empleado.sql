CREATE TABLE [dbo].[Empleado] (
  [idEmpleado] [int] NOT NULL,
  [cedulaEmpleado] [varchar](15) NULL,
  [nombreEmpleado] [varchar](50) NULL,
  [apellidoEmpleado] [varchar](50) NULL,
  [telefonoEmpleado] [varchar](15) NULL,
  [direccionEmpleado] [varchar](250) NULL,
  [fechaNacimientoEmpleado] [date] NULL,
  [fechaIngresoEmpleado] [date] NULL,
  [horaDiariaIngreso] [time] NULL,
  [idDepartamento] [int] NULL,
  CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED ([idEmpleado])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Relationship2]
  ON [dbo].[Empleado] ([idDepartamento])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Empleado]
  ADD CONSTRAINT [Relationship2] FOREIGN KEY ([idDepartamento]) REFERENCES [dbo].[Departamento] ([idDepartamento])
GO