IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[Find_AvailableServices]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[Find_AvailableServices]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE Find_AvailableServices
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
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

