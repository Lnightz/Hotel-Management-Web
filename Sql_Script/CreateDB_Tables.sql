USE master 
IF EXISTS (SELECT TOP 1 1 FROM sys.databases WHERE name = 'QLKSWEB')
	DROP DATABASE QLKSWEB
GO

CREATE DATABASE QLKSWEB
GO

USE QLKSWEB
GO

CREATE TABLE AccountType 
(
	AccountTypeID INT PRIMARY KEY IDENTITY(0,5),
	AccountTypeName NVARCHAR(250),
	Disabled TINYINT NOT NULL DEFAULT '0'
) 

CREATE TABLE Account
(
	AccountID INT PRIMARY KEY IDENTITY (0,5),
	UserName VARCHAR(100) NOT NULL,
	Password VARCHAR(100) NOT NULL DEFAULT '123',
	Disabled TINYINT NOT NULL DEFAULT '0',
	AccountTypeID INT NOT NULL,
	Image NVARCHAR(250)

FOREIGN KEY (AccountTypeID) REFERENCES dbo.AccountType (AccountTypeID)
)

CREATE TABLE Promotion
(
	PromotionID INT PRIMARY KEY IDENTITY (0,5),
	PromotionName NVARCHAR(250),
	PercentDiscount DECIMAL(19,4),
	PromotionContent NVARCHAR(MAX),
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME
FOREIGN KEY (CreatedUserID) REFERENCES dbo.Account (AccountID)
)

CREATE TABLE Customer 
(
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	CustomerName NVARCHAR(250),
	BirthDay DATETIME,
	Gender NVARCHAR(50),
	Phone VARCHAR(50),
	Email VARCHAR(100),
	Passport VARCHAR(50) NOT NULL,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME
)


CREATE TABLE ServicesType
(
	ServicesTypeID INT PRIMARY KEY IDENTITY(0,5),
	ServicesTypeName NVARCHAR(250),
	Disabled TINYINT NOT NULL DEFAULT 0,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME
)

CREATE TABLE EquipmentType
(
	EquipmentTypeID INT PRIMARY KEY IDENTITY(1,1),
	EquipmentTypeName NVARCHAR(250),
	Disabled TINYINT NOT NULL DEFAULT 0,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME

)

CREATE TABLE RequestType
(
	RequestTypeID INT PRIMARY KEY IDENTITY(1,1),
	RequestTypeName NVARCHAR(250),
	Disabled TINYINT NOT NULL DEFAULT 0,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME
)

CREATE TABLE RoomType
(
	RoomTypeID INT PRIMARY KEY IDENTITY (0,5),
	RoomTypeName NVARCHAR(250),
	RoomTypePrices DECIMAL(19,4),
	RoomTypeDescription NVARCHAR(MAX),
	Disabled TINYINT NOT NULL DEFAULT 0,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME,
	IsPay TINYINT DEFAULT 0,
	IsShowHomePage TINYINT DEFAULT 0, -- 0 không show, 1: show
	IsShow TINYINT DEFAULT 0 -- 0: không show, 1: show
)

CREATE TABLE Room
(
	RoomID INT PRIMARY KEY IDENTITY (1,1),
	RoomName NVARCHAR(250),
	RoomStatus NVARCHAR(100),
	RoomNotes NVARCHAR(250),
	RoomDescription NVARCHAR(500),
	MinQuantity INT,
	MaxQuantity INT,
	RoomTypeID INT NOT NULL,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME,
	Image NVARCHAR(250)

FOREIGN KEY (RoomTypeID) REFERENCES dbo.RoomType(RoomTypeID)
)

CREATE TABLE Equipment 
(
	EquipmentID INT PRIMARY KEY IDENTITY (1,1),
	EquipmentName NVARCHAR(250),
	EquipPrices DECIMAL (19,4),
	DateBuy DATETIME,
	EquipStatus TINYINT NOT NULL DEFAULT 0,
	EquipmentTypeID INT NOT NULL,
	RoomID INT NOT NULL,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME,
	Image NVARCHAR(250)

FOREIGN KEY (EquipmentTypeID) REFERENCES dbo.EquipmentType(EquipmentTypeID),
FOREIGN KEY (RoomID) REFERENCES dbo.Room(RoomID)
)

CREATE TABLE Services
(
	ServicesID INT PRIMARY KEY IDENTITY (1,1),
	ServicesName NVARCHAR(250),
	ServicesDescription NVARCHAR(500),
	ServicesContent NVARCHAR(MAX),
	ServicesPrices DECIMAL (19,4),
	Unit NVARCHAR(100),
	ServicesDetail NVARCHAR(250),
	ServicesTypeID INT NOT NULL,
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME,
	IsAvailable TINYINT DEFAULT 0, -- 0: khả dụng, 1: không khả dụng
	IsPay TINYINT DEFAULT 0, -- 0: không pay, 1: pay
	IsShowHomePage TINYINT DEFAULT 0, -- 0 không show, 1: show
	IsShow TINYINT DEFAULT 0, -- 0: không show, 1: show
	Image NVARCHAR(250)

FOREIGN KEY (ServicesTypeID) REFERENCES dbo.ServicesType(ServicesTypeID)
)

