USE [master]
GO
/****** Object:  Database [QLKSWEB]    Script Date: 25/10/2020 18:34:23 ******/
CREATE DATABASE [QLKSWEB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLKSWEB', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLKSWEB.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLKSWEB_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLKSWEB_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLKSWEB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLKSWEB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLKSWEB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLKSWEB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLKSWEB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLKSWEB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLKSWEB] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLKSWEB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLKSWEB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLKSWEB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLKSWEB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLKSWEB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLKSWEB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLKSWEB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLKSWEB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLKSWEB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLKSWEB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLKSWEB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLKSWEB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLKSWEB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLKSWEB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLKSWEB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLKSWEB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLKSWEB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLKSWEB] SET RECOVERY FULL 
GO
ALTER DATABASE [QLKSWEB] SET  MULTI_USER 
GO
ALTER DATABASE [QLKSWEB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLKSWEB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLKSWEB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLKSWEB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLKSWEB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLKSWEB', N'ON'
GO
USE [QLKSWEB]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(0,5) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Disabled] [bit] NOT NULL,
	[AccountTypeID] [int] NOT NULL,
	[Image] [nvarchar](250) NULL,
 CONSTRAINT [PK__Account__349DA5864ABDB388] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountPermission]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountPermission](
	[AccPerID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NULL,
	[ModuleID] [int] NULL,
	[Permission] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccPerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AccountType]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountType](
	[AccountTypeID] [int] IDENTITY(0,5) NOT NULL,
	[AccountTypeName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bill]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[BillID] [int] IDENTITY(1,1) NOT NULL,
	[CheckinDate] [datetime] NULL,
	[CheckoutDate] [datetime] NULL,
	[Deposit] [decimal](19, 4) NULL,
	[Discount] [decimal](19, 4) NULL,
	[BillStatus] [nvarchar](100) NOT NULL,
	[Total] [decimal](19, 4) NULL,
	[Notes] [nvarchar](500) NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BillDetail]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillDetail](
	[BillDetailID] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NULL,
	[TotalSerivcesPrices] [decimal](19, 4) NULL,
	[Compensation] [decimal](19, 4) NULL,
	[ServicesID] [int] NULL,
	[RoomID] [int] NULL,
	[BillID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BillDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Booking]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[RoomTypeID] [int] NULL,
	[BookDate] [datetime] NULL,
	[CheckinDate] [datetime] NULL,
	[CheckoutDate] [datetime] NULL,
	[Deposit] [decimal](19, 4) NULL,
	[BookingType] [nvarchar](250) NULL,
	[BookingStatus] [nvarchar](250) NULL,
	[BookingNotes] [nvarchar](500) NULL,
	[CreatedUserID] [int] NULL,
	[CustomerID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookingRoom]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingRoom](
	[BookingRoomID] [int] IDENTITY(1,1) NOT NULL,
	[BookingID] [int] NULL,
	[RoomID] [int] NULL,
	[IsBooking] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingRoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookingServices]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingServices](
	[BookingServicesID] [int] IDENTITY(1,1) NOT NULL,
	[BookingID] [int] NULL,
	[ServicesID] [int] NULL,
	[Quantity] [int] NULL,
	[IsBooking] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingServicesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](250) NULL,
	[BirthDay] [datetime] NULL,
	[Gender] [nvarchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[Passport] [varchar](50) NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
	[CardType] [nvarchar](250) NULL,
	[CardNo] [nvarchar](50) NULL,
	[NameOnCard] [nvarchar](250) NULL,
	[ExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[EquipmentID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentName] [nvarchar](250) NULL,
	[EquipPrices] [decimal](19, 4) NULL,
	[DateBuy] [datetime] NULL,
	[EquipStatus] [tinyint] NOT NULL,
	[EquipmentTypeID] [int] NOT NULL,
	[RoomID] [int] NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
	[Image] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EquipmentType]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentType](
	[EquipmentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentTypeName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EquipmentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EquipRequest]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipRequest](
	[EquipRequestID] [int] NOT NULL,
	[RequestID] [int] NULL,
	[EquipID] [int] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EquipRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaintenanceHistory]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[DateMaintenance] [datetime] NULL,
	[DateFinished] [datetime] NULL,
	[MaintenancePrices] [decimal](19, 4) NULL,
	[EquipmentID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ModuleList]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleList](
	[ModuleID] [int] IDENTITY(19,4) NOT NULL,
	[ModuleName] [nvarchar](250) NULL,
	[ModuleIcon] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromotionID] [int] IDENTITY(0,5) NOT NULL,
	[PromotionName] [nvarchar](250) NULL,
	[PercentDiscount] [decimal](19, 4) NULL,
	[PromotionContent] [nvarchar](max) NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PromotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Request]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[RequesterName] [nvarchar](250) NULL,
	[Prices] [decimal](19, 4) NULL,
	[RequestDescription] [nvarchar](500) NULL,
	[RequestTypeID] [int] NOT NULL,
	[EquipmentID] [int] NULL,
	[RoomID] [int] NULL,
	[RequestStatus] [nvarchar](100) NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RequestType]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestType](
	[RequestTypeID] [int] IDENTITY(1,1) NOT NULL,
	[RequestTypeName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Room]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[RoomName] [nvarchar](250) NULL,
	[RoomStatus] [nvarchar](100) NULL,
	[RoomNotes] [nvarchar](250) NULL,
	[RoomDescription] [nvarchar](500) NULL,
	[MinQuantity] [int] NULL,
	[MaxQuantity] [int] NULL,
	[RoomTypeID] [int] NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
	[Image] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoomRequest]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomRequest](
	[RoomRequestID] [int] IDENTITY(1,1) NOT NULL,
	[RoomID] [int] NULL,
	[RequestID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoomServices]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomServices](
	[RoomServicesID] [int] IDENTITY(1,1) NOT NULL,
	[RoomID] [int] NULL,
	[ServicesID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomServicesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomType](
	[RoomTypeID] [int] IDENTITY(0,5) NOT NULL,
	[RoomTypeName] [nvarchar](250) NULL,
	[RoomTypePrices] [decimal](19, 4) NULL,
	[RoomTypeDescription] [nvarchar](max) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
	[IsPay] [tinyint] NULL,
	[IsShowHomePage] [tinyint] NULL,
	[IsShow] [tinyint] NULL,
	[RoomTypeImage] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Services]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[ServicesID] [int] IDENTITY(1,1) NOT NULL,
	[ServicesName] [nvarchar](250) NULL,
	[ServicesDescription] [nvarchar](500) NULL,
	[ServicesContent] [nvarchar](max) NULL,
	[ServicesPrices] [decimal](19, 4) NULL,
	[Unit] [nvarchar](100) NULL,
	[ServicesDetail] [nvarchar](250) NULL,
	[ServicesTypeID] [int] NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
	[IsAvailable] [bit] NULL,
	[IsPay] [bit] NULL,
	[IsShowHomePage] [bit] NULL,
	[IsShow] [bit] NULL,
	[Image] [nvarchar](250) NULL,
	[IsBookWithRoom] [bit] NULL,
	[IsSelected] [bit] NOT NULL,
 CONSTRAINT [PK__Services__BE1AC7037076F1F8] PRIMARY KEY CLUSTERED 
(
	[ServicesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServicesType]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicesType](
	[ServicesTypeID] [int] IDENTITY(0,5) NOT NULL,
	[ServicesTypeName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreatedUserID] [int] NULL,
	[ModifyUserID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateModify] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServicesTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountID], [UserName], [Password], [Disabled], [AccountTypeID], [Image]) VALUES (0, N'admin', N'123', 0, 0, NULL)
