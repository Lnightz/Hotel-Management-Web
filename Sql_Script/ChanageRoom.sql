IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[ChangeRoom]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[ChangeRoom]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE ChangeRoom
(
	@BillID INT ,
	@RoomID INT,
	@ChangeRoomID INT,
	@BookingID INT 
)
AS
BEGIN

		IF (@BillID <> NULL)
		BEGIN
			UPDATE dbo.BillDetail
			SET		RoomID = @ChangeRoomID
			WHERE BillID = @BillID

			UPDATE dbo.Room
			SET		RoomStatus = 'OPEN'
			WHERE	RoomID = @RoomID
			SELECT 1 RETURN
		END	

		IF (@BookingID <> NULL)
		BEGIN
			UPDATE dbo.BookingRoom
			SET		RoomID = @ChangeRoomID
			WHERE BookingID = @BookingID 

			UPDATE dbo.Room
			SET		RoomStatus = 'OPEN'
			WHERE	RoomID = @RoomID
			SELECT 1 RETURN
		END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

