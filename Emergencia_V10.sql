CREATE DATABASE [BDRicardoPalma]
go
USE [BDRicardoPalma]
GO
/****** Object:  Table [dbo].[Destino]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Destino](
	[IdDestino] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_Destino] PRIMARY KEY CLUSTERED 
(
	[IdDestino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleTurno]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleTurno](
	[IdDetalleTurno] [int] IDENTITY(1,1) NOT NULL,
	[IdTurno] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[IdPersonalEmergencia] [int] NULL,
	[IdEstado] [int] NOT NULL,
	[Comentario] [varchar](200) NULL,
 CONSTRAINT [PK_DetalleTurno] PRIMARY KEY CLUSTERED 
(
	[IdDetalleTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estados](
	[IdEstado] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Estados] PRIMARY KEY CLUSTERED 
(
	[IdEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Insumo]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Insumo](
	[IdInsumo] [int] IDENTITY(1,1) NOT NULL,
	[NombreInsumo] [varchar](100) NOT NULL,
	[Marca] [varchar](50) NULL,
	[Linea] [varchar](50) NULL,
 CONSTRAINT [PK_Insumo] PRIMARY KEY CLUSTERED 
(
	[IdInsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Paciente]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Paciente](
	[IdPaciente] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoPaciente] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ApellidoPaterno] [varchar](100) NOT NULL,
	[ApellidoMaterno] [varchar](100) NOT NULL,
	[dni] [int] NOT NULL,
 CONSTRAINT [PK_Paciente] PRIMARY KEY CLUSTERED 
(
	[IdPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonalEmergencia]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PersonalEmergencia](
	[IdPersonalEmergencia] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[ApellidoPaterno] [varchar](100) NOT NULL,
	[ApellidoMaterno] [varchar](100) NOT NULL,
	[DNI] [int] NOT NULL,
	[Rol] [varchar](10) NOT NULL,
 CONSTRAINT [PK_PersonalEmergencia] PRIMARY KEY CLUSTERED 
(
	[IdPersonalEmergencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Prioridad]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Prioridad](
	[IdPrioridad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_Prioridad] PRIMARY KEY CLUSTERED 
(
	[IdPrioridad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Protocolo]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Protocolo](
	[IdProtocolo] [int] IDENTITY(1,1) NOT NULL,
	[IdSintoma] [int] NOT NULL,
	[IdPrioridad] [int] NOT NULL,
	[IdDestino] [int] NOT NULL,
	[Sala] [varchar](20) NOT NULL,
	[Diagnostico] [varchar](200) NOT NULL,
	[CondicionIngreso] [varchar](200) NOT NULL,
	[CondicionEgreso] [varchar](200) NOT NULL,
	[DiasAtencion] [int] NOT NULL,
 CONSTRAINT [PK_Protocolo] PRIMARY KEY CLUSTERED 
(
	[IdProtocolo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Requerimiento_Insumo]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Requerimiento_Insumo](
	[IdRequerimiento_Insumo] [int] IDENTITY(1,1) NOT NULL,
	[IdRequerimientoInsumo] [int] NOT NULL,
	[IdInsumo] [int] NOT NULL,
	[IdSala] [int] NOT NULL,
	[Sala] [varchar](50) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Motivo] [varchar](300) NULL,
	[IdEstado] [int] NOT NULL,
	[EsAutorizado] [bit] NOT NULL,
	[FechaAutorizacion] [datetime] NULL,
 CONSTRAINT [PK_Requerimiento_Insumo] PRIMARY KEY CLUSTERED 
(
	[IdRequerimiento_Insumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RequerimientoInsumo]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequerimientoInsumo](
	[IdRequerimientoInsumo] [int] IDENTITY(1,1) NOT NULL,
	[IdPersonalEmergencia] [int] NOT NULL,
	[FechaSolicitud] [datetime] NOT NULL,
 CONSTRAINT [PK_RequerimientoInsumo] PRIMARY KEY CLUSTERED 
(
	[IdRequerimientoInsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RequerimientoTurno]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RequerimientoTurno](
	[IdRequerimientoTurno] [int] IDENTITY(1,1) NOT NULL,
	[IdPersonalEmergencia] [int] NOT NULL,
	[FechaSolicitud] [datetime] NOT NULL,
	[HoraInicio] [varchar](8) NOT NULL,
	[HoraFin] [varchar](8) NOT NULL,
	[Motivo] [varchar](100) NULL,
	[EsAprobado] [bit] NOT NULL,
 CONSTRAINT [PK_RequerimientoTurno] PRIMARY KEY CLUSTERED 
(
	[IdRequerimientoTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sintoma]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sintoma](
	[IdSintoma] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](200) NULL,
 CONSTRAINT [PK_Sintoma] PRIMARY KEY CLUSTERED 
(
	[IdSintoma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TicketEmergencia]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketEmergencia](
	[IdTicketEmergencia] [int] IDENTITY(1,1) NOT NULL,
	[IdPaciente] [int] NOT NULL,
	[IdDestino] [int] NULL,
	[EsViolencia] [bit] NULL,
	[IdTicketTrauma] [int] NULL,
	[IdTicketSala] [int] NULL,
	[IdTratamiento] [int] NULL,
	[IdPersonalEmergencia] [int] NULL,
	[Ingreso] [datetime] NULL,
	[Egreso] [datetime] NULL,
 CONSTRAINT [PK_TicketEmergencia] PRIMARY KEY CLUSTERED 
(
	[IdTicketEmergencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TicketSalaObservacion]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TicketSalaObservacion](
	[IdTicketSala] [int] IDENTITY(1,1) NOT NULL,
	[Ingreso] [datetime] NULL,
	[Egreso] [datetime] NULL,
	[Diagnostico] [varchar](200) NULL,
	[CondicionIngreso] [varchar](200) NULL,
	[CondicionEgreso] [varchar](200) NULL,
 CONSTRAINT [PK_TicketSalaObservacion] PRIMARY KEY CLUSTERED 
(
	[IdTicketSala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TicketTraumaShockTopico]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TicketTraumaShockTopico](
	[IdTicketTrauma] [int] IDENTITY(1,1) NOT NULL,
	[Ingreso] [datetime] NULL,
	[Egreso] [datetime] NULL,
	[Diagnostico] [varchar](200) NULL,
	[EsTraumaShock] [bit] NULL,
 CONSTRAINT [PK_TicketTraumaShock] PRIMARY KEY CLUSTERED 
(
	[IdTicketTrauma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoPaciente]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoPaciente](
	[IdTipoPaciente] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](200) NULL,
 CONSTRAINT [PK_TipoPaciente] PRIMARY KEY CLUSTERED 
(
	[IdTipoPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tratamiento]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tratamiento](
	[IdTratamiento] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Tratamiento] PRIMARY KEY CLUSTERED 
(
	[IdTratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Triaje]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Triaje](
	[IdTriaje] [int] IDENTITY(1,1) NOT NULL,
	[IdPrioridad] [int] NOT NULL,
	[IdTicketEmergencia] [int] NOT NULL,
	[IdSintoma] [int] NOT NULL,
 CONSTRAINT [PK_Triaje] PRIMARY KEY CLUSTERED 
(
	[IdTriaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Turno]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Turno](
	[IdTurno] [int] IDENTITY(1,1) NOT NULL,
	[NombreTurno] [varchar](20) NOT NULL,
	[Rango1] [varchar](8) NOT NULL,
	[Rango2] [varchar](8) NOT NULL,
 CONSTRAINT [PK_Turno] PRIMARY KEY CLUSTERED 
(
	[IdTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 20/11/2017 04:05:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[Nombres] [varchar](100) NOT NULL,
	[Clave] [varchar](50) NOT NULL,
	[EsAutorizador] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Destino] ON 

GO
INSERT [dbo].[Destino] ([IdDestino], [Descripcion]) VALUES (1, N'Local Ricardo Palma')
GO
INSERT [dbo].[Destino] ([IdDestino], [Descripcion]) VALUES (2, N'Local Surco')
GO
SET IDENTITY_INSERT [dbo].[Destino] OFF
GO
SET IDENTITY_INSERT [dbo].[DetalleTurno] ON 

GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (286, 1, CAST(N'2017-11-01 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (287, 2, CAST(N'2017-11-01 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (288, 3, CAST(N'2017-11-01 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (289, 1, CAST(N'2017-11-02 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (290, 2, CAST(N'2017-11-02 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (291, 3, CAST(N'2017-11-02 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (292, 1, CAST(N'2017-11-03 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (293, 2, CAST(N'2017-11-03 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (294, 3, CAST(N'2017-11-03 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (295, 1, CAST(N'2017-11-04 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (296, 2, CAST(N'2017-11-04 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (297, 3, CAST(N'2017-11-04 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (298, 1, CAST(N'2017-11-05 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (299, 2, CAST(N'2017-11-05 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (300, 3, CAST(N'2017-11-05 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (301, 1, CAST(N'2017-11-06 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (302, 2, CAST(N'2017-11-06 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (303, 3, CAST(N'2017-11-06 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (304, 1, CAST(N'2017-11-07 00:00:00.000' AS DateTime), 1, 2, N'')
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (305, 2, CAST(N'2017-11-07 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (306, 3, CAST(N'2017-11-07 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (307, 1, CAST(N'2017-11-08 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (308, 2, CAST(N'2017-11-08 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (309, 3, CAST(N'2017-11-08 00:00:00.000' AS DateTime), 1, 1, N'aprobado')
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (310, 1, CAST(N'2017-11-09 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (311, 2, CAST(N'2017-11-09 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (312, 3, CAST(N'2017-11-09 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (313, 1, CAST(N'2017-11-20 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (314, 2, CAST(N'2017-11-20 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
INSERT [dbo].[DetalleTurno] ([IdDetalleTurno], [IdTurno], [Fecha], [IdPersonalEmergencia], [IdEstado], [Comentario]) VALUES (315, 3, CAST(N'2017-11-20 00:00:00.000' AS DateTime), NULL, 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[DetalleTurno] OFF
GO
SET IDENTITY_INSERT [dbo].[Estados] ON 

GO
INSERT [dbo].[Estados] ([IdEstado], [Descripcion]) VALUES (1, N'Aprobado')
GO
INSERT [dbo].[Estados] ([IdEstado], [Descripcion]) VALUES (2, N'No Aprobado')
GO
SET IDENTITY_INSERT [dbo].[Estados] OFF
GO
SET IDENTITY_INSERT [dbo].[Insumo] ON 

GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (1, N'ACEITE DE VASELINA LITROS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (2, N'ACIDO POLIG. 0 AG. REDONDA 1/2 CIRC. 37 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (3, N'ACIDO POLIG. 0 AG. REDONDA 5/8 CIRC. 36 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (4, N'ACIDO POLIG. 1 AG. REDONDA 1/2 CIRC. 37 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (5, N'ACIDO POLIG. 2/0 AG. REDONDA 1/2 CIRC. 26 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (6, N'ACIDO POLIG. 2/0 AG. REDONDA 1/2 CIRC. 37 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (7, N'ACIDO POLIG. 3/0 AG. CORT.ABS. RAPIDA 1/2 CIRC. 26 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (8, N'ACIDO POLIG. 3/0 AG. REDONDA 1/2 CIRC. 26 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (9, N'ACIDO POLIGLICOLICO ABSORCION RAPIDA 2/0  1/2 CIRC.   36.4 MM', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (10, N'ACIDO POLIGLICOLICO ABSORCION RAPIDA 0     1/2 CIRC. 36.4 MM', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (11, N'AGUJA DESCT.# 18  1 1/4', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (12, N'AGUJA DESCT.# 21     1 1/4', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (13, N'AGUJA DESCT.# 22 1 1/4', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (14, N'AGUJA DESCT.# 23 1 1/4', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (15, N'AGUJA DESCT.# 25 1 1/4', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (16, N'AGUJA PARA PUNCION LUMBAR # 25 ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (17, N'ALCOHOL YODADO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (18, N'APOSITO DE PLATA IONICA 15 CM. X 15 CM.   /  UNIDAD', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (19, N'APOSITO HIDROCOLOIDE 14.4 CM. X 14.4 CM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (20, N'APOSITO HIDROCOLOIDE 9.5 CM. X 9.7 CM. EXTRADELGADO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (21, N'BIGOTERAS O CANULA  DE OXIGENO ADULTO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (22, N'BISTURI NO. 11', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (23, N'BISTURI NO. 20', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (24, N'BOLSA PARA COLOSTOMIA CON CLAMP Y PLACA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (25, N'BOLSA PARA NUTRICION PARENTERAL 500 ML. ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (26, N'CATETER DOBLE J  6 FR. X 26 CM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (27, N'CATETER DOBLE J  7 FR.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (28, N'CATETER P.V.# 18', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (29, N'CATETER P.V.# 20 ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (30, N'CATETER P.V.# 22', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (31, N'CATETER P.V.# 24', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (32, N'CLIPS DE POLIMERO VERDE en cartucho (6 unidades)', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (33, N'CLIPS DE TITANIUM (cartucho 6 unidades)', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (34, N'CONECTOR DE OXIGENO TIPO ARBOLITO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (35, N'DISPOSITIVO DE SEGURIDAD P'' ADM.DE MEDICAM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (36, N'DRENES DE PENROSE 1/2', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (37, N'DRENES DE PENROSE 1/4', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (38, N'ELECTRODOS  ADULTOS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (39, N'ELECTRODOS PEDIATRICOS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (40, N'EQUIPO BURETA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (41, N'EQUIPO BOMBA FOTOPROTECTOR ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (42, N'EQUIPO DE VENOCLISIS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (43, N'EQUIPO DE VENOCLISIS FOTO SENSIBLE', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (44, N'EQUIPO MICROGOTERO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (45, N'ESPARADRAPO  STRECH  15 CM X 10 YDAS.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (46, N'ESPECULO VAGINAL DESCARTABLE MEDIUM', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (47, N'ESPECULO VAGINAL DESCARTABLE LARGE', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (48, N'ESPECUO VAGINAL DESCARTABLE SMALL', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (49, N'EXTENSION VENOSA NEONATAL BIFURCADA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (50, N'FRASCO RECOLECTOR DE ORINA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (51, N'FUNDA RECOLEC. ORINA ADULTO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (52, N'GASA VASELINADA 10 CM. X 10 CM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (53, N'GLICERINA litros ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (54, N'GUANTE CIRU.# 6,5', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (55, N'GUANTE CIRU.# 7', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (56, N'GUANTE CIRU.# 7,5', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (57, N'GUANTE CIRU.# 8', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (58, N'GUANTE HOSPITALARIO  NO ESTERIL SMALL', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (59, N'GUANTE DE NITRILO MEDIUM', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (60, N'GUANTE DE NITRILO  SMALL', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (61, N'GUANTE DE NITRILO  LARGE', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (62, N'HUMIDIFICADOR DE OXIGENO ( CON VALVULA DE SEGURIDAD 410 MILIBARS)', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (63, N'JERING.DESC. 1 CC. INSULINA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (64, N'JERING.DESC. 1 CC. TUBERCULINA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (65, N'JERING.DESC. 3 CC.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (66, N'JERING.DESC. 5 CC.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (67, N'JERING.DESC.10 CC', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (68, N'JERING.DESC.20 CC.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (69, N'JERING.DESC.50 CC. CON BUYON', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (70, N'LANCETAS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (71, N'LANOLINA tarrinas ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (72, N'MALLA PARA CISTOCELE', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (73, N'MASCARILLA DE ANESTESIA # 1 NEONATAL', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (74, N'MASCARILLAS DE OXIGENO ADULTO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (75, N'MICRONEBULIZADOR CON MASCARILLA ADULTOS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (76, N'NYLON MONOFILAMENTO 3/0  3/8 CIRC AGUJA CORTANTE', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (77, N'NYLON MONOFILAMENTO 3/0 CON LANCETA 60 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (78, N'PARAFINA KG ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (79, N'PERAS DE SUCCIÓN  2 1/4 " CON MAYOR RESISTENCIA ESTERILIZACIÓN  VERIFICAR CALIDAD', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (80, N'SEDA 2/0 NEG.TRENZADA AG. REDON. 1/2 CIRC. 37 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (81, N'SEDA 2/0 NEG.TRENZADA AG.CORT.3/8 CIRC.24MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (82, N'SEDA 2/0 NEGRA TRENZADA AG. REDONDA 1/2 CIRC. 26 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (83, N'SEDA 3/0 NEGRA TRENZ. AG. REDONDA 1/2 CIRC.26 MM.', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (84, N'SISTEMA DE DRENAJE TORAXICO 2300 ML', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (85, N'SISTEMA DE DRENAJE TORAXICO 3 CAMARAS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (86, N'SONDA ALIMENTACION # 6', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (87, N'SONDA ALIMENTACION # 8', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (88, N'SONDA DE SUCCION NO.  6', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (89, N'SONDA DE SUCCION NO.  8', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (90, N'SONDA DE SUCCION NO. 10', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (91, N'SONDA DE SUCCION NO. 12', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (92, N'SONDA DE SUCCION NO. 14', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (93, N'SONDA DE SUCCION NO. 18', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (94, N'SONDA FOLEY NO.14 (2 VIAS)', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (95, N'SONDA FOLEY NO.16 (2 VIAS)', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (96, N'SONDA NASOGASTRICAS NO.14', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (97, N'SONDA NELATON NO.12', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (98, N'SONDA NELATON NO.14', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (99, N'SUJETADOR DE SONDA FOLEY', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (100, N'SUJETADOR DE SONDA NASOGASTRICA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (101, N'TIRAS DE HEMOGLOBINA ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (102, N'TIRAS REACTIVAS PARA CLICEMIA ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (103, N'TUBO ENDOTRAQ. # 4,0 CON BALON', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (104, N'VALVULA P'' HIDROCEFALIA PRESION MEDIA ADULTO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (105, N'VALVULA P'' HIDROCEFALIA PRESION MEDIA PEDIATRICA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (106, N'VALVULA P'' HIDROCEFALIA ULTRA SMALL PRESION MEDIA', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (107, N'VASELINA SOLIDA SIMPLE  EN TARRO', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (108, N'VENDA DE GASA 4"', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (109, N'VENDA DE GASA 6"', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (110, N'VENDA DE YESO 10 CM. (4") RAPIDO FRAGUADO VERIFICAR CALIDAD', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (111, N'VENDA DE YESO 15 CM. (6") RAPIDO FRAGUADO VERIFICAR CALIDAD', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (112, N'VENDA ELASTICA 3"', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (113, N'VENDA ELASTICA 6"', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (114, N'WATTA " 4 "', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (115, N'WATTA " 6 "', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (116, N'PORTAOBJETOS  CAJAS X 50 UNIDADES ', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (117, N'INHALOCAMARAS NEONATAL', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (118, N'INHALOCAMARAS PEDIATRICAS', NULL, NULL)
GO
INSERT [dbo].[Insumo] ([IdInsumo], [NombreInsumo], [Marca], [Linea]) VALUES (119, N'INHALOCAMARAS ADULTOS', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Insumo] OFF
GO
SET IDENTITY_INSERT [dbo].[Paciente] ON 

GO
INSERT [dbo].[Paciente] ([IdPaciente], [IdTipoPaciente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [dni]) VALUES (1, 1, N'Pablo', N'Flores', N'Flores', 12345678)
GO
INSERT [dbo].[Paciente] ([IdPaciente], [IdTipoPaciente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [dni]) VALUES (2, 2, N'Jose', N'Gomez', N'Gonzales', 65214589)
GO
INSERT [dbo].[Paciente] ([IdPaciente], [IdTipoPaciente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [dni]) VALUES (3, 3, N'Manuel', N'Gomez', N'Nuñez', 78952365)
GO
INSERT [dbo].[Paciente] ([IdPaciente], [IdTipoPaciente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [dni]) VALUES (4, 4, N'Pierre', N'Santos', N'Perez', 652365412)
GO
INSERT [dbo].[Paciente] ([IdPaciente], [IdTipoPaciente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [dni]) VALUES (9, 5, N'jose', N'caceda', N'lopez', 52354252)
GO
INSERT [dbo].[Paciente] ([IdPaciente], [IdTipoPaciente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [dni]) VALUES (10, 5, N'miguel', N'perez', N'lopez', 73463453)
GO
SET IDENTITY_INSERT [dbo].[Paciente] OFF
GO
SET IDENTITY_INSERT [dbo].[PersonalEmergencia] ON 

GO
INSERT [dbo].[PersonalEmergencia] ([IdPersonalEmergencia], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [DNI], [Rol]) VALUES (1, N'Marco', N'Caceda', N'Rubio', 45678765, N'Doctor')
GO
INSERT [dbo].[PersonalEmergencia] ([IdPersonalEmergencia], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [DNI], [Rol]) VALUES (2, N'Pedro', N'Guille', N'Peralta', 98764857, N'Doctor')
GO
INSERT [dbo].[PersonalEmergencia] ([IdPersonalEmergencia], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [DNI], [Rol]) VALUES (3, N'Alfredo', N'Tapia', N'Vallejo', 87547488, N'Doctor')
GO
SET IDENTITY_INSERT [dbo].[PersonalEmergencia] OFF
GO
SET IDENTITY_INSERT [dbo].[Prioridad] ON 

GO
INSERT [dbo].[Prioridad] ([IdPrioridad], [Descripcion]) VALUES (1, N'Prioridad I - Gravedad súbita extrema')
GO
INSERT [dbo].[Prioridad] ([IdPrioridad], [Descripcion]) VALUES (2, N'Prioridad II - Urgencia mayor')
GO
INSERT [dbo].[Prioridad] ([IdPrioridad], [Descripcion]) VALUES (3, N'Prioridad III - Urgencia menor')
GO
INSERT [dbo].[Prioridad] ([IdPrioridad], [Descripcion]) VALUES (4, N'Prioridad IV - Patología aguda común')
GO
SET IDENTITY_INSERT [dbo].[Prioridad] OFF
GO
SET IDENTITY_INSERT [dbo].[Protocolo] ON 

GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (1, 1, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 10)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (2, 2, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 6)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (3, 3, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (4, 4, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (5, 5, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (6, 6, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 10)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (7, 7, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (8, 8, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (9, 9, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (10, 10, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (11, 11, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (12, 12, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 6)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (13, 13, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 7)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (14, 14, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (15, 15, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 6)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (16, 16, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (17, 17, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (18, 18, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 7)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (19, 19, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (20, 20, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (21, 21, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 6)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (22, 22, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (23, 23, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (24, 24, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 10)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (25, 25, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 7)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (26, 26, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (27, 27, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (28, 28, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 7)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (29, 29, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (30, 30, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (31, 31, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 10)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (32, 32, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (33, 33, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (34, 34, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 6)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (35, 35, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (36, 36, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (37, 37, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 10)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (38, 38, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 8)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (39, 39, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 5)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (40, 40, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 6)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (41, 41, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 6)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (42, 42, 1, 1, N'Trauma', N'Cuidado intensivos', N'Llevar con ambulancia caso si es necesario', N'Dar aprobación para dar de alta', 9)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (43, 43, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (44, 44, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (45, 45, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (46, 46, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (47, 47, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (48, 48, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (49, 49, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (50, 50, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (51, 51, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (52, 52, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (53, 53, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (54, 54, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (55, 55, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (56, 56, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (57, 57, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (58, 58, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (59, 59, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (60, 60, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (61, 61, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (62, 62, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (63, 63, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (64, 64, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (65, 65, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (66, 66, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (67, 67, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (68, 68, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (69, 69, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (70, 70, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (71, 71, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (72, 72, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (73, 73, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (74, 74, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (75, 75, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (76, 76, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 4)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (77, 77, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (78, 78, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (79, 79, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (80, 80, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (81, 81, 2, 1, N'Trauma', N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (82, 82, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (83, 83, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (84, 84, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (85, 85, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (86, 86, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (87, 87, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (88, 88, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (89, 89, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (90, 90, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (91, 91, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (92, 92, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (93, 93, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (94, 94, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (95, 95, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (96, 96, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (97, 97, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (98, 98, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 3)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (99, 99, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (100, 100, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (101, 101, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (102, 102, 3, 1, N'Topico', N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir', 2)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (103, 103, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 0)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (104, 104, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 0)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (105, 105, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 0)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (106, 106, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 0)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (107, 107, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (108, 108, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (109, 109, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 1)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (110, 110, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 0)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (111, 111, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 0)
GO
INSERT [dbo].[Protocolo] ([IdProtocolo], [IdSintoma], [IdPrioridad], [IdDestino], [Sala], [Diagnostico], [CondicionIngreso], [CondicionEgreso], [DiasAtencion]) VALUES (112, 112, 4, 1, N'Topico', N'Receta médica', N'Consulta general', N'Tratamiento a seguir', 1)
GO
SET IDENTITY_INSERT [dbo].[Protocolo] OFF
GO
SET IDENTITY_INSERT [dbo].[Requerimiento_Insumo] ON 

GO
INSERT [dbo].[Requerimiento_Insumo] ([IdRequerimiento_Insumo], [IdRequerimientoInsumo], [IdInsumo], [IdSala], [Sala], [Cantidad], [Motivo], [IdEstado], [EsAutorizado], [FechaAutorizacion]) VALUES (3, 18, 1, 1, N'Trauma', 23, N'para trauma', 2, 0, NULL)
GO
INSERT [dbo].[Requerimiento_Insumo] ([IdRequerimiento_Insumo], [IdRequerimientoInsumo], [IdInsumo], [IdSala], [Sala], [Cantidad], [Motivo], [IdEstado], [EsAutorizado], [FechaAutorizacion]) VALUES (4, 3, 12, 1, N'Trauma', 3, N'para trauma', 1, 1, NULL)
GO
INSERT [dbo].[Requerimiento_Insumo] ([IdRequerimiento_Insumo], [IdRequerimientoInsumo], [IdInsumo], [IdSala], [Sala], [Cantidad], [Motivo], [IdEstado], [EsAutorizado], [FechaAutorizacion]) VALUES (5, 19, 1, 1, N'Trauma', 12, N'sdasdasd', 2, 0, NULL)
GO
INSERT [dbo].[Requerimiento_Insumo] ([IdRequerimiento_Insumo], [IdRequerimientoInsumo], [IdInsumo], [IdSala], [Sala], [Cantidad], [Motivo], [IdEstado], [EsAutorizado], [FechaAutorizacion]) VALUES (6, 19, 10, 1, N'Trauma', 12, N'sdasdasd', 2, 0, NULL)
GO
INSERT [dbo].[Requerimiento_Insumo] ([IdRequerimiento_Insumo], [IdRequerimientoInsumo], [IdInsumo], [IdSala], [Sala], [Cantidad], [Motivo], [IdEstado], [EsAutorizado], [FechaAutorizacion]) VALUES (7, 20, 13, 1, N'Trauma', 1, N'aguja', 2, 0, NULL)
GO
INSERT [dbo].[Requerimiento_Insumo] ([IdRequerimiento_Insumo], [IdRequerimientoInsumo], [IdInsumo], [IdSala], [Sala], [Cantidad], [Motivo], [IdEstado], [EsAutorizado], [FechaAutorizacion]) VALUES (8, 20, 19, 1, N'Trauma', 1, N'aposito', 2, 0, NULL)
GO
INSERT [dbo].[Requerimiento_Insumo] ([IdRequerimiento_Insumo], [IdRequerimientoInsumo], [IdInsumo], [IdSala], [Sala], [Cantidad], [Motivo], [IdEstado], [EsAutorizado], [FechaAutorizacion]) VALUES (9, 23, 6, 1, N'Trauma', 1, N'asda', 2, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[Requerimiento_Insumo] OFF
GO
SET IDENTITY_INSERT [dbo].[RequerimientoInsumo] ON 

GO
INSERT [dbo].[RequerimientoInsumo] ([IdRequerimientoInsumo], [IdPersonalEmergencia], [FechaSolicitud]) VALUES (3, 1, CAST(N'2017-11-15 14:47:20.220' AS DateTime))
GO
INSERT [dbo].[RequerimientoInsumo] ([IdRequerimientoInsumo], [IdPersonalEmergencia], [FechaSolicitud]) VALUES (4, 1, CAST(N'2017-11-15 14:48:02.407' AS DateTime))
GO
INSERT [dbo].[RequerimientoInsumo] ([IdRequerimientoInsumo], [IdPersonalEmergencia], [FechaSolicitud]) VALUES (18, 1, CAST(N'2017-11-18 13:27:10.787' AS DateTime))
GO
INSERT [dbo].[RequerimientoInsumo] ([IdRequerimientoInsumo], [IdPersonalEmergencia], [FechaSolicitud]) VALUES (19, 1, CAST(N'2017-11-18 18:21:11.227' AS DateTime))
GO
INSERT [dbo].[RequerimientoInsumo] ([IdRequerimientoInsumo], [IdPersonalEmergencia], [FechaSolicitud]) VALUES (20, 1, CAST(N'2017-11-18 18:22:05.257' AS DateTime))
GO
INSERT [dbo].[RequerimientoInsumo] ([IdRequerimientoInsumo], [IdPersonalEmergencia], [FechaSolicitud]) VALUES (23, 1, CAST(N'2017-11-20 15:02:18.487' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[RequerimientoInsumo] OFF
GO
SET IDENTITY_INSERT [dbo].[RequerimientoTurno] ON 

GO
INSERT [dbo].[RequerimientoTurno] ([IdRequerimientoTurno], [IdPersonalEmergencia], [FechaSolicitud], [HoraInicio], [HoraFin], [Motivo], [EsAprobado]) VALUES (1, 1, CAST(N'2017-09-12 00:00:00.000' AS DateTime), N'12:12:00', N'17:15:00', N'desaprobado', 0)
GO
INSERT [dbo].[RequerimientoTurno] ([IdRequerimientoTurno], [IdPersonalEmergencia], [FechaSolicitud], [HoraInicio], [HoraFin], [Motivo], [EsAprobado]) VALUES (2, 2, CAST(N'2017-10-20 00:00:00.000' AS DateTime), N'09:12:00', N'13:00:00', N'rgfs', 1)
GO
SET IDENTITY_INSERT [dbo].[RequerimientoTurno] OFF
GO
SET IDENTITY_INSERT [dbo].[Sintoma] ON 

GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (1, N'Paro Cardio Respiratorio')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (2, N' Dolor Torácico Precordial de posible origen cardiogénico con o sin hipotensión')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (3, N' Dificultad respiratoria (evidenciada por polípnea, taquípnea, tiraje, sibilantes, estridor,cianosis)')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (4, N' Shock (Hemorrágico, cardiogénico, distributivo, obstructivo)')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (5, N' Arritmia con compromiso hemodinámico de posible origen cardiogénico con o sin hipotensión')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (6, N' Hemorragia profusa')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (7, N' Obstrucción de vía respiratoria alta')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (8, N' Inestabilidad Hemodinámica (hipotensión 1 shock 1 crisis hipertensiva)')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (9, N' Paciente inconsciente que no responde a estímulos')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (10, N' Víctima de accidente de tránsito')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (11, N' Quemaduras con extensión mayor del 20% de superficie corporal')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (12, N' Caída o precipitación del altura')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (13, N' Dos o más fracturas de huesos largos proximales')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (14, N' Injurias en extremidades con compromiso neurovascular')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (15, N' Herida de bala o arma blanca')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (16, N' Sospecha de traumatismo vertebro medular')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (17, N' Evisceración')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (18, N' Amputación con sangrado no controlado')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (19, N' Traumatismo encéfalo craneano')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (20, N' Status Convulsivo')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (21, N' Sobredosis de drogas o alcohol más depresión respiratoria')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (22, N' lngesta de órgano fosforados, ácidos, álcalis, otras intoxicaciones o envenenamientos')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (23, N' Signos y síntomas de abdomen agudo con descompensación hemodinámica')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (24, N' Signos y síntomas de embarazo ectópico roto')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (25, N'Suicidio frustro')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (26, N' Intento suicida')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (27, N' Crisis de agitación psicomotora con conducta heteroagresiva')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (28, N' Problemas específicos en pacientes pediátricos')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (29, N' Intoxicaciones por ingesta o contacto')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (30, N' Períodos de apnea')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (31, N' Cambios en el estado mental: letargia, delirio, alucinaciones, llanto débil')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (32, N' Deshidratación con Shock: Llenado capilar mayor de tres segundos')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (33, N' Sangrado: Hematemesis, sangrado rectal, vaginal, epistaxis severa')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (34, N' Quemaduras en cara o más del 10% de área corporal')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (35, N' Quemaduras por fuego en ambiente cerrado')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (36, N' Acontecimiento de aspiración u obstrucción con cuerpo extraño')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (37, N' Status convulsivo')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (38, N' Status asmático')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (39, N' Hipertermia maligna')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (40, N' Trastornos de sensorio')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (41, N' Politraumatismo')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (42, N' Herida por arma de fuego ')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (43, N'Frecuencia respiratoria > de 24 por minuto')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (44, N' Crisis asmática con broncoespasmo moderado')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (45, N' Diabetes Mellitus Descompensada')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (46, N' Hemoptisis')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (47, N' Signos y síntomas de Abdomen Agudo')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (48, N' Convulsión reciente en paciente consciente')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (49, N' Dolor torácico no cardiogénico sin compromiso hemodinámico')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (50, N' Arritmias sin compromiso hemodinámico')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (51, N' Sangrado gastrointestinal, con signos vitales estables')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (52, N' Paciente con trastornos en el sensorio')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (53, N' Hipotonía, flacidez muscular aguda y de evolución progresiva')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (54, N' Descompensación Hepática')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (55, N' Hernia umbilical o inguinal incarcerada')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (56, N' Signos y síntomas de descompensación tiroidea')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (57, N' Contusiones o traumatismos con sospecha de fractura o luxación')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (58, N' Herida cortante que requiere sutura')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (59, N' Injuria en ojos: perforación, laceración, avulsión')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (60, N' Desprendimiento de retina')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (61, N' Fiebre y signos inflamatorios en articulaciones')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (62, N' Síntomas y signos de cólera')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (63, N' Deshidratación Aguda sin descompensación hemodinámica')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (64, N' Hematuria macroscópica')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (65, N'Reacción alérgica, sin compromiso respiratorio')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (66, N' Síndrome febril o Infección en paciente inmunosuprimido ')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (67, N'Hemodiálísis, con síntomas y signos agudos')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (68, N' Coagulopatía sin descompensación hemodinámica')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (69, N' Sobredosis de drogas y alcohol sin depresión respiratoria')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (70, N' Cefalea con antecedentes de trauma craneal')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (71, N' Síndrome Meníngeo')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (72, N' Síntomas y signos de enfermedades vasculares agudas')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (73, N' Cólico renal sin respuesta a la analgesia, mayor de 06 horas')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (74, N' Retención urinaria')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (75, N' Síndrome de abstinencia de drogas y alcohol')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (76, N' Cuerpos extraños en orificios corporales')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (77, N' Cuerpos extraños en esófago y estómago')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (78, N' Pacientes con ideación suicida')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (79, N' Pacientes con crisis de ansiedad')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (80, N'Cuadro de demencia con conducta psicótica')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (81, N' Esguinces')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (82, N'Dolor abdominal leve con nauseas, vómitos, diarrea, signos vitales estables')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (83, N'Herida que no requiere sutura')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (84, N'Intoxicación alimentaría')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (85, N' Trastornos de músculos y ligamentos')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (86, N' Otitis Media Aguda')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (87, N'Deshidratación hídroelectrólitíca leve')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (88, N'Osteocondropatía aguda ')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (89, N'Sinusitis aguda')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (90, N' Hiperémesis gravídica sin compromiso metabólico')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (91, N' Fiebre> de 39° sin síntomas asociados')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (92, N' Síndrome vertiginoso y trastorno vascular')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (93, N' Celulitis o absceso con fiebre')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (94, N' Funcionamiento defectuoso de colostomía, ureterostomía, talla vesical u otros similares')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (95, N' Lumbalgia aguda')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (96, N' Broncoespasmo leve')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (97, N' Hipertensión arterial leve no controlada')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (98, N' Signos y síntomas de depresión')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (99, N' Crisis de ansiedad o disociativas')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (100, N' Signos y síntomas de infección urinaria alta')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (101, N' Pacientes con neurosis de ansiedad')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (102, N' Pacientes sicóticos con reagudización de sus síntomas pero aún sin conducta psicótica')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (103, N'Faringitis aguda')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (104, N' Amigdalitis aguda')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (105, N' Enfermedad diarreica aguda sin deshidratación o vómitos')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (106, N' Absceso sin fiebre')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (107, N' Sangrado vaginal leve en no gestante, con funciones vitales estables')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (108, N' Fiebre sin síntomas asociados')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (109, N' Resfrío común')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (110, N' Dolor de oído leve')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (111, N' Dolor de garganta sin disfagia')
GO
INSERT [dbo].[Sintoma] ([IdSintoma], [Descripcion]) VALUES (112, N'Enfermedades crónicas no descompensadas')
GO
SET IDENTITY_INSERT [dbo].[Sintoma] OFF
GO
SET IDENTITY_INSERT [dbo].[TicketEmergencia] ON 

GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (12, 1, 1, NULL, NULL, 5, 12, 3, CAST(N'2017-10-31 12:07:39.813' AS DateTime), CAST(N'2017-11-01 12:07:39.800' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (17, 1, 1, NULL, NULL, 8, 1, 1, CAST(N'2017-10-31 12:21:06.717' AS DateTime), CAST(N'2017-11-01 12:21:06.693' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (20, 1, 1, 1, NULL, 15, 1, 1, CAST(N'2017-10-31 15:07:01.843' AS DateTime), CAST(N'2017-11-07 15:07:01.843' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (22, 2, 1, 0, 6, NULL, 14, 2, CAST(N'2017-10-31 15:09:27.797' AS DateTime), CAST(N'2017-11-06 15:09:27.797' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (23, 1, 1, 0, NULL, 9, NULL, NULL, CAST(N'2017-10-31 15:24:44.200' AS DateTime), CAST(N'2017-11-01 15:24:44.173' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (25, 1, 1, 0, 7, NULL, NULL, NULL, CAST(N'2017-10-31 15:27:46.837' AS DateTime), CAST(N'2017-11-09 15:27:46.837' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (26, 1, 1, 0, NULL, 10, NULL, NULL, CAST(N'2017-10-31 15:28:07.853' AS DateTime), CAST(N'2017-11-01 15:28:07.830' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (28, 1, 1, 1, NULL, 14, 12, 1, CAST(N'2017-11-02 10:50:59.277' AS DateTime), CAST(N'2017-11-09 10:50:59.277' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (31, 1, 1, 1, 12, NULL, NULL, NULL, CAST(N'2017-11-13 16:53:07.370' AS DateTime), CAST(N'2017-11-18 16:53:07.370' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (32, 1, 1, 0, 13, NULL, NULL, NULL, CAST(N'2017-11-18 17:20:18.827' AS DateTime), CAST(N'2017-11-28 17:20:18.827' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (35, 1, 1, 0, NULL, 16, NULL, NULL, CAST(N'2017-11-20 14:33:56.610' AS DateTime), CAST(N'2017-11-21 14:33:56.583' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (36, 1, 1, 0, NULL, 17, NULL, NULL, CAST(N'2017-11-20 14:34:34.443' AS DateTime), CAST(N'2017-11-20 14:34:34.433' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (37, 1, 1, 0, NULL, 18, NULL, NULL, CAST(N'2017-11-20 14:34:46.813' AS DateTime), CAST(N'2017-11-22 14:34:46.800' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (42, 1, 1, 0, NULL, 19, NULL, NULL, CAST(N'2017-11-20 14:39:36.890' AS DateTime), CAST(N'2017-11-22 14:39:36.877' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (48, 1, 1, 0, NULL, 20, NULL, NULL, CAST(N'2017-11-20 14:47:23.697' AS DateTime), CAST(N'2017-11-24 14:47:23.670' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (49, 1, 1, 0, NULL, 21, NULL, NULL, CAST(N'2017-11-20 14:47:28.320' AS DateTime), CAST(N'2017-11-22 14:47:28.307' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (50, 1, 1, 0, NULL, 22, NULL, NULL, CAST(N'2017-11-20 14:47:33.820' AS DateTime), CAST(N'2017-11-21 14:47:33.807' AS DateTime))
GO
INSERT [dbo].[TicketEmergencia] ([IdTicketEmergencia], [IdPaciente], [IdDestino], [EsViolencia], [IdTicketTrauma], [IdTicketSala], [IdTratamiento], [IdPersonalEmergencia], [Ingreso], [Egreso]) VALUES (51, 1, 1, 0, 14, NULL, NULL, NULL, CAST(N'2017-11-20 14:47:40.010' AS DateTime), CAST(N'2017-11-30 14:47:40.010' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TicketEmergencia] OFF
GO
SET IDENTITY_INSERT [dbo].[TicketSalaObservacion] ON 

GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (5, CAST(N'2017-10-31 12:07:39.813' AS DateTime), CAST(N'2017-11-01 12:07:39.800' AS DateTime), N'Receta médica', N'Consulta general', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (8, CAST(N'2017-10-31 12:21:06.717' AS DateTime), CAST(N'2017-11-01 12:21:06.693' AS DateTime), N'Receta médica', N'Consulta general', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (9, CAST(N'2017-10-31 15:24:44.200' AS DateTime), CAST(N'2017-11-01 15:24:44.173' AS DateTime), N'Receta médica', N'Consulta general', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (10, CAST(N'2017-10-31 15:28:07.853' AS DateTime), CAST(N'2017-11-01 15:28:07.830' AS DateTime), N'Receta médica', N'Consulta general', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (14, CAST(N'2017-11-13 16:54:03.933' AS DateTime), NULL, N'', N'', N'')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (15, CAST(N'2017-11-18 17:53:56.987' AS DateTime), NULL, N'', N'', N'')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (16, CAST(N'2017-11-20 14:33:56.610' AS DateTime), CAST(N'2017-11-21 14:33:56.583' AS DateTime), N'Receta médica', N'Consulta general', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (17, CAST(N'2017-11-20 14:34:34.443' AS DateTime), CAST(N'2017-11-20 14:34:34.433' AS DateTime), N'Receta médica', N'Consulta general', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (18, CAST(N'2017-11-20 14:34:46.813' AS DateTime), CAST(N'2017-11-22 14:34:46.800' AS DateTime), N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (19, CAST(N'2017-11-20 14:39:36.890' AS DateTime), CAST(N'2017-11-22 14:39:36.877' AS DateTime), N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (20, CAST(N'2017-11-20 14:47:23.697' AS DateTime), CAST(N'2017-11-24 14:47:23.670' AS DateTime), N'Medicación bajo control', N'Internado si es necesario', N'Dar aprobación para dar de alta')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (21, CAST(N'2017-11-20 14:47:28.320' AS DateTime), CAST(N'2017-11-22 14:47:28.307' AS DateTime), N'Tratamiento bajo control', N'Varios exámenes médicos', N'Tratamiento a seguir')
GO
INSERT [dbo].[TicketSalaObservacion] ([IdTicketSala], [Ingreso], [Egreso], [Diagnostico], [CondicionIngreso], [CondicionEgreso]) VALUES (22, CAST(N'2017-11-20 14:47:33.820' AS DateTime), CAST(N'2017-11-21 14:47:33.807' AS DateTime), N'Receta médica', N'Consulta general', N'Tratamiento a seguir')
GO
SET IDENTITY_INSERT [dbo].[TicketSalaObservacion] OFF
GO
SET IDENTITY_INSERT [dbo].[TicketTraumaShockTopico] ON 

GO
INSERT [dbo].[TicketTraumaShockTopico] ([IdTicketTrauma], [Ingreso], [Egreso], [Diagnostico], [EsTraumaShock]) VALUES (6, CAST(N'2017-10-31 15:09:27.797' AS DateTime), CAST(N'2017-11-06 15:09:27.797' AS DateTime), N'Cuidado intensivos', 1)
GO
INSERT [dbo].[TicketTraumaShockTopico] ([IdTicketTrauma], [Ingreso], [Egreso], [Diagnostico], [EsTraumaShock]) VALUES (7, CAST(N'2017-10-31 15:27:46.837' AS DateTime), CAST(N'2017-11-09 15:27:46.837' AS DateTime), N'Cuidado intensivos', 1)
GO
INSERT [dbo].[TicketTraumaShockTopico] ([IdTicketTrauma], [Ingreso], [Egreso], [Diagnostico], [EsTraumaShock]) VALUES (12, CAST(N'2017-11-13 16:53:07.370' AS DateTime), CAST(N'2017-11-18 16:53:07.370' AS DateTime), N'Medicación bajo control', 1)
GO
INSERT [dbo].[TicketTraumaShockTopico] ([IdTicketTrauma], [Ingreso], [Egreso], [Diagnostico], [EsTraumaShock]) VALUES (13, CAST(N'2017-11-18 17:20:18.827' AS DateTime), CAST(N'2017-11-28 17:20:18.827' AS DateTime), N'Cuidado intensivos', 1)
GO
INSERT [dbo].[TicketTraumaShockTopico] ([IdTicketTrauma], [Ingreso], [Egreso], [Diagnostico], [EsTraumaShock]) VALUES (14, CAST(N'2017-11-20 14:47:40.010' AS DateTime), CAST(N'2017-11-30 14:47:40.010' AS DateTime), N'Cuidado intensivos', 1)
GO
SET IDENTITY_INSERT [dbo].[TicketTraumaShockTopico] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoPaciente] ON 

GO
INSERT [dbo].[TipoPaciente] ([IdTipoPaciente], [Descripcion]) VALUES (1, N'Pediátrico lactante')
GO
INSERT [dbo].[TipoPaciente] ([IdTipoPaciente], [Descripcion]) VALUES (2, N'Pediátrico pre-escolar')
GO
INSERT [dbo].[TipoPaciente] ([IdTipoPaciente], [Descripcion]) VALUES (3, N'Problemas sistema nervioso')
GO
INSERT [dbo].[TipoPaciente] ([IdTipoPaciente], [Descripcion]) VALUES (4, N'Obstétrica')
GO
INSERT [dbo].[TipoPaciente] ([IdTipoPaciente], [Descripcion]) VALUES (5, N'Adulto')
GO
SET IDENTITY_INSERT [dbo].[TipoPaciente] OFF
GO
SET IDENTITY_INSERT [dbo].[Tratamiento] ON 

GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (1, N'Analgésico')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (2, N'Ansiolítico (contra la ansiedad)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (3, N'Antibiótico (contra las infecciones bacterianas)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (4, N'Anti colinérgico (con efectos sobre el sistema nervioso)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (5, N'Anticonceptivo (para prevenir el embarazo)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (6, N'Anticonvulsivo (contra las convulsiones y otros síntomas de la epilepsia)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (7, N'Antidepresivo (contra la depresión)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (8, N'Antihelmíntico (contra las infecciones intestinales provocadas por gusanos y lombrices (helmintiasis))')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (9, N'Antineoplásico (contra los tumores (neoplasias))')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (10, N'Anti parkinsoniano (contra los síntomas de la enfermedad de Parkinson)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (11, N'Antimicótico (contra los hongos)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (12, N'Antipirético (contra la fiebre)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (13, N'Anti psicótico (contra los síntomas de diferentes tipos de psicosis y de otros padecimientos mentales/emocionales)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (14, N'Antídoto (contra los efectos de los venenos)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (15, N'Bronco dilatador (para dilatar los bronquios; útiles en el tratamiento del asma y de la enfermedad pulmonar obstructiva crónica (EPOC))')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (16, N'Cardiotónico (para fortalecer el músculo cardíaco)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (17, N'Citostático (o citotóxico o quimioterápico) (para interrumpir la división celular; de utilidad en el tratamiento del cáncer)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (18, N'Hipnótico (para obtener relajación, sedación, tranquilidad o sueño en pacientes con ansiedad o con problemas para dormir)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (19, N'Hormonoterápico (para resolver desequilibrios en el funcionamiento hormonal)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (20, N'Quimioterápico (para el tratamiento de tumores cancerosos)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (21, N'Relajante muscular (para la relajación y el alivio de dolores musculares)')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (22, N'Cirugía general')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (23, N'Cirugía ortopédica y traumatología')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (24, N'rehabilitación')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (25, N'Cirugía oral y maxilofacial')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (26, N'Cirugía plástica y reparadora')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (27, N'Cirugía torácica')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (28, N'Cirugía cardíaca')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (29, N'Cirugía oncológica')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (30, N'Cirugía bariátrica')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (31, N'Cirugía vascular')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (32, N'Cirugía pediátrica')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (33, N'Neurocirugía')
GO
INSERT [dbo].[Tratamiento] ([IdTratamiento], [Descripcion]) VALUES (34, N'psicoterapia')
GO
SET IDENTITY_INSERT [dbo].[Tratamiento] OFF
GO
SET IDENTITY_INSERT [dbo].[Triaje] ON 

GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (30, 3, 12, 101)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (31, 4, 12, 104)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (32, 4, 12, 108)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (33, 4, 12, 111)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (52, 4, 17, 104)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (53, 4, 17, 105)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (54, 4, 17, 109)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (55, 4, 17, 112)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (62, 1, 20, 5)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (63, 1, 20, 7)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (64, 1, 20, 9)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (65, 1, 20, 13)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (70, 1, 22, 25)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (71, 1, 22, 30)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (72, 3, 22, 89)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (73, 3, 22, 93)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (74, 3, 22, 100)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (75, 3, 22, 102)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (76, 4, 22, 107)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (77, 4, 22, 112)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (78, 1, 23, 5)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (79, 2, 23, 51)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (80, 2, 23, 58)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (81, 3, 23, 96)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (82, 4, 23, 103)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (88, 1, 25, 5)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (89, 1, 25, 26)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (90, 3, 25, 101)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (91, 4, 25, 108)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (92, 3, 26, 100)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (93, 3, 26, 101)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (94, 3, 26, 102)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (95, 4, 26, 103)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (96, 4, 26, 104)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (97, 4, 26, 105)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (98, 4, 26, 106)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (99, 4, 26, 107)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (100, 4, 26, 108)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (101, 4, 26, 109)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (102, 4, 26, 110)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (103, 4, 26, 111)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (104, 4, 26, 112)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (111, 1, 28, 18)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (112, 1, 28, 12)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (113, 1, 28, 29)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (114, 1, 28, 7)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (121, 1, 31, 18)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (122, 2, 31, 50)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (123, 3, 31, 93)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (124, 1, 32, 6)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (127, 4, 35, 109)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (128, 4, 36, 103)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (129, 3, 37, 84)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (134, 3, 42, 93)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (140, 2, 48, 68)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (141, 3, 49, 95)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (142, 4, 50, 109)
GO
INSERT [dbo].[Triaje] ([IdTriaje], [IdPrioridad], [IdTicketEmergencia], [IdSintoma]) VALUES (143, 1, 51, 1)
GO
SET IDENTITY_INSERT [dbo].[Triaje] OFF
GO
SET IDENTITY_INSERT [dbo].[Turno] ON 

GO
INSERT [dbo].[Turno] ([IdTurno], [NombreTurno], [Rango1], [Rango2]) VALUES (1, N'Turno 1', N'00:00:00', N'08:00:00')
GO
INSERT [dbo].[Turno] ([IdTurno], [NombreTurno], [Rango1], [Rango2]) VALUES (2, N'Turno 2', N'08:00:00', N'16:00:00')
GO
INSERT [dbo].[Turno] ([IdTurno], [NombreTurno], [Rango1], [Rango2]) VALUES (3, N'Turno 3', N'16:00.00', N'24:00:00')
GO
SET IDENTITY_INSERT [dbo].[Turno] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

GO
INSERT [dbo].[Usuario] ([IdUsuario], [CodigoUsuario], [Nombres], [Clave], [EsAutorizador]) VALUES (1, N'RP001', N'Marco Caceda Rubio', N'123', 0)
GO
INSERT [dbo].[Usuario] ([IdUsuario], [CodigoUsuario], [Nombres], [Clave], [EsAutorizador]) VALUES (2, N'RP002', N'Pedro Guille Peralta', N'123', 1)
GO
INSERT [dbo].[Usuario] ([IdUsuario], [CodigoUsuario], [Nombres], [Clave], [EsAutorizador]) VALUES (3, N'RP003', N'Alfredo Tapia Vallejo', N'123', 0)
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
ALTER TABLE [dbo].[DetalleTurno]  WITH CHECK ADD  CONSTRAINT [FK_DetalleTurno_PersonalEmergencia] FOREIGN KEY([IdPersonalEmergencia])
REFERENCES [dbo].[PersonalEmergencia] ([IdPersonalEmergencia])
GO
ALTER TABLE [dbo].[DetalleTurno] CHECK CONSTRAINT [FK_DetalleTurno_PersonalEmergencia]
GO
ALTER TABLE [dbo].[DetalleTurno]  WITH CHECK ADD  CONSTRAINT [FK_DetalleTurno_Turno1] FOREIGN KEY([IdTurno])
REFERENCES [dbo].[Turno] ([IdTurno])
GO
ALTER TABLE [dbo].[DetalleTurno] CHECK CONSTRAINT [FK_DetalleTurno_Turno1]
GO
ALTER TABLE [dbo].[Paciente]  WITH CHECK ADD  CONSTRAINT [FK_Paciente_TipoPaciente] FOREIGN KEY([IdTipoPaciente])
REFERENCES [dbo].[TipoPaciente] ([IdTipoPaciente])
GO
ALTER TABLE [dbo].[Paciente] CHECK CONSTRAINT [FK_Paciente_TipoPaciente]
GO
ALTER TABLE [dbo].[Protocolo]  WITH CHECK ADD  CONSTRAINT [FK_Protocolo_Destino] FOREIGN KEY([IdDestino])
REFERENCES [dbo].[Destino] ([IdDestino])
GO
ALTER TABLE [dbo].[Protocolo] CHECK CONSTRAINT [FK_Protocolo_Destino]
GO
ALTER TABLE [dbo].[Protocolo]  WITH CHECK ADD  CONSTRAINT [FK_Protocolo_Prioridad] FOREIGN KEY([IdPrioridad])
REFERENCES [dbo].[Prioridad] ([IdPrioridad])
GO
ALTER TABLE [dbo].[Protocolo] CHECK CONSTRAINT [FK_Protocolo_Prioridad]
GO
ALTER TABLE [dbo].[Protocolo]  WITH CHECK ADD  CONSTRAINT [FK_Protocolo_Sintoma] FOREIGN KEY([IdSintoma])
REFERENCES [dbo].[Sintoma] ([IdSintoma])
GO
ALTER TABLE [dbo].[Protocolo] CHECK CONSTRAINT [FK_Protocolo_Sintoma]
GO
ALTER TABLE [dbo].[Requerimiento_Insumo]  WITH CHECK ADD  CONSTRAINT [FK_Requerimiento_Insumo_Estados] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estados] ([IdEstado])
GO
ALTER TABLE [dbo].[Requerimiento_Insumo] CHECK CONSTRAINT [FK_Requerimiento_Insumo_Estados]
GO
ALTER TABLE [dbo].[Requerimiento_Insumo]  WITH CHECK ADD  CONSTRAINT [FK_Requerimiento_Insumo_Insumo] FOREIGN KEY([IdInsumo])
REFERENCES [dbo].[Insumo] ([IdInsumo])
GO
ALTER TABLE [dbo].[Requerimiento_Insumo] CHECK CONSTRAINT [FK_Requerimiento_Insumo_Insumo]
GO
ALTER TABLE [dbo].[Requerimiento_Insumo]  WITH CHECK ADD  CONSTRAINT [FK_Requerimiento_Insumo_RequerimientoInsumo] FOREIGN KEY([IdRequerimientoInsumo])
REFERENCES [dbo].[RequerimientoInsumo] ([IdRequerimientoInsumo])
GO
ALTER TABLE [dbo].[Requerimiento_Insumo] CHECK CONSTRAINT [FK_Requerimiento_Insumo_RequerimientoInsumo]
GO
ALTER TABLE [dbo].[RequerimientoInsumo]  WITH CHECK ADD  CONSTRAINT [FK_RequerimientoInsumo_PersonalEmergencia] FOREIGN KEY([IdPersonalEmergencia])
REFERENCES [dbo].[PersonalEmergencia] ([IdPersonalEmergencia])
GO
ALTER TABLE [dbo].[RequerimientoInsumo] CHECK CONSTRAINT [FK_RequerimientoInsumo_PersonalEmergencia]
GO
ALTER TABLE [dbo].[RequerimientoTurno]  WITH CHECK ADD  CONSTRAINT [FK_RequerimientoTurno_PersonalEmergencia] FOREIGN KEY([IdPersonalEmergencia])
REFERENCES [dbo].[PersonalEmergencia] ([IdPersonalEmergencia])
GO
ALTER TABLE [dbo].[RequerimientoTurno] CHECK CONSTRAINT [FK_RequerimientoTurno_PersonalEmergencia]
GO
ALTER TABLE [dbo].[TicketEmergencia]  WITH CHECK ADD  CONSTRAINT [FK_TicketEmergencia_Destino] FOREIGN KEY([IdDestino])
REFERENCES [dbo].[Destino] ([IdDestino])
GO
ALTER TABLE [dbo].[TicketEmergencia] CHECK CONSTRAINT [FK_TicketEmergencia_Destino]
GO
ALTER TABLE [dbo].[TicketEmergencia]  WITH CHECK ADD  CONSTRAINT [FK_TicketEmergencia_Paciente] FOREIGN KEY([IdPaciente])
REFERENCES [dbo].[Paciente] ([IdPaciente])
GO
ALTER TABLE [dbo].[TicketEmergencia] CHECK CONSTRAINT [FK_TicketEmergencia_Paciente]
GO
ALTER TABLE [dbo].[TicketEmergencia]  WITH CHECK ADD  CONSTRAINT [FK_TicketEmergencia_PersonalEmergencia] FOREIGN KEY([IdPersonalEmergencia])
REFERENCES [dbo].[PersonalEmergencia] ([IdPersonalEmergencia])
GO
ALTER TABLE [dbo].[TicketEmergencia] CHECK CONSTRAINT [FK_TicketEmergencia_PersonalEmergencia]
GO
ALTER TABLE [dbo].[TicketEmergencia]  WITH CHECK ADD  CONSTRAINT [FK_TicketEmergencia_TicketSalaObservacion] FOREIGN KEY([IdTicketSala])
REFERENCES [dbo].[TicketSalaObservacion] ([IdTicketSala])
GO
ALTER TABLE [dbo].[TicketEmergencia] CHECK CONSTRAINT [FK_TicketEmergencia_TicketSalaObservacion]
GO
ALTER TABLE [dbo].[TicketEmergencia]  WITH CHECK ADD  CONSTRAINT [FK_TicketEmergencia_TicketTraumaShockTopico] FOREIGN KEY([IdTicketTrauma])
REFERENCES [dbo].[TicketTraumaShockTopico] ([IdTicketTrauma])
GO
ALTER TABLE [dbo].[TicketEmergencia] CHECK CONSTRAINT [FK_TicketEmergencia_TicketTraumaShockTopico]
GO
ALTER TABLE [dbo].[TicketEmergencia]  WITH CHECK ADD  CONSTRAINT [FK_TicketEmergencia_Tratamiento] FOREIGN KEY([IdTratamiento])
REFERENCES [dbo].[Tratamiento] ([IdTratamiento])
GO
ALTER TABLE [dbo].[TicketEmergencia] CHECK CONSTRAINT [FK_TicketEmergencia_Tratamiento]
GO
ALTER TABLE [dbo].[Triaje]  WITH CHECK ADD  CONSTRAINT [FK_Triaje_Prioridad] FOREIGN KEY([IdPrioridad])
REFERENCES [dbo].[Prioridad] ([IdPrioridad])
GO
ALTER TABLE [dbo].[Triaje] CHECK CONSTRAINT [FK_Triaje_Prioridad]
GO
ALTER TABLE [dbo].[Triaje]  WITH CHECK ADD  CONSTRAINT [FK_Triaje_Sintoma] FOREIGN KEY([IdSintoma])
REFERENCES [dbo].[Sintoma] ([IdSintoma])
GO
ALTER TABLE [dbo].[Triaje] CHECK CONSTRAINT [FK_Triaje_Sintoma]
GO
ALTER TABLE [dbo].[Triaje]  WITH CHECK ADD  CONSTRAINT [FK_Triaje_TicketEmergencia] FOREIGN KEY([IdTicketEmergencia])
REFERENCES [dbo].[TicketEmergencia] ([IdTicketEmergencia])
GO
ALTER TABLE [dbo].[Triaje] CHECK CONSTRAINT [FK_Triaje_TicketEmergencia]
GO