INSERT [dbo].[Account] ([AccountID], [UserName], [Password], [Disabled], [AccountTypeID], [Image]) VALUES (5, N'minhhieu', N'123', 0, 5, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[AccountPermission] ON 

INSERT [dbo].[AccountPermission] ([AccPerID], [AccountID], [ModuleID], [Permission]) VALUES (1, 5, 19, NULL)
INSERT [dbo].[AccountPermission] ([AccPerID], [AccountID], [ModuleID], [Permission]) VALUES (2, 5, 27, NULL)
INSERT [dbo].[AccountPermission] ([AccPerID], [AccountID], [ModuleID], [Permission]) VALUES (3, 5, 35, NULL)
INSERT [dbo].[AccountPermission] ([AccPerID], [AccountID], [ModuleID], [Permission]) VALUES (4, 5, 39, NULL)
INSERT [dbo].[AccountPermission] ([AccPerID], [AccountID], [ModuleID], [Permission]) VALUES (5, 5, 43, NULL)
SET IDENTITY_INSERT [dbo].[AccountPermission] OFF
SET IDENTITY_INSERT [dbo].[AccountType] ON 

INSERT [dbo].[AccountType] ([AccountTypeID], [AccountTypeName], [Disabled]) VALUES (0, N'Admin', 0)
INSERT [dbo].[AccountType] ([AccountTypeID], [AccountTypeName], [Disabled]) VALUES (5, N'Reception', 0)
INSERT [dbo].[AccountType] ([AccountTypeID], [AccountTypeName], [Disabled]) VALUES (10, N'Technical', 0)
INSERT [dbo].[AccountType] ([AccountTypeID], [AccountTypeName], [Disabled]) VALUES (15, N'Account', 0)
INSERT [dbo].[AccountType] ([AccountTypeID], [AccountTypeName], [Disabled]) VALUES (20, N'Housekeeping', 0)
SET IDENTITY_INSERT [dbo].[AccountType] OFF
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([BillID], [CheckinDate], [CheckoutDate], [Deposit], [Discount], [BillStatus], [Total], [Notes], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (4, CAST(N'2020-10-25 16:52:58.007' AS DateTime), CAST(N'2020-10-25 18:24:44.457' AS DateTime), NULL, NULL, N'PAID', CAST(2250000.0000 AS Decimal(19, 4)), NULL, 0, NULL, CAST(N'2020-10-25 16:52:58.007' AS DateTime), CAST(N'2020-10-25 18:24:44.457' AS DateTime))
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillDetail] ON 

INSERT [dbo].[BillDetail] ([BillDetailID], [Quantity], [TotalSerivcesPrices], [Compensation], [ServicesID], [RoomID], [BillID]) VALUES (8, 1, CAST(2000000.0000 AS Decimal(19, 4)), NULL, 7, 3, 4)
INSERT [dbo].[BillDetail] ([BillDetailID], [Quantity], [TotalSerivcesPrices], [Compensation], [ServicesID], [RoomID], [BillID]) VALUES (9, 5, CAST(500000.0000 AS Decimal(19, 4)), NULL, 4, 3, 4)
SET IDENTITY_INSERT [dbo].[BillDetail] OFF
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([BookingID], [RoomTypeID], [BookDate], [CheckinDate], [CheckoutDate], [Deposit], [BookingType], [BookingStatus], [BookingNotes], [CreatedUserID], [CustomerID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (11, 5, CAST(N'2020-10-25 16:48:58.053' AS DateTime), CAST(N'2020-10-25 00:00:00.000' AS DateTime), CAST(N'2020-10-28 00:00:00.000' AS DateTime), NULL, N'ROOM', N'DONE', NULL, NULL, 6, NULL, CAST(N'2020-10-25 16:48:58.053' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Booking] OFF
SET IDENTITY_INSERT [dbo].[BookingRoom] ON 

INSERT [dbo].[BookingRoom] ([BookingRoomID], [BookingID], [RoomID], [IsBooking]) VALUES (9, 11, 3, 1)
SET IDENTITY_INSERT [dbo].[BookingRoom] OFF
SET IDENTITY_INSERT [dbo].[BookingServices] ON 

INSERT [dbo].[BookingServices] ([BookingServicesID], [BookingID], [ServicesID], [Quantity], [IsBooking]) VALUES (18, 11, 7, 1, NULL)
SET IDENTITY_INSERT [dbo].[BookingServices] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [CustomerName], [BirthDay], [Gender], [Phone], [Email], [Passport], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [CardType], [CardNo], [NameOnCard], [ExpirationDate]) VALUES (6, N'Nguyễn Văn Tèo', CAST(N'2020-10-20 00:00:00.000' AS DateTime), NULL, N'123', N'vanteo@gmail.com', N'123123', NULL, NULL, NULL, NULL, N'Master Card', N'6777778767676', N'NGUYEN VAN TEO', CAST(N'2020-10-31 00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([CustomerID], [CustomerName], [BirthDay], [Gender], [Phone], [Email], [Passport], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [CardType], [CardNo], [NameOnCard], [ExpirationDate]) VALUES (7, N'Lê Hồng Phong', CAST(N'1998-10-14 00:00:00.000' AS DateTime), NULL, N'123345647', N'hongphong@gmail.com', N'123123123', NULL, NULL, NULL, NULL, N'Visa', N'1231512315123', N'LE HONG PHONG', CAST(N'2021-10-31 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([EquipmentID], [EquipmentName], [EquipPrices], [DateBuy], [EquipStatus], [EquipmentTypeID], [RoomID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (1, N'Máy lạnh Panasonic Inverter 1.5 HP CU/CS-XU12UKH-8', CAST(15190000.0000 AS Decimal(19, 4)), CAST(N'2020-02-15 00:00:00.000' AS DateTime), 0, 1, 1, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Equipment] OFF
SET IDENTITY_INSERT [dbo].[EquipmentType] ON 

INSERT [dbo].[EquipmentType] ([EquipmentTypeID], [EquipmentTypeName], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (1, N'Máy lạnh', 0, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[EquipmentType] OFF
SET IDENTITY_INSERT [dbo].[ModuleList] ON 

INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (19, N'Quản lý phòng', N'<i class="fas fa-hotel"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (23, N'Quản lý hoá đơn', N'<i class="fas fa-receipt"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (27, N'Quản lý dịch vụ', N'<i class="fas fa-spa"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (31, N'Quản lý tài khoản', N'<i class="fas fa-user"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (35, N'Quản lý đặt phòng', N'<i class="fas fa-sticky-note"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (39, N'Quản lý đặt dịch vụ', N'<i class="fas fa-ad"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (43, N'Quản lý trang thiết bị', N'<i class="fas fa-cubes"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (47, N'Quản lý phiếu đề xuất', N'<i class="fas fa-paste"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (51, N'Quản lý danh mục', N'<i class="far fa-list-alt"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (55, N'Quản lý tin tức', N'<i class="far fa-newspaper"></i>')
INSERT [dbo].[ModuleList] ([ModuleID], [ModuleName], [ModuleIcon]) VALUES (59, N'Báo cáo', N'<i class="fas fa-chart-line"></i>')
SET IDENTITY_INSERT [dbo].[ModuleList] OFF
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [PercentDiscount], [PromotionContent], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (0, N'Khuyến mãi siêu khủng', CAST(10.0000 AS Decimal(19, 4)), N'Khuyến mãi siêu khủng', 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
SET IDENTITY_INSERT [dbo].[Request] ON 

INSERT [dbo].[Request] ([RequestID], [RequesterName], [Prices], [RequestDescription], [RequestTypeID], [EquipmentID], [RoomID], [RequestStatus], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (8, N'Nguyễn Văn A', CAST(50000.0000 AS Decimal(19, 4)), N'Vệ sinh máy lạnh', 1, 1, NULL, N'OPEN', NULL, NULL, CAST(N'2020-10-23 11:06:32.270' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Request] OFF
SET IDENTITY_INSERT [dbo].[RequestType] ON 

INSERT [dbo].[RequestType] ([RequestTypeID], [RequestTypeName], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (1, N'Sửa thiết bị', 0, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[RequestType] OFF
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([RoomID], [RoomName], [RoomStatus], [RoomNotes], [RoomDescription], [MinQuantity], [MaxQuantity], [RoomTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (1, N'101', N'OPEN', NULL, NULL, 0, 2, 0, 0, NULL, CAST(N'2020-10-11 16:26:26.547' AS DateTime), NULL, NULL)
INSERT [dbo].[Room] ([RoomID], [RoomName], [RoomStatus], [RoomNotes], [RoomDescription], [MinQuantity], [MaxQuantity], [RoomTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (2, N'201', N'OPEN', NULL, NULL, 0, 2, 0, 0, NULL, CAST(N'2020-10-11 16:27:03.780' AS DateTime), NULL, NULL)
INSERT [dbo].[Room] ([RoomID], [RoomName], [RoomStatus], [RoomNotes], [RoomDescription], [MinQuantity], [MaxQuantity], [RoomTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (3, N'301', N'OPEN', NULL, NULL, 0, 2, 5, 0, NULL, CAST(N'2020-10-11 16:27:15.323' AS DateTime), NULL, NULL)
INSERT [dbo].[Room] ([RoomID], [RoomName], [RoomStatus], [RoomNotes], [RoomDescription], [MinQuantity], [MaxQuantity], [RoomTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (4, N'401', N'OPEN', NULL, NULL, 0, 2, 5, 0, NULL, CAST(N'2020-10-11 16:27:24.977' AS DateTime), NULL, NULL)
INSERT [dbo].[Room] ([RoomID], [RoomName], [RoomStatus], [RoomNotes], [RoomDescription], [MinQuantity], [MaxQuantity], [RoomTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (5, N'501', N'OPEN', NULL, NULL, 0, 2, 10, 0, NULL, CAST(N'2020-10-11 16:27:35.143' AS DateTime), NULL, NULL)
INSERT [dbo].[Room] ([RoomID], [RoomName], [RoomStatus], [RoomNotes], [RoomDescription], [MinQuantity], [MaxQuantity], [RoomTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (6, N'601', N'OPEN', NULL, NULL, 0, 2, 15, 0, NULL, CAST(N'2020-10-11 16:27:44.880' AS DateTime), NULL, NULL)
INSERT [dbo].[Room] ([RoomID], [RoomName], [RoomStatus], [RoomNotes], [RoomDescription], [MinQuantity], [MaxQuantity], [RoomTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [Image]) VALUES (7, N'701', N'OPEN', NULL, NULL, 0, 2, 15, 0, NULL, CAST(N'2020-10-11 16:27:55.547' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Room] OFF
SET IDENTITY_INSERT [dbo].[RoomServices] ON 

INSERT [dbo].[RoomServices] ([RoomServicesID], [RoomID], [ServicesID]) VALUES (1, 1, 1)
INSERT [dbo].[RoomServices] ([RoomServicesID], [RoomID], [ServicesID]) VALUES (3, 1, 2)
INSERT [dbo].[RoomServices] ([RoomServicesID], [RoomID], [ServicesID]) VALUES (4, 2, 1)
SET IDENTITY_INSERT [dbo].[RoomServices] OFF
SET IDENTITY_INSERT [dbo].[RoomType] ON 

INSERT [dbo].[RoomType] ([RoomTypeID], [RoomTypeName], [RoomTypePrices], [RoomTypeDescription], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsPay], [IsShowHomePage], [IsShow], [RoomTypeImage]) VALUES (0, N'Standard', CAST(250000.0000 AS Decimal(19, 4)), N'The Colonial Suite featuring a private living room and a master bedroom is one of our most spacious and premium suites. The wooden furnishings in Colonial classic French style and the 60 m2-large space will bring privacy but luxury and elegance, no less.', 0, 0, NULL, CAST(N'2020-10-11 16:24:28.007' AS DateTime), NULL, 1, 1, 1, N'/Assets/images/room-1.jpg')
INSERT [dbo].[RoomType] ([RoomTypeID], [RoomTypeName], [RoomTypePrices], [RoomTypeDescription], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsPay], [IsShowHomePage], [IsShow], [RoomTypeImage]) VALUES (5, N'Superior', CAST(300000.0000 AS Decimal(19, 4)), N'With the views to Dong Khoi St., one of the most major arterial and eventful roads in Ho Chi Minh City, Colonial City Rooms offering the perfect balance of luxury and elegance will be an unique experience for those who love the peerage and antique.', 0, 0, NULL, CAST(N'2020-10-11 16:24:50.467' AS DateTime), NULL, 1, 1, 1, N'/Assets/images/room-3.jpg')
INSERT [dbo].[RoomType] ([RoomTypeID], [RoomTypeName], [RoomTypePrices], [RoomTypeDescription], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsPay], [IsShowHomePage], [IsShow], [RoomTypeImage]) VALUES (10, N'Deluxe', CAST(350000.0000 AS Decimal(19, 4)), N'Decorated in our signature of warm color palette, Deluxe Rooms feature all the top line guests amenities and services of the hotel’s Traditional Rooms. All our deluxe rooms can accommodate up to 2 persons.', 0, 0, NULL, CAST(N'2020-10-11 16:25:07.560' AS DateTime), NULL, 1, 1, 1, N'/Assets/images/room-4.jpg')
INSERT [dbo].[RoomType] ([RoomTypeID], [RoomTypeName], [RoomTypePrices], [RoomTypeDescription], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsPay], [IsShowHomePage], [IsShow], [RoomTypeImage]) VALUES (15, N'Suite ', CAST(500000.0000 AS Decimal(19, 4)), N'The only hotel owns the balcony overlooking Saigon River and offers full of high quality facilities, this will bring a unique and memorable experience for guests especially for the newly wed couples.', 0, 0, NULL, CAST(N'2020-10-11 16:25:29.103' AS DateTime), NULL, 1, 1, 1, N'/Assets/images/room-2.jpg')
INSERT [dbo].[RoomType] ([RoomTypeID], [RoomTypeName], [RoomTypePrices], [RoomTypeDescription], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsPay], [IsShowHomePage], [IsShow], [RoomTypeImage]) VALUES (20, N'Colonial
 
River
 
Deluxe', CAST(400000.0000 AS Decimal(19, 4)), N'Colonial Majestic Suite is the perfect choice of a luxury accommodation with the most impressive panoramic views of Saigon River. Featuring a living room and a separate bedroom with a working desk, these one-bedroom suites are perfect for guests looking for a little more space.', 0, 0, NULL, CAST(N'2020-10-23 09:41:18.033' AS DateTime), NULL, 1, 1, 1, N'/Assets/images/room-6.jpg')
INSERT [dbo].[RoomType] ([RoomTypeID], [RoomTypeName], [RoomTypePrices], [RoomTypeDescription], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsPay], [IsShowHomePage], [IsShow], [RoomTypeImage]) VALUES (25, N'Colonial
 
Pool
 
Deluxe', CAST(450000.0000 AS Decimal(19, 4)), N'With a quiet and fresh space, Colonial Pool Deluxe featuring the balcony overlooking the pool will be perfect for those looking for luxurious comfort with a touch of tranquility in the heart of Saigon.\', 0, 0, NULL, CAST(N'2020-10-23 09:41:48.130' AS DateTime), NULL, 1, 1, 1, N'/Assets/images/room-5.jpg')
SET IDENTITY_INSERT [dbo].[RoomType] OFF
SET IDENTITY_INSERT [dbo].[Services] ON 

INSERT [dbo].[Services] ([ServicesID], [ServicesName], [ServicesDescription], [ServicesContent], [ServicesPrices], [Unit], [ServicesDetail], [ServicesTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsAvailable], [IsPay], [IsShowHomePage], [IsShow], [Image], [IsBookWithRoom], [IsSelected]) VALUES (1, N'FreeWifi', NULL, NULL, CAST(0.0000 AS Decimal(19, 4)), NULL, NULL, 0, 0, NULL, CAST(N'2020-10-15 21:06:48.563' AS DateTime), NULL, 0, 0, 0, 0, NULL, 0, 0)
INSERT [dbo].[Services] ([ServicesID], [ServicesName], [ServicesDescription], [ServicesContent], [ServicesPrices], [Unit], [ServicesDetail], [ServicesTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsAvailable], [IsPay], [IsShowHomePage], [IsShow], [Image], [IsBookWithRoom], [IsSelected]) VALUES (2, N'FreeBuffe', NULL, NULL, CAST(0.0000 AS Decimal(19, 4)), NULL, NULL, 0, 0, NULL, CAST(N'2020-10-15 21:07:33.737' AS DateTime), NULL, 0, 0, 0, 0, NULL, 0, 0)
INSERT [dbo].[Services] ([ServicesID], [ServicesName], [ServicesDescription], [ServicesContent], [ServicesPrices], [Unit], [ServicesDetail], [ServicesTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsAvailable], [IsPay], [IsShowHomePage], [IsShow], [Image], [IsBookWithRoom], [IsSelected]) VALUES (3, N'Heniken', NULL, NULL, CAST(30000.0000 AS Decimal(19, 4)), N'Bottle', NULL, 10, 0, NULL, CAST(N'2020-10-15 21:09:13.530' AS DateTime), NULL, 0, 0, 0, 0, NULL, 0, 0)
INSERT [dbo].[Services] ([ServicesID], [ServicesName], [ServicesDescription], [ServicesContent], [ServicesPrices], [Unit], [ServicesDetail], [ServicesTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsAvailable], [IsPay], [IsShowHomePage], [IsShow], [Image], [IsBookWithRoom], [IsSelected]) VALUES (4, N'Pizza', NULL, NULL, CAST(100000.0000 AS Decimal(19, 4)), N'Pizza', NULL, 5, 0, NULL, CAST(N'2020-10-15 21:12:06.287' AS DateTime), NULL, 0, 0, 0, 0, NULL, 0, 0)
INSERT [dbo].[Services] ([ServicesID], [ServicesName], [ServicesDescription], [ServicesContent], [ServicesPrices], [Unit], [ServicesDetail], [ServicesTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsAvailable], [IsPay], [IsShowHomePage], [IsShow], [Image], [IsBookWithRoom], [IsSelected]) VALUES (5, N'Meeting Room', NULL, NULL, NULL, NULL, NULL, 15, 0, NULL, CAST(N'2020-10-15 21:12:49.430' AS DateTime), NULL, 0, 1, 1, 1, NULL, 0, 0)
INSERT [dbo].[Services] ([ServicesID], [ServicesName], [ServicesDescription], [ServicesContent], [ServicesPrices], [Unit], [ServicesDetail], [ServicesTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsAvailable], [IsPay], [IsShowHomePage], [IsShow], [Image], [IsBookWithRoom], [IsSelected]) VALUES (6, N'1 WAY AIRPORT TRANSFER', NULL, NULL, CAST(500000.0000 AS Decimal(19, 4)), N'Room', NULL, 15, 0, NULL, CAST(N'2020-10-15 21:29:10.447' AS DateTime), NULL, 0, 1, 0, 0, NULL, 1, 0)
INSERT [dbo].[Services] ([ServicesID], [ServicesName], [ServicesDescription], [ServicesContent], [ServicesPrices], [Unit], [ServicesDetail], [ServicesTypeID], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify], [IsAvailable], [IsPay], [IsShowHomePage], [IsShow], [Image], [IsBookWithRoom], [IsSelected]) VALUES (7, N'Vòng quanh thành phố', NULL, NULL, CAST(2000000.0000 AS Decimal(19, 4)), N'Trip', NULL, 15, 0, NULL, CAST(N'2020-10-17 19:42:50.000' AS DateTime), NULL, 0, NULL, NULL, NULL, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Services] OFF
SET IDENTITY_INSERT [dbo].[ServicesType] ON 

INSERT [dbo].[ServicesType] ([ServicesTypeID], [ServicesTypeName], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (0, N'RoomServices', 0, 0, NULL, CAST(N'2020-10-15 20:57:03.430' AS DateTime), NULL)
INSERT [dbo].[ServicesType] ([ServicesTypeID], [ServicesTypeName], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (5, N'Food', 0, 0, NULL, CAST(N'2020-10-15 20:57:20.197' AS DateTime), NULL)
INSERT [dbo].[ServicesType] ([ServicesTypeID], [ServicesTypeName], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (10, N'Beverage', 0, 0, NULL, CAST(N'2020-10-15 20:57:51.940' AS DateTime), NULL)
INSERT [dbo].[ServicesType] ([ServicesTypeID], [ServicesTypeName], [Disabled], [CreatedUserID], [ModifyUserID], [DateCreated], [DateModify]) VALUES (15, N'Others', 0, 0, NULL, CAST(N'2020-10-15 21:04:51.853' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[ServicesType] OFF
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF__Account__Passwor__1367E606]  DEFAULT ('123') FOR [Password]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF__Account__Disable__145C0A3F]  DEFAULT ('0') FOR [Disabled]
GO
ALTER TABLE [dbo].[AccountType] ADD  DEFAULT ('0') FOR [Disabled]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Booking] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[BookingRoom] ADD  DEFAULT ((0)) FOR [IsBooking]
GO
ALTER TABLE [dbo].[BookingServices] ADD  DEFAULT ((0)) FOR [IsBooking]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Equipment] ADD  DEFAULT ((0)) FOR [EquipStatus]
GO
ALTER TABLE [dbo].[Equipment] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[EquipmentType] ADD  DEFAULT ((0)) FOR [Disabled]
GO
ALTER TABLE [dbo].[EquipmentType] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Request] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[RequestType] ADD  DEFAULT ((0)) FOR [Disabled]
GO
ALTER TABLE [dbo].[RequestType] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Room] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[RoomType] ADD  DEFAULT ((0)) FOR [Disabled]
GO
ALTER TABLE [dbo].[RoomType] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[RoomType] ADD  DEFAULT ((0)) FOR [IsPay]
GO
ALTER TABLE [dbo].[RoomType] ADD  DEFAULT ((0)) FOR [IsShowHomePage]
GO
ALTER TABLE [dbo].[RoomType] ADD  DEFAULT ((0)) FOR [IsShow]
GO
ALTER TABLE [dbo].[Services] ADD  CONSTRAINT [DF__Services__DateCr__3A81B327]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Services] ADD  CONSTRAINT [DF__Services__IsAvai__3B75D760]  DEFAULT ((0)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Services] ADD  CONSTRAINT [DF__Services__IsPay__3C69FB99]  DEFAULT ((0)) FOR [IsPay]
GO
ALTER TABLE [dbo].[Services] ADD  CONSTRAINT [DF__Services__IsShow__3D5E1FD2]  DEFAULT ((0)) FOR [IsShowHomePage]
GO
ALTER TABLE [dbo].[Services] ADD  CONSTRAINT [DF__Services__IsShow__3E52440B]  DEFAULT ((0)) FOR [IsShow]
GO
ALTER TABLE [dbo].[Services] ADD  CONSTRAINT [DF__Services__IsSele__3F466844]  DEFAULT ((0)) FOR [IsSelected]
GO
ALTER TABLE [dbo].[ServicesType] ADD  DEFAULT ((0)) FOR [Disabled]
GO
ALTER TABLE [dbo].[ServicesType] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK__Account__Image__15502E78] FOREIGN KEY([AccountTypeID])
REFERENCES [dbo].[AccountType] ([AccountTypeID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK__Account__Image__15502E78]
GO
ALTER TABLE [dbo].[AccountPermission]  WITH CHECK ADD  CONSTRAINT [FK__AccountPe__Accou__70DDC3D8] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[AccountPermission] CHECK CONSTRAINT [FK__AccountPe__Accou__70DDC3D8]
GO
ALTER TABLE [dbo].[AccountPermission]  WITH CHECK ADD FOREIGN KEY([ModuleID])
REFERENCES [dbo].[ModuleList] ([ModuleID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK__Bill__DateModify__52593CB8] FOREIGN KEY([CreatedUserID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK__Bill__DateModify__52593CB8]
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD FOREIGN KEY([BillID])
REFERENCES [dbo].[Bill] ([BillID])
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD  CONSTRAINT [FK__BillDetai__Servi__5535A963] FOREIGN KEY([ServicesID])
REFERENCES [dbo].[Services] ([ServicesID])
GO
ALTER TABLE [dbo].[BillDetail] CHECK CONSTRAINT [FK__BillDetai__Servi__5535A963]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__DateMod__4CA06362] FOREIGN KEY([CreatedUserID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__DateMod__4CA06362]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([RoomTypeID])
REFERENCES [dbo].[RoomType] ([RoomTypeID])
GO
ALTER TABLE [dbo].[BookingRoom]  WITH CHECK ADD FOREIGN KEY([BookingID])
REFERENCES [dbo].[Booking] ([BookingID])
GO
ALTER TABLE [dbo].[BookingRoom]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[BookingServices]  WITH CHECK ADD FOREIGN KEY([BookingID])
REFERENCES [dbo].[Booking] ([BookingID])
GO
ALTER TABLE [dbo].[BookingServices]  WITH CHECK ADD  CONSTRAINT [FK__BookingSe__Servi__60A75C0F] FOREIGN KEY([ServicesID])
REFERENCES [dbo].[Services] ([ServicesID])
GO
ALTER TABLE [dbo].[BookingServices] CHECK CONSTRAINT [FK__BookingSe__Servi__60A75C0F]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD FOREIGN KEY([EquipmentTypeID])
REFERENCES [dbo].[EquipmentType] ([EquipmentTypeID])
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[EquipRequest]  WITH CHECK ADD FOREIGN KEY([EquipID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[EquipRequest]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
GO
ALTER TABLE [dbo].[MaintenanceHistory]  WITH CHECK ADD FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [FK__Promotion__DateM__1920BF5C] FOREIGN KEY([CreatedUserID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [FK__Promotion__DateM__1920BF5C]
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([RequestTypeID])
REFERENCES [dbo].[RequestType] ([RequestTypeID])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([RoomTypeID])
REFERENCES [dbo].[RoomType] ([RoomTypeID])
GO
ALTER TABLE [dbo].[RoomRequest]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
GO
ALTER TABLE [dbo].[RoomRequest]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[RoomServices]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[RoomServices]  WITH CHECK ADD  CONSTRAINT [FK__RoomServi__Servi__6477ECF3] FOREIGN KEY([ServicesID])
REFERENCES [dbo].[Services] ([ServicesID])
GO
ALTER TABLE [dbo].[RoomServices] CHECK CONSTRAINT [FK__RoomServi__Servi__6477ECF3]
GO
ALTER TABLE [dbo].[Services]  WITH CHECK ADD  CONSTRAINT [FK__Services__IsSele__403A8C7D] FOREIGN KEY([ServicesTypeID])
REFERENCES [dbo].[ServicesType] ([ServicesTypeID])
GO
ALTER TABLE [dbo].[Services] CHECK CONSTRAINT [FK__Services__IsSele__403A8C7D]
GO
/****** Object:  StoredProcedure [dbo].[Find_AvailableRoom]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Find_AvailableRoom]
(
	@NumPerson INT ,
	@CheckinDate DATETIME,
	@CheckoutDate DATETIME
)
AS
BEGIN

CREATE TABLE #AvailableRoom1 (RoomTypeID int,RoomTypeName NVARCHAR(250), RoomTypePrices DECIMAL(19,4),RoomTypeDescription NVARCHAR(max), RoomTypeImage NVARCHAR(max))
CREATE TABLE #AvailableRoom2 (RoomTypeID INT,RoomTypeName NVARCHAR(250), RoomTypePrices DECIMAL(19,4),RoomTypeDescription NVARCHAR(max), RoomTypeImage NVARCHAR(max))

	IF (SELECT COUNT(*) FROM dbo.Room WHERE RoomStatus = 'OPEN') >= 1
	BEGIN
		INSERT INTO #AvailableRoom1 
		SELECT		T1.RoomTypeID,T1.RoomTypeName , T1.RoomTypePrices, T1.RoomTypeDescription, T1.RoomTypeImage
		FROM		dbo.RoomType T1 WITH (NOLOCK)
		INNER JOIN	dbo.Room T2 WITH (NOLOCK)
			ON		T2.RoomTypeID = T1.RoomTypeID
		WHERE		T1.Disabled = 0 
			AND		@NumPerson BETWEEN T2.MinQuantity AND T2.MaxQuantity
		GROUP BY	T1.RoomTypeName, T1.RoomTypePrices, T1.RoomTypeDescription, T1.RoomTypeImage, T1.RoomTypeID
	END
	
	IF (SELECT COUNT(*) FROM dbo.Room WHERE RoomStatus = 'BOOKING') > = 1
	BEGIN
		INSERT INTO	#AvailableRoom2
		SELECT		T4.RoomTypeID, T4.RoomTypeName , T4.RoomTypePrices, T4.RoomTypeDescription, T4.RoomTypeImage
		FROM		dbo.BookingRoom T1 WITH (NOLOCK)
		INNER JOIN	dbo.Booking T2 WITH (NOLOCK)
			ON		T1.BookingID = T2.BookingID
		INNER JOIN	dbo.Room T3 WITH (NOLOCK)
			ON		T1.RoomID = T3.RoomID
		INNER JOIN	dbo.RoomType T4 WITH (NOLOCK)
			ON		T3.RoomTypeID = T4.RoomTypeID
		WHERE		T1.IsBooking = 0 
			AND		@CheckinDate > T2.CheckoutDate
			OR		@CheckoutDate < T2.CheckoutDate	
			AND		T4.Disabled = 0
			AND		@NumPerson BETWEEN T3.MinQuantity AND T3.MaxQuantity
		GROUP BY	T4.RoomTypeID, T4.RoomTypeName , T4.RoomTypePrices, T4.RoomTypeDescription, T4.RoomTypeImage
	END


	SELECT * FROM #AvailableRoom1
	UNION ALL
	SELECT * FROM #AvailableRoom2
	GROUP BY	RoomTypeName,RoomTypePrices,RoomTypeDescription, RoomTypeImage, RoomTypeID

	DROP TABLE #AvailableRoom1
	DROP TABLE #AvailableRoom2


END




GO
/****** Object:  StoredProcedure [dbo].[Find_AvailableServices]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Find_AvailableServices]
(
	@ServicesID INT,
	@DateBook DATETIME
)
AS
BEGIN

	DECLARE @Status TINYINT = 0 

	IF (SELECT COUNT (*) 
		FROM dbo.Services 
		WHERE ServicesID = @ServicesID AND IsAvailable = 1) >= 1
		SET @Status = 1


	IF NOT EXISTS (	SELECT		TOP 1 1
					FROM		dbo.BookingServices T1 WITH (NOLOCK)
					INNER JOIN	dbo.Services T2 WITH (NOLOCK)
						ON		T2.ServicesID = T1.ServicesID
					INNER JOIN  dbo.Booking T3 WITH (NOLOCK)
						ON		T3.BookingID = T1.BookingID
					WHERE		T1.ServicesID = @ServicesID 
						AND		@DateBook = T3.BookDate
						AND		T1.IsBooking = 0)
		SET @Status = 1

END




GO
/****** Object:  StoredProcedure [dbo].[Get_Module]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Get_Module]
(
	@UserName NVARCHAR(250)
)
AS
BEGIN

DECLARE @IsAdmin TINYINT

SELECT TOP 1 @IsAdmin = 1 
FROM		dbo.Account T1 WITH (NOLOCK)
INNER JOIN	dbo.AccountType T2 WITH (NOLOCK)
	ON		T2.AccountTypeID = T1.AccountTypeID
WHERE		T1.UserName = @UserName AND T2.AccountTypeName = 'Admin'

IF (@IsAdmin = 1)
	BEGIN
		SELECT	ModuleID ,ModuleName, ModuleIcon
		FROM	dbo.ModuleList
	END
ELSE
	BEGIN
		SELECT		T1.ModuleID, T3.ModuleName AS ModuleName , T3.ModuleIcon AS ModuleIcon
		FROM		dbo.AccountPermission T1 WITH (NOLOCK)
		INNER JOIN	dbo.Account T2 WITH (NOLOCK)
			ON		T2.AccountID = T1.AccountID
		INNER JOIN	dbo.ModuleList T3 WITH (NOLOCK)
			ON		T3.ModuleID = T1.ModuleID
		WHERE		T2.UserName = @UserName
	END

END




GO
/****** Object:  StoredProcedure [dbo].[sp_dumpparam]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_dumpparam] (@SUName AS varchar(8000),@DumpValue AS int=0)
AS
/*
----- #DUMPPARAM VERSION# 28.06.10
----- Created By Nguyen Binh Minh
----- Created Date: 01/2005
----- Purpose: Lay thong tin cua cac doi tuong
-----@SUName: Ten dong thu tuc va tham so
-----@DumpValue:0, thay the toan bo gia tri tuong ung voi tham so, 1: Tu khai bao bien de thay the,2: Tu khai bao bien de thay the dong thoi tao ten store la DEBUG_TEST de chay debug
----- LastModified By Nguyen Binh Minh on 18/05/2006
----- Purpose: Neu co comment thi bo doan comment di khong xu ly
----- LastModified By Nguyen Binh Minh on 18/05/2006
----- Purpose: Cho xem cac table temp
----- LastModified by Tran Thi Hanh Van on 01/06/2006
----- Purpose: Cho phep xem dien giai cua Field (Unicode)
----- Modified By Nguyen Binh Minh on 21/10/2008
----- Purpose: Sua loi xem kieu nvarchar len 2 kieu du lieu
----- Modified By Nguyen Binh Minh on 12/04/2010
----- Purpose: Xem store hien thi du lieu = unicode
----- Modified By Nguyen Xuan Tien on 21/09/2012: chinh sua SELECT * thanh SELECT TOP 1 1 
*/

DECLARE @Obj_ID AS int
DECLARE @Error AS varchar(100)
DECLARE @Code AS nvarchar(4000)
DECLARE @Line AS nvarchar(4000)
DECLARE @DefinedLength AS int
DECLARE @BlankSpaceAdded AS int
DECLARE @TextLength AS int
DECLARE @AddOnLen AS int
DECLARE @Param AS varchar(8000)
DECLARE @LFCR AS varchar(2)  -- Line feed and return character
DECLARE @Pos AS int 
DECLARE @BasePos AS int 
DECLARE @SpacePos AS int 
DECLARE @CodePos AS int   -- Position of main code
DECLARE @ParamValueBasePos AS int   -- Position of param value 
DECLARE @ParamValuePos AS int   -- Position of param value
DECLARE @CommentPos AS int   -- comment text pos
DECLARE @CommentValue AS varchar(200)  -- comment text
DECLARE @ParamName AS varchar(200)
DECLARE @ParamValue AS varchar(200)
DECLARE @DeclareVar AS varchar(1000)
DECLARE @ParamLine AS varchar(8000)
DECLARE @ObjectName AS varchar(200)
DECLARE @MaxCharShow AS varchar(20)
DECLARE @CountComma AS int
DECLARE @CommaPos AS int
DECLARE @LineCount AS int
DECLARE @ObjectType AS int
DECLARE @ShowCodeOnly AS int
DECLARE @TypeName AS varchar(100)
DECLARE @DateTimeConvertValue AS DateTime
DECLARE @DebugProcedureName AS varchar(100)

DECLARE @ProcType AS int
DECLARE @ViewType AS int
DECLARE @FunctionType AS int
DECLARE @TableType AS int
DECLARE @InTempDB AS int

DECLARE @TriggerType AS int

DECLARE @strSQL AS nvarchar(4000)
SET NOCOUNT ON

SET @ProcType=0
SET @ViewType=1
SET @FunctionType=2
SET @TableType=3
SET @TriggerType=4

SET @LFCR=CHAR(13)+CHAR(10)
SET @DefinedLength=4000
SET @SUName=LTRIM(RTRIM(@SUName))
SET @SpacePos=CHARINDEX(' ',@SUName+' ')
SET @ParamLine=LTRIM(SUBSTRING(@SUName,@SpacePos,LEN(@SUName)))
SET @ParamLine=REPLACE(@ParamLine,CHAR(145),CHAR(39))
SET @ParamLine=REPLACE(@ParamLine,CHAR(146),CHAR(39))
SET @ObjectName=UPPER(SUBSTRING(@SUName,1,@SpacePos))

SET @InTempDB= CASE WHEN LEFT(@ObjectName,1)='#' THEN 1 ELSE 0 END -- In temporary database ?

IF @InTempDB=0
      SET @Obj_ID=OBJECT_ID(@ObjectName)
ELSE
      SET @Obj_ID=OBJECT_ID('TEMPDB..'+@ObjectName)

SET @DebugProcedureName='DEBUG_TEST'

IF @Obj_ID IS NULL
BEGIN
	SET @Error='Invalid object name '''+@ObjectName+''' in database '''+CASE WHEN @InTempDB=0 THEN DB_NAME() ELSE 'TEMPDB' END+''''
	RAISERROR(@Error,0,1)
	RETURN
END

IF @InTempDB=0
      SELECT TOP 1 @ObjectType=(CASE WHEN xtype ='P' THEN @ProcType 
      				WHEN xtype ='V' THEN @ViewType 
      				WHEN xtype='U' OR xtype='S' THEN @TableType 
      				WHEN xtype='TR' THEN @TriggerType
      				ELSE @FunctionType END) FROM SYSOBJECTS WITH(NOLOCK) WHERE  ID=@Obj_ID AND xtype IN ('FN', 'IF', 'TF','P','V','U','S','TR')
ELSE
      SELECT TOP 1 @ObjectType=(CASE WHEN xtype ='P' THEN @ProcType 
      				WHEN xtype ='V' THEN @ViewType 
      				WHEN xtype='U' OR xtype='S' THEN @TableType 
      				WHEN xtype='TR' THEN @TriggerType
      				ELSE @FunctionType END) FROM TEMPDB..SYSOBJECTS WITH(NOLOCK) WHERE  ID=@Obj_ID AND xtype IN ('FN', 'IF', 'TF','P','V','U','S','TR')

IF @ObjectType IS NULL
BEGIN
	SET @Error=''''+@ObjectName+''' is not an FUNCTION/VIEW/STORE PROCEDURE/TRIGGER or TABLE!'
	RAISERROR(@Error,0,1)
	RETURN
END

IF @ObjectType=@TableType
BEGIN
	DECLARE @TempName AS varchar(100)
 	DECLARE @TabColumn AS varchar(200),
		@TabType AS varchar(20),
		@TabDefaultValue AS varchar(1000),
		@TabAllowNull AS char(1),
		@TabDescription AS nvarchar(3000)		

		CREATE TABLE #SysProperties 
		(
			Name 		nvarchar(250),
			id			int,
			smallid 	smallint,
			value		nvarchar(3500)
		)											

		IF OBJECT_ID('SYSPROPERTIES') IS NOT NULL
			INSERT INTO #SysProperties
				SELECT 	Name, id, smallid, ''
				FROM 	SYSPROPERTIES
				WHERE 	ID = @Obj_ID AND name = 'MS_Description'

        IF @InTempDB=0
	      	DECLARE TableInfo_Cur CURSOR LOCAL FOR
	      		SELECT COL.Name AS [Column Name], 
	      			(CASE WHEN TYP.Name like '%char%' THEN TYP.Name +' (' + LTRIM(RTRIM(STR(COL.Length/CASE WHEN TYP.Name LIKE 'n%char%' THEN 2 ELSE 1 END))) + ')'
	      				WHEN TYP.Name ='decimal' THEN TYP.Name +'(' + LTRIM(RTRIM(STR(COL.XPrec))) + ', ' + LTRIM(RTRIM(STR(COL.XScale))) + ')'
	      				ELSE TYP.Name END) AS [Data Type], 
	      			(CASE WHEN IsNullAble = 0 THEN '' ELSE 'X' END) AS [IsNull],
	      			(CASE WHEN IsNull(COM.Text, '') = '' THEN '' ELSE SUBSTRING(COM.Text,2,LEN(COM.Text)-2) END) AS [Default],
				IsNull(SP.value, '') as [Description]
			FROM SYSCOLUMNS COL  WITH(NOLOCK)
			INNER JOIN SYSOBJECTS TAB  WITH(NOLOCK) ON COL.ID = TAB.ID 
			INNER JOIN SYSTYPES TYP  WITH(NOLOCK) ON TYP.XType = COL.XType AND TYP.Name <> 'sysname'
			LEFT JOIN SYSOBJECTS TAB2  WITH(NOLOCK) ON TAB2.ID = COL.CDefault 
			LEFT JOIN SYSCOMMENTS COM  WITH(NOLOCK) ON COM.ID = TAB2.ID
			LEFT JOIN #Sysproperties SP ON SP.id = TAB.id 
										AND SP.smallid = COL.colid
			WHERE TAB.ID=@Obj_ID
			ORDER BY COL.ColOrder
        ELSE
	      	DECLARE TableInfo_Cur CURSOR LOCAL FOR
	      		SELECT COL.Name AS [Column Name], 
	      			(CASE WHEN TYP.Name like '%char%' THEN TYP.Name +' (' + LTRIM(RTRIM(STR(COL.Length/CASE WHEN TYP.Name LIKE 'n%char%' THEN 2 ELSE 1 END))) + ')'
	      				WHEN TYP.Name ='decimal' THEN TYP.Name +'(' + LTRIM(RTRIM(STR(COL.XPrec))) + ', ' + LTRIM(RTRIM(STR(COL.XScale))) + ')'
	      				ELSE TYP.Name END) AS [Data Type], 
	      			(CASE WHEN IsNullAble = 0 THEN '' ELSE 'X' END)  AS [IsNull],
	      			(CASE WHEN IsNull(COM.Text, '') = '' THEN '' ELSE SUBSTRING(COM.Text,2,LEN(COM.Text)-2) END) AS [Default],
					IsNull(CAST(SP.value AS nvarchar(3000)), '') as [Description]	
				FROM TEMPDB..SYSCOLUMNS COL  WITH(NOLOCK)
				INNER JOIN TEMPDB..SYSOBJECTS TAB WITH(NOLOCK) ON COL.ID = TAB.ID 
				INNER JOIN TEMPDB..SYSTYPES TYP WITH(NOLOCK) ON TYP.XType = COL.XType AND TYP.Name <> 'sysname'
				LEFT JOIN TEMPDB..SYSOBJECTS TAB2 WITH(NOLOCK) ON TAB2.ID = COL.CDefault 
				LEFT JOIN TEMPDB..SYSCOMMENTS COM WITH(NOLOCK) ON COM.ID = TAB2.ID
				LEFT JOIN #Sysproperties SP ON SP.name = 'MS_Description' 
									AND SP.id = TAB.id 
									AND SP.smallid = COL.colid
				WHERE TAB.ID=@Obj_ID
				ORDER BY COL.ColOrder

	SET @MaxCharShow=100
	SET @TempName='##'+SUBSTRING(CAST (CONVERT(DECIMAL(17,17),RAND()) AS CHAR(19)),3,19) -- Not duplicated name
	SET @strSQL='CREATE TABLE '+@TempName+' ([Column Name] varchar(100),[Description] nvarchar(3000),[Data Type] varchar(100),[IsNull] char(1),[Default] varchar(100),
			[First Value] varchar('+@MaxCharShow+'),[Second Value] varchar('+@MaxCharShow+'),[Third Value] varchar('+@MaxCharShow+'))'
	EXEC(@strSQL)  -- Create temp table

      	IF @InTempDB=1 SET @ObjectName = 'TEMPDB..'+@ObjectName

	OPEN TableInfo_Cur
 	FETCH NEXT FROM TableInfo_Cur INTO @TabColumn,@TabType,@TabAllowNull,@TabDefaultValue,@TabDescription

 	WHILE @@FETCH_STATUS=0

 	BEGIN
		IF UPPER(@TabColumn) IN ('SELECT','PERCENT') OR @TabColumn LIKE '%[0-9#$^&*-+|!@]%'
			SET @Tabcolumn='['+@Tabcolumn+']'
 		SET @strSQL='DECLARE @Value01 AS varchar('+@MaxCharShow+'),@Value02 AS varchar('+@MaxCharShow+'),@Value03 AS varchar('+@MaxCharShow+')'+@LFCR
   SET @strSQL=@strSQL+CASE WHEN @TabType<>'image' THEN 
                        'SELECT TOP 1 @Value01=CONVERT (VARCHAR('+@MaxCharShow+'),'+@TabColumn+(CASE WHEN CHARINDEX('DATETIME',@TabType)=1 THEN ',121' ELSE '' END)+') FROM '+@ObjectName+'
				IF @@ROWCOUNT<>1' ELSE '' END++@LFCR
            SET @strSQL=@strSQL+'
					SET @Value01=''?'''+@LFCR
            SET @strSQL=@strSQL+CASE WHEN @TabType<>'image' THEN 
                        'SELECT TOP 2 @Value02=CONVERT (VARCHAR('+@MaxCharShow+'),'+@TabColumn+(CASE WHEN CHARINDEX('DATETIME',@TabType)=1 THEN ',121' ELSE '' END)+') FROM '+@ObjectName+'
				IF @@ROWCOUNT<>2' ELSE '' END+@LFCR
            SET @strSQL=@strSQL+'
					SET @Value02=''?'''+@LFCR
            SET @strSQL=@strSQL+CASE WHEN @TabType<>'image' THEN 
                        'SELECT TOP 1 @Value03=CONVERT (VARCHAR('+@MaxCharShow+'),'+@TabColumn+(CASE WHEN CHARINDEX('DATETIME',@TabType)=1 THEN ',121' ELSE '' END)+') FROM '+@ObjectName+'
				IF @@ROWCOUNT<>3' ELSE '' END+@LFCR
            SET @strSQL=@strSQL+'
					SET @Value03=''?'''+@LFCR
            SET @strSQL=@strSQL+'
		INSERT INTO '+@TempName+' ([Column Name],[Description],[Data Type],[IsNull],[Default],[First Value],[Second Value],[Third Value])
		VALUES ('''+@TabColumn+''',N'''+@TabDescription+''','''+@TabType+''','''+@TabAllowNull+''','''+REPLACE(@TabDefaultValue,'''', '''''')+''',@Value01,@Value02,@Value03)'
		EXEC(@strSQL)
	 	FETCH NEXT FROM TableInfo_Cur INTO @TabColumn,@TabType,@TabAllowNull,@TabDefaultValue,@TabDescription
 	END
 	EXECUTE('SELECT * FROM '+@TempName)
	EXEC('DROP TABLE '+@TempName)
	RETURN
END

SET @TypeName=(CASE @ObjectType WHEN @ProcType THEN 'Procedure' WHEN @ViewType THEN 'View' WHEN @FunctionType THEN 'Function' WHEN @TriggerType THEN 'Trigger' END)
SET @ShowCodeOnly=(CASE WHEN (@ParamLine='' AND @DumpValue=0) OR @ObjectType=@ViewType THEN 1 ELSE 0 END)  -- Chi xem code, khong tu dong xu ly code

-- Build code into lines
CREATE TABLE #CodeLine  -- line by line
(LineId int ,Text  nvarchar(4000) collate database_default)

DECLARE Code_Cur CURSOR LOCAL FOR
	SELECT text FROM SYSCOMMENTS WHERE ID=@Obj_ID AND Encrypted=0
	ORDER BY Number,Colid FOR READ ONLY
OPEN Code_Cur

SET @BlankSpaceAdded = 0 /*Keeps track of blank spaces at end of lines. Note Len function ignores
                             trailing blank spaces*/
SET @LineCount=0
FETCH NEXT FROM Code_Cur INTO @Code
WHILE @@FETCH_STATUS >= 0
BEGIN
	SET  @BasePos    = 1
	SET  @Pos = 1
	SET  @TextLength = LEN(@Code)
	
	WHILE @Pos  != 0
	BEGIN
		--Looking for end of line followed by carriage return
		SET @Pos =   CHARINDEX(@LFCR, @Code, @BasePos)
		
		--If carriage return found
		IF @Pos != 0
		BEGIN
			/*If new value for @Lines length will be > then the
			**set length then insert current contents of @line
			**and proceed.
			*/
			WHILE (IsNull(LEN(@Line),0) + @BlankSpaceAdded + @Pos-@BasePos + LEN(@LFCR)) > @DefinedLength
			BEGIN
				SET @AddOnLen = @DefinedLength-(IsNull(LEN(@Line),0) + @BlankSpaceAdded)
				INSERT #CodeLine VALUES
				( @LineCount,IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @AddOnLen), N''))
				SELECT @Line = NULL, @LineCount = @LineCount + 1,@BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0
			END
			SET @Line = IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @Pos-@BasePos + LEN(@LFCR)), N'')
			SET @BasePos = @Pos+2
			INSERT #CodeLine VALUES( @LineCount, @Line )
			SET @LineCount = @LineCount + 1
			SET @Line = NULL
		END
		ELSE
			--else carriage return not found
			BEGIN
				IF @BasePos <= @TextLength
				BEGIN
				/*If new value for @Lines length will be > then the
				**defined length
				*/
					WHILE (IsNull(LEN(@Line),0) + @BlankSpaceAdded + @TextLength-@BasePos+1 ) > @DefinedLength
					BEGIN
						SET @AddOnLen = @DefinedLength - (IsNull(LEN(@Line),0) + @BlankSpaceAdded)
						INSERT #CodeLine VALUES
						( @LineCount,
						IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @AddOnLen), N''))
						SELECT @Line = NULL, @LineCount = @LineCount + 1,@BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0
					END
					SET @Line = IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @TextLength-@BasePos+1 ), N'')
					IF LEN(@Line) < @DefinedLength and charindex(' ', @Code, @TextLength+1 ) > 0
						SELECT @Line = @Line + ' ', @BlankSpaceAdded = 1
				END
			END
	END	
	FETCH NEXT FROM Code_Cur into @Code
END

IF @Line is NOT NULL
	INSERT #CodeLine VALUES( @LineCount, @Line )

IF @LineCount=0 -- no line return
BEGIN
	SET @Error=@TypeName+' '''+@ObjectName+''' has contains no line!'
	RAISERROR(@Error,0,1)
END

-- Out for process
DECLARE Code_Line CURSOR  LOCAL FOR
	SELECT text FROM #CodeLine ORDER BY LineID 
	FOR READ ONLY
OPEN Code_Line

IF @DumpValue=2 -- Create procedure for debugger
BEGIN
	SET @strSQL='IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N''[DBO].['+@DebugProcedureName+']'') AND '
	SET @strSQL= @strSQL+'OBJECTPROPERTY(ID, N''IsProcedure'') = 1)'  -- Is Procedure
	SET @strSQL=@strSQL+@LFCR+'DROP PROCEDURE [DBO].['+@DebugProcedureName+']'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET QUOTED_IDENTIFIER ON'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET ANSI_NULLS ON'
	SET @strSQL=@strSQL+@LFCR+'GO'+@LFCR+@LFCR
	SET  @strSQL=@strSQL+@LFCR+'---------------- SP_Dumpparam procedure generator for DEBUG'
	SET  @strSQL=@strSQL+@LFCR+'CREATE PROCEDURE ['+@DebugProcedureName+']'
	SET  @strSQL=@strSQL+@LFCR+'AS'
	PRINT @strSQL 
END

IF @ShowCodeOnly=1 
BEGIN
	SET @strSQL='IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N''[DBO].['+@ObjectName+']'') AND '
	IF @ObjectType=@ProcType
		SET @strSQL= @strSQL+'OBJECTPROPERTY(ID, N''IsProcedure'') = 1)'  -- Is Procedure
	IF @ObjectType=@ViewType
		SET @strSQL=@strSQL+'OBJECTPROPERTY(ID, N''IsView'') = 1)'  -- Is View
	IF @ObjectType=@FunctionType
		SET @strSQL=@strSQL+'XTYPE IN (N''FN'', N''IF'', N''TF''))' -- Is Function
	IF @ObjectType=@TriggerType
		SET @strSQL=@strSQL+'OBJECTPROPERTY(ID, N''IsTrigger'') = 1)'  -- Is Trigger

	SET @strSQL=@strSQL+@LFCR+'DROP '+UPPER(@TypeName)+' [DBO].['+@ObjectName+']'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET QUOTED_IDENTIFIER ON'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET ANSI_NULLS ON'
	SET @strSQL=@strSQL+@LFCR+'GO'+@LFCR+@LFCR
	IF @ObjectType IN (@ProcType,@ViewType,@FunctionType,@TriggerType)
		PRINT @strSQL 
	GOTO lbShowCodeOnly  --- Ignore all when show code only
END

FETCH NEXT FROM Code_Line INTO @Code
WHILE (@@Fetch_Status=0)  -- Find first param macth, it means after define procedure line
BEGIN
	SET @Code=REPLACE(@Code,CHAR(9),' ')  -- convert tab to space
	SET @BasePos=CHARINDEX('CREATE ' ,@Code)  -- Defintion
      IF @BasePos>0
      BEGIN
           IF CHARINDEX(@TypeName,LTRIM(SUBSTRING(@Code,@BasePos+LEN('CREATE '),LEN(@Code)))) =1  -- Is first definition  ?
      		BREAK
      END
	FETCH NEXT FROM Code_Line INTO @Code
END

-- Process to find params
CREATE TABLE #Param  -- params table
(DeclareVar varchar(1000),Name varchar(200),Value varchar(1000),Comment varchar(200) COLLATE database_default)
SET @CodePos=0 
SET @ParamValueBasePos=0
SET @BasePos = 0
WHILE (@@Fetch_Status=0)
BEGIN
	SET @Code=REPLACE(@Code,CHAR(9),' ')  -- convert tab to space
	SET @CommentPos=CHARINDEX('--',@Code,@BasePos) -- comment
      IF @CommentPos>0 
            SET @Code=LEFT(@Code, @CommentPos-1)
	SET @Pos=CHARINDEX('@',@Code,@BasePos)
	WHILE @Pos>0 
	BEGIN
		SET @CodePos=CHARINDEX('AS',@Code,@BasePos)  -- Is code position ?
		SET @SpacePos=CHARINDEX(' ',@Code+' ',@Pos)
		IF (@CodePos=0) OR (@CodePos>@Pos)
		BEGIN
			SET @ParamValuePos=CHARINDEX(',',@ParamLine+',',@ParamValueBasePos)
			SET @ParamName=LTRIM(RTRIM(SUBSTRING(@Code,@Pos,@SpacePos-@Pos)))
			SET @BasePos=CHARINDEX(',',@Code,@SpacePos)
			---- Test comma in string  ?
			SET @CountComma=0
			SET @CommaPos=CHARINDEX('''',@ParamLine,@ParamValueBasePos)
lbTestComma:
			WHILE @CommaPos<@ParamValuePos AND @CommaPos>0
			BEGIN
				SET @CountComma=@CountComma+1
				SET @CommaPos=CHARINDEX('''',@ParamLine,@CommaPos+1)
			END
			IF @CountComma%2>0   -- comma in string, find next position
			BEGIN
				SET @ParamValuePos=CHARINDEX(',',@ParamLine+',',@ParamValuePos+1)
				GOTO lbTestComma -- continue for testing
			END
			IF @ParamValuePos>0
			BEGIN					
				SET @CommentPos=CHARINDEX('--',@Code,@Pos)
				SET @DeclareVar=RTRIM(SUBSTRING(@Code,@Pos,(CASE WHEN @BasePos=0 THEN 
												(CASE WHEN @CommentPos>0 AND @CommentPos<@ParamValuePos THEN @CommentPos ELSE  LEN(@Code)+1 END)
											       ELSE @BasePos END)-@Pos))				
				SET @ParamValue=SUBSTRING(@ParamLine,@ParamValueBasePos,@ParamValuePos-@ParamValueBasePos)
				IF CHARINDEX(' DATETIME',@DeclareVar)>0  AND LTRIM(RTRIM(@ParamValue))<>'NULL'-- Date time value ?
				BEGIN					
					SET @ParamValue=CONVERT(VARCHAR(50),CAST(REPLACE(@ParamValue,'''','') AS DATETIME),121)
 					IF CHARINDEX('00:00:00.000',@ParamValue)>0  -- only date
 					BEGIN	
 						SET @ParamValue=LEFT(@ParamValue, CHARINDEX('00:00:00.000',@ParamValue)-1)
 					END
					SET @ParamValue='CAST('''+@ParamValue+''' AS DATETIME)'
				END
				IF CHARINDEX(' VARCHAR',@DeclareVar)>0 OR CHARINDEX(' CHAR',@DeclareVar)>0 
				BEGIN				
					IF CHARINDEX('''',@ParamValue)=0 AND UPPER(RTRIM(LTRIM(@ParamValue)))<>'NULL'
						SET @ParamValue=''''+@ParamValue+''''
				END
				SET @ParamValueBasePos=@ParamValuePos+1
				SET @DeclareVar=RTRIM(REPLACE(@DeclareVar,@LFCR,''))  -- Remove caterine return line feed code
				IF RIGHT(REPLACE(@DeclareVar,' ',''),2)='))'  -- Last param and end with ) ?
					SET @DeclareVar=LEFT(@DeclareVar,LEN(@DeclareVar)-1)
				INSERT INTO #Param(DeclareVar,Name,Value) VALUES (@DeclareVar,@ParamName,@ParamValue)
			END
			ELSE
			BEGIN -- param not enought ?
				SET @Error=''''+@ObjectName+''' expects parameter '+@ParamName+', which was not supplied.'
				RAISERROR(@Error,0,1)
				RETURN
			END
			IF @BasePos=0  -- last param ?
				GOTO lbParamProcess
			ELSE
				SET @Pos=CHARINDEX('@',@Code,@BasePos)
		END
		ELSE
			GOTO lbParamProcess
	END
	SET @BasePos=0
	FETCH NEXT FROM Code_Line INTO @Code
END
lbParamProcess:
-- Out for view
DECLARE Param_Line CURSOR  LOCAL SCROLL FOR
	SELECT DeclareVar,Name,Value FROM #Param
	FOR READ ONLY
OPEN Param_Line
IF @DumpValue=0
	PRINT  '/* ------------------------------------------------------------------------------------------------------------------------------------'
FETCH NEXT FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue
WHILE (@@Fetch_Status=0)
BEGIN
	IF LEN(@DeclareVar)+LEN(@ParamName)+LEN(@ParamValue)>80 -- Line too long
	BEGIN
		PRINT 'DECLARE '+@DeclareVar
		PRINT '     SET '+@ParamName+'='+@ParamValue
	END
	ELSE
		PRINT 'DECLARE '+@DeclareVar+'  SET '+@ParamName+'='+@ParamValue
	FETCH NEXT FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue
END
IF @DumpValue=0
	PRINT  ' ------------------------------------------------------------------------------------------------------------------------------------*/'
-- Is definition line of procedure ?
FETCH  FROM Code_Line INTO @Code
WHILE (@@Fetch_Status=0) AND CHARINDEX('AS',LTRIM(@Code))<>1 
BEGIN
	FETCH NEXT FROM Code_Line INTO @Code
END

lbShowCodeOnly: --- Ignore all for show code

FETCH NEXT FROM Code_Line INTO @Code   -- Ignore definition of procedure
WHILE (@@Fetch_Status=0)
BEGIN
	IF @DumpValue=0 AND @ShowCodeOnly=0
	BEGIN
		FETCH FIRST FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue  ----Fill param with param value
		WHILE (@@Fetch_Status=0)  -- process line by line
		BEGIN
			SET @BasePos=0
			SET @Pos=CHARINDEX(@ParamName,@Code,@BasePos)  -- Find param in code
			WHILE (@Pos>0)  -- Replace all param with param value
			BEGIN
				IF CHARINDEX(SUBSTRING(@Code+' ',@Pos+LEN(@ParamName),1) ,' ,=()<>+-* /%#@|\^'+CHAR(9)+CHAR(10)+CHAR(13))>0  -- Param must be seperated by ,=()<>+-*/(TAB)(CRLF)
				BEGIN
					SET @Code=STUFF (@Code,@Pos,LEN(@ParamName),@ParamValue) -- Replace
					SET @BasePos=@Pos+LEN(@ParamValue)
				END
				ELSE 
					SET @BasePos=@Pos+1 -- next value
				SET @Pos=CHARINDEX(@ParamName,@Code,@BasePos)
			END
			FETCH NEXT FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue  ----continue next line
		END
	END
	PRINT @Code  -- Show code in Result Text Window
	FETCH NEXT FROM Code_Line INTO @Code
END

IF @ShowCodeOnly=1 -- End declare
BEGIN
	SET @strSQL=@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET QUOTED_IDENTIFIER OFF'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET ANSI_NULLS ON'
	SET @strSQL=@strSQL+@LFCR+'GO'+@LFCR+@LFCR
	IF @ObjectType IN (@ProcType,@ViewType,@FunctionType,@TriggerType)
		PRINT @strSQL 
END












GO
/****** Object:  StoredProcedure [dbo].[Store_Login]    Script Date: 25/10/2020 18:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Store_Login]
(
	@UserName NVARCHAR(250) ,
	@Password NVARCHAR(250)
)
AS
BEGIN

SELECT *
FROM dbo.Account 
WHERE UserName = @UserName AND Password = @Password AND Disabled = 0

END




GO
USE [master]
GO
ALTER DATABASE [QLKSWEB] SET  READ_WRITE 
GO
