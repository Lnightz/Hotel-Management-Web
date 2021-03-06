IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[Find_AvailableRoom]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[Find_AvailableRoom]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE Find_AvailableRoom
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
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