CREATE TABLE MaintenanceHistory
(
	HistoryID INT PRIMARY KEY IDENTITY (1,1),
	Description NVARCHAR(250),
	DateMaintenance DATETIME,
	DateFinished DATETIME,
	MaintenancePrices DECIMAL(19,4),
	EquipmentID INT NOT NULL,

FOREIGN KEY (EquipmentID) REFERENCES dbo.Equipment (EquipmentID)
)

CREATE TABLE Request
(
	RequestID INT PRIMARY KEY IDENTITY (1,1),
	RequesterName NVARCHAR(250),
	Prices DECIMAL (19,4),
	RequestDescription NVARCHAR(500),
	RequestTypeID INT NOT NULL,
	EquipmentID INT NOT NULL, 
	RoomID INT NOT NULL,
	RequestStatus NVARCHAR(100),
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME

FOREIGN KEY (RequestTypeID) REFERENCES dbo.RequestType(	RequestTypeID),
FOREIGN KEY (RoomID) REFERENCES dbo.Room(RoomID),
FOREIGN KEY (EquipmentID) REFERENCES dbo.Equipment (EquipmentID)
)


CREATE TABLE Booking 
(
	BookingID INT PRIMARY KEY IDENTITY (1,1),
	BookDate DATETIME,
	CheckinDate DATETIME,
	CheckoutDate DATETIME,
	Deposit DECIMAL (19,4),
	BookingType NVARCHAR(250),
	BookingStatus NVARCHAR(250),
	BookingNotes NVARCHAR(500),
	CreatedUserID int,
	CustomerID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME
FOREIGN KEY (CreatedUserID) REFERENCES dbo.Account (AccountID),
FOREIGN KEY (CustomerID) REFERENCES dbo.Customer (CustomerID)
)

CREATE TABLE Bill
(
	BillID INT PRIMARY KEY IDENTITY(1,1),
	CheckinDate DATETIME,
	CheckoutDate DATETIME,
	Deposit DECIMAL (19,4),
	Discount DECIMAL (19,4),
	BillStatus NVARCHAR(100) NOT NULL,
	Total DECIMAL (19,4),
	Notes NVARCHAR(500),
	CreatedUserID INT,
	ModifyUserID INT,
	DateCreated DATETIME DEFAULT GETDATE(),
	DateModify DATETIME

FOREIGN KEY (CreatedUserID) REFERENCES dbo.Account (AccountID)
)

CREATE TABLE BillDetail
(
	BillDetailID INT PRIMARY KEY IDENTITY (1,1),
	Quantity INT,
	TotalSerivcesPrices DECIMAL (19,4),
	Compensation DECIMAL (19,4),
	ServicesID INT,
	RoomID INT,
	BillID INT,

	
FOREIGN KEY (ServicesID) REFERENCES dbo.Services (ServicesID),
FOREIGN KEY (RoomID) REFERENCES dbo.Room (RoomID),
FOREIGN KEY (BillID) REFERENCES dbo.Bill (BillID) 
)


CREATE TABLE BookingRoom
(
	BookingRoomID INT IDENTITY PRIMARY KEY,
	BookingID INT ,
	RoomID INT,
	IsBooking TINYINT DEFAULT 0
FOREIGN KEY (BookingID) REFERENCES dbo.Booking(BookingID),
FOREIGN KEY (RoomID) REFERENCES dbo.Room (RoomID)
)

CREATE TABLE BookingServices
(
	BookingServicesID INT IDENTITY PRIMARY KEY,
	BookingID INT,
	ServicesID INT,
	Quantity INT,
	IsBooking TINYINT DEFAULT 0
FOREIGN KEY (BookingID) REFERENCES dbo.Booking(BookingID),
FOREIGN KEY (ServicesID) REFERENCES dbo.Services (ServicesID)
)

CREATE TABLE RoomServices
(
	RoomServicesID INT PRIMARY KEY IDENTITY,
	RoomID INT,
	ServicesID INT,
FOREIGN KEY (RoomID) REFERENCES dbo.Room (RoomID),
FOREIGN KEY (ServicesID) REFERENCES dbo.Services (ServicesID)
)

CREATE TABLE RoomRequest
(
	RoomRequestID INT PRIMARY KEY IDENTITY,
	RoomID INT,
	RequestID INT,
FOREIGN KEY (RequestID) REFERENCES dbo.Request (RequestID),
FOREIGN KEY (RoomID) REFERENCES dbo.Room (RoomID)
)

CREATE TABLE EquipRequest
(
	EquipRequestID INT PRIMARY KEY,
	RequestID INT,
	EquipID INT,
	Quantity INT
FOREIGN KEY (RequestID) REFERENCES dbo.Request (RequestID),
FOREIGN KEY (EquipID) REFERENCES dbo.Equipment (EquipmentID)
)


CREATE TABLE ModuleList
(
	ModuleID INT PRIMARY KEY IDENTITY (19,4),
	ModuleName NVARCHAR(250),
	ModuleIcon NVARCHAR(250)
)

CREATE TABLE AccountPermission
(
	AccPerID INT PRIMARY KEY IDENTITY,
	AccountID INT,
	ModuleID INT,
	Permission INT,
FOREIGN KEY (AccountID) REFERENCES dbo.Account(AccountID),
FOREIGN KEY (ModuleID) REFERENCES dbo.ModuleList(ModuleID)
)

